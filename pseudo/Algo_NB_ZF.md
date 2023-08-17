\begin{algorithm}
\caption{Algorithms mode: ZF and MMSE for MIMO communications}
\begin{algorithmic}
\Require{ 
    1. N: number of data samples \\
    2. Nt: number of transmit antennas \\
    3. Nr: number of receive antennas\\
    4. ChL: length of the channel\\
    5. Ch\_type: type of the channel (real, complex, user's input)\\
    6. Mod\_type: type of modulation (All)\\
    7. SNR\_i: signal noise ratio\\
    8. Output\_type: SER / BER / MSE Signal\\
}
\Ensure{ \\
    1. Err: SER / BER / MSE Signal
}
\\ \\
\State Random source: $0 \le $ data($N$) $ \le $ Mod\_type   
\State Generate symbols:  $\mathbf{s} \leftarrow $ Mod\_type(data) 
\State Generate channel: $\mathbf{h} \leftarrow \text{Generate\_channel(Num\_Ch, ChL, Ch\_type)}$
\State Generate input signal: $\mathbf{x} \leftarrow \mathbf{h}^T * \mathbf{s} + \mathbf{n}$
\State Estimate source by ZF: $\hat{\mathbf{s}}_{ZF} \leftarrow \left(\mathbf{H}^H \mathbf{H}\right)^{-1} \mathbf{H}^H \mathbf{x}$
\State Estimate source by MMSE: $\hat{\mathbf{s}}_{MMSE} \leftarrow \left(\mathbf{H}^H \mathbf{H}+\frac{1}{\text{SNR\_i}} \mathbf{I}\right)^{-1} \mathbf{H}^H \mathbf{x}$
\State Compute SER / BER / MSE Sig: Err $\leftarrow$ Err\_func($\mathbf{s}, \mathbf{\hat{s}}$, Output\_type)
\\
\State \Return Err
\end{algorithmic}

\end{algorithm}