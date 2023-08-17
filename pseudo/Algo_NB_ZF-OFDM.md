\begin{algorithm}
\caption{Algorithms mode: ZF and MMSE for SISO-OFDM communications}
\begin{algorithmic}
\Require{ 
    \\1. Nfft: number of occupied carriers
    \\2. Pilot\_L: number of pilot symbols
    \\3. ChL: length of the channel
    \\4. Ch\_type: type of the channel (real, complex, user's input)
    \\5. Mod\_type: type of modulation (All)
    \\6. SNR\_i: signal noise ratio
    \\7. Output\_type: SER / BER / MSE Signal / MSE Channel
}
\Ensure{
    \\1. Err: SER / BER / MSE Signal / MSE Channel
}
\\ \\
\State Random source: $0 \le $ data(Nfft) $ \le $ Mod\_type   
\State Generate data symbols: $\mathbf{d} \leftarrow $ Mod\_type(data) 
\State Generate channel: $\mathbf{h} \leftarrow \text{Generate\_channel(1, ChL, Ch\_type)}$
\State Generate pilot symbols: $\mathbf{p}$ and insert them into the subcarriers
\State Perform data symbol mapping: $\mathbf{x}_{\text{data}} \leftarrow \text{MapDataToSubcarriers}(\mathbf{d})$
\State Combine data and pilot symbols: $\mathbf{x} \leftarrow [\mathbf{p}, \mathbf{x}_{\text{data}}]$
\State Time-domain signal $\mathbf{s}$: IFFT($\mathbf{x}$)
\State Add cyclic prefix
\State Channel propagation: $\mathbf{r} \leftarrow \mathbf{h} * \mathbf{s} + \mathbf{n}$
\State Remove cyclic prefix and FFT: $\mathbf{y} \leftarrow \text{FFT}(\mathbf{r}[\text{CP\_length + 1 : Nfft + CP\_length}])$
\State Extract received pilot symbols from $\mathbf{y}$ for channel estimation
\State Perform ZF and MMSE equalization as ZF and MMSE for MIMO communications
\State OFDM demodulation on $\hat{\mathbf{x}}_{ZF}, \hat{\mathbf{x}}_{MMSE}$ to obtain the received data and pilot symbols
\State Extract data symbols from $\hat{\mathbf{x}}_{ZF}, \hat{\mathbf{x}}_{MMSE}$
\State Demodulation: $\hat{\mathbf{d}} \leftarrow$ Demod($\hat{\mathbf{x}}_{ZF}, \hat{\mathbf{x}}_{MMSE}$)
\State Compute SER / BER / MSE Sig / MSE Ch: $\leftarrow$ Err\_func($\mathbf{d}, \mathbf{\hat{d}}$, Output\_type)
\\ 
\State \Return Err
\end{algorithmic}
\end{algorithm}