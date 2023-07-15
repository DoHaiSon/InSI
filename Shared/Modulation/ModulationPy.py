# coding: utf-8
# Source: https://pypi.org/project/ModulationPy/

import numpy as np


class Modem:

  def __init__(self,
               M,
               gray_map=True,
               bin_input=True,
               soft_decision=True,
               bin_output=True):

    N = np.log2(M)  # bits per symbol
    if N != np.round(N):
      raise ValueError("M should be 2**n, with n=1, 2, 3...")
    if soft_decision == True and bin_output == False:
      raise ValueError("Non-binary output is available only for hard decision")

    self.M = M  # modulation order
    self.N = int(N)  # bits per symbol
    self.m = [i for i in range(self.M)]
    self.gray_map = gray_map
    self.bin_input = bin_input
    self.soft_decision = soft_decision
    self.bin_output = bin_output

  ''' SERVING METHODS '''

  def __gray_encoding(self, dec_in):
    """ Encodes values by Gray encoding rule.

        Parameters
        ----------
        dec_in : list of ints
            Input sequence of decimals to be encoded by Gray.
        Returns
        -------
        gray_out: list of ints
            Output encoded by Gray sequence.
        """

    bin_seq = [np.binary_repr(d, width=self.N) for d in dec_in]
    gray_out = []
    for bin_i in bin_seq:
      gray_vals = [
        str(int(bin_i[idx]) ^ int(bin_i[idx - 1])) if idx != 0 else bin_i[0]
        for idx in range(0, len(bin_i))
      ]
      gray_i = "".join(gray_vals)
      gray_out.append(int(gray_i, 2))
    return gray_out

  def create_constellation(self, m, s):
    """ Creates signal constellation.
        Parameters
        ----------
        m : list of ints
            Possible decimal values of the signal constellation (0 ... M-1).
        s : list of complex values
            Possible coordinates of the signal constellation.
        Returns
        -------
        dict_out: dict
            Output dictionary where
            key is the bit sequence or decimal value and
            value is the complex coordinate.
        """

    if self.bin_input == False and self.gray_map == False:
      dict_out = {k: v for k, v in zip(m, s)}
    elif self.bin_input == False and self.gray_map == True:
      mg = self.__gray_encoding(m)
      dict_out = {k: v for k, v in zip(mg, s)}
    elif self.bin_input == True and self.gray_map == False:
      mb = self.de2bin(m)
      dict_out = {k: v for k, v in zip(mb, s)}
    elif self.bin_input == True and self.gray_map == True:
      mg = self.__gray_encoding(m)
      mgb = self.de2bin(mg)
      dict_out = {k: v for k, v in zip(mgb, s)}
    return dict_out

  def llr_preparation(self):
    """ Creates the coordinates
        where either zeros or ones can be placed in the signal constellation..
        Returns
        -------
        zeros : list of lists of complex values
            The coordinates where zeros can be placed in the signal constellation.
        ones : list of lists of complex values
            The coordinates where ones can be placed in the signal constellation.
        """
    code_book = self.code_book

    zeros = [[] for i in range(self.N)]
    ones = [[] for i in range(self.N)]

    bin_seq = self.de2bin(self.m)

    for bin_idx, bin_symb in enumerate(bin_seq):
      if self.bin_input == True:
        key = bin_symb
      else:
        key = bin_idx
      for possition, digit in enumerate(bin_symb):
        if digit == '0':
          zeros[possition].append(code_book[key])
        else:
          ones[possition].append(code_book[key])
    return zeros, ones

  ''' DEMODULATION ALGORITHMS '''

  def __ApproxLLR(self, x, noise_var):
    """ Calculates approximate Log-likelihood Ratios (LLRs) [1].
        Parameters
        ----------
        x : 1-D ndarray of complex values
            Received complex-valued symbols to be demodulated.
        noise_var: float
            Additive noise variance.
        Returns
        -------
        result: 1-D ndarray of floats
            Output LLRs.
        Reference:
            [1] Viterbi, A. J., "An Intuitive Justification and a
                Simplified Implementation of the MAP Decoder for Convolutional Codes,"
                IEEE Journal on Selected Areas in Communications,
                vol. 16, No. 2, pp 260–264, Feb. 1998

        """

    zeros = self.zeros
    ones = self.ones
    LLR = []
    for (zero_i, one_i) in zip(zeros, ones):
      num = [((np.real(x) - np.real(z))**2) + ((np.imag(x) - np.imag(z))**2)
             for z in zero_i]
      denum = [((np.real(x) - np.real(o))**2) + ((np.imag(x) - np.imag(o))**2)
               for o in one_i]

      num_post = np.amin(num, axis=0, keepdims=True)
      denum_post = np.amin(denum, axis=0, keepdims=True)

      llr = np.transpose(num_post[0]) - np.transpose(denum_post[0])
      LLR.append(-llr / noise_var)

    result = np.zeros((len(x) * len(zeros)))
    for i, llr in enumerate(LLR):
      result[i::len(zeros)] = llr
    return result

  ''' METHODS TO EXECUTE '''

  def modulate(self, msg):
    """ Modulates binary or decimal stream.
        Parameters
        ----------
        x : 1-D ndarray of ints
            Decimal or binary stream to be modulated.
        Returns
        -------
        modulated : 1-D array of complex values
            Modulated symbols (signal envelope).
        """

    if (self.bin_input == True) and ((len(msg) % self.N) != 0):
      raise ValueError(
        "The length of the binary input should be a multiple of log2(M)")

    if (self.bin_input == True) and ((max(msg) > 1.) or (min(msg) < 0.)):
      raise ValueError("The input values should be 0s or 1s only!")
    if (self.bin_input == False) and ((max(msg) >
                                       (self.M - 1)) or (min(msg) < 0.)):
      raise ValueError(
        "The input values should be in following range: [0, ... M-1]!")

    if self.bin_input:
      msg = [str(bit) for bit in msg]
      splited = [
        "".join(msg[i:i + self.N]) for i in range(0, len(msg), self.N)
      ]  # subsequences of bits
      modulated = [self.code_book[s] for s in splited]
    else:
      modulated = [self.code_book[dec] for dec in msg]
    return np.array(modulated)

  def demodulate(self, x, noise_var=1.):
    """ Demodulates complex symbols.

         Yes, MathWorks company provides several algorithms to demodulate
         BPSK, QPSK, 8-PSK and other M-PSK modulations in hard output manner:
         https://www.mathworks.com/help/comm/ref/mpskdemodulatorbaseband.html

         However, to reduce the number of implemented schemes the following way is used in our project:
            - calculate LLRs (soft decision)
            - map LLR to bits according to the sign of LLR (inverse of NRZ)
         We guess the complexity issues are not the critical part due to hard output demodulators are not so popular.
         This phenomenon depends on channel decoders properties:
         e.g., Convolutional codes, Turbo convolutional codes and LDPC codes work better with LLR.

        Parameters
        ----------
        x : 1-D ndarray of complex symbols
            Decimal or binary stream to be demodulated.
        noise_var: float
            Additive noise variance.
        Returns
        -------
        result : 1-D array floats
            Demodulated message (LLRs or binary sequence).
        """

    if self.soft_decision:
      result = self.__ApproxLLR(x, noise_var)
    else:
      if self.bin_output:
        llr = self.__ApproxLLR(x, noise_var)
        result = (np.sign(-llr) + 1) / 2  # NRZ-to-bin
      else:
        llr = self.__ApproxLLR(x, noise_var)
        result = self.bin2de((np.sign(-llr) + 1) / 2)
    return result


class PSKModem(Modem):

  def __init__(self,
               M,
               phi=0,
               gray_map=True,
               bin_input=True,
               soft_decision=True,
               bin_output=True):
    super().__init__(M, gray_map, bin_input, soft_decision, bin_output)
    self.phi = phi  # phase rotation
    self.s = list(
      np.exp(1j * self.phi + 1j * 2 * np.pi * np.array(self.m) / self.M))
    self.code_book = self.create_constellation(self.m, self.s)
    self.zeros, self.ones = self.llr_preparation()

  def de2bin(self, decs):
    """ Converts values from decimal to binary representation.
        If the input is binary, the conversion from binary to decimal should be done before.
        Therefore, this supportive method is implemented.

        This method has an additional heuristic:
        the bit sequence of "even" modulation schemes (e.g., QPSK) should be read right to left.

        Parameters
        ----------
        decs : list of ints
            Input decimal values.
        Returns
        -------
        bin_out : list of ints
            Output binary sequences.
        """
    if self.N % 2 == 0:
      bin_out = [np.binary_repr(d, width=self.N)[::-1] for d in decs]
    else:
      bin_out = [np.binary_repr(d, width=self.N) for d in decs]
    return bin_out

  def bin2de(self, bin_in):
    """ Converts values from binary to decimal representation.
        Parameters
        ----------
        bin_in : list of ints
            Input binary values.
        Returns
        -------
        dec_out : list of ints
            Output decimal values.
        """

    dec_out = []
    N = self.N  # bits per modulation symbol (local variables are tiny bit faster)
    Ndecs = int(len(bin_in) / N)  # length of the decimal output
    for i in range(Ndecs):
      bin_seq = bin_in[i * N:i * N +
                       N]  # binary equivalent of the one decimal value
      str_o = "".join([str(int(b))
                       for b in bin_seq])  # binary sequence to string
      if N % 2 == 0:
        str_o = str_o[::-1]
      dec_out.append(int(str_o, 2))
    return dec_out


class QAMModem(Modem):

  def __init__(self,
               M,
               gray_map=True,
               bin_input=True,
               soft_decision=True,
               bin_output=True):
    super().__init__(M, gray_map, bin_input, soft_decision, bin_output)

    if np.sqrt(M) != np.fix(np.sqrt(M)) or np.log2(np.sqrt(M)) != np.fix(
        np.log2(np.sqrt(M))):
      raise ValueError('M must be a square of a power of 2')

    self.m = [i for i in range(self.M)]
    self.s = self.__qam_symbols()
    self.code_book = self.create_constellation(self.m, self.s)

    if self.gray_map:
      self.__gray_qam_arange()

    self.zeros, self.ones = self.llr_preparation()

  def __qam_symbols(self):
    """ Creates M-QAM complex symbols."""

    c = np.sqrt(self.M)
    b = -2 * (np.array(self.m) % c) + c - 1
    a = 2 * np.floor(np.array(self.m) / c) - c + 1
    s = list((a + 1j * b))
    return s

  def __gray_qam_arange(self):
    """ This method re-arranges complex coordinates according to Gray coding requirements.
        To implement correct Gray mapping the additional heuristic is used:
        the even "columns" in the signal constellation is complex conjugated.
        """

    for idx, (key, item) in enumerate(self.code_book.items()):
      if (np.floor(idx / np.sqrt(self.M)) % 2) != 0:
        self.code_book[key] = np.conj(item)

  def de2bin(self, decs):
    """ Converts values from decimal to binary representation.
        Parameters
        ----------
        decs : list of ints
            Input decimal values.
        Returns
        -------
        bin_out : list of ints
            Output binary sequences.
        """
    bin_out = [np.binary_repr(d, width=self.N) for d in decs]
    return bin_out

  def bin2de(self, bin_in):
    """ Converts values from binary to decimal representation.
        Parameters
        ----------
        bin_in : list of ints
            Input binary values.
        Returns
        -------
        dec_out : list of ints
            Output decimal values.
        """

    dec_out = []
    N = self.N  # bits per modulation symbol (local variables are tiny bit faster)
    Ndecs = int(len(bin_in) / N)  # length of the decimal output
    for i in range(Ndecs):
      bin_seq = bin_in[i * N:i * N +
                       N]  # binary equivalent of the one decimal value
      str_o = "".join([str(int(b))
                       for b in bin_seq])  # binary sequence to string
      dec_out.append(int(str_o, 2))
    return dec_out
