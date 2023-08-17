\begin{algorithm}
\caption{Performance analysis: Finite Impulse Response channel model}
\begin{algorithmic}
\Require{ \\
    1. Nt: number of transmit antennas \\
    2. Nr: number of receive antennas \\
    3. L: channel order \\
    4. K: OFDM subcarriers \\
    5. ratio: Pilot/Data Power ratio \\ 
    6. SNR\_i: signal noise ratio \\
}
\Ensure{ \\
    1. Err: CRB 
}
\\ \\
\State \% Initialize variables: 
\State F $\leftarrow$ dftmtx($K$)
\State FL $\leftarrow$ F(:,1:$L$)
\State N\_total $\leftarrow$ 4
\State N\_pilot $\leftarrow$ 2

\State sigmav2 $\leftarrow 10^{(-\text{SNR\_i}/10)}$
\State X\_nga $\leftarrow$ eye(Nr) $\otimes$ X

\State Compute FIM per pilot symbol: FIM\_p $\leftarrow$ X\_nga$^H$ * X\_nga / sigmav2

\State Compute full FIM: FIM $\leftarrow$ N\_total * FIM\_p
 
\State Compute CRB: Err $\leftarrow$ abs(trace(FIM$^{-1}$))
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}