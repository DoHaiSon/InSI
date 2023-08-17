\begin{algorithm}
\caption{Algorithms mode: SB Mutually Referenced Filters}
\begin{algorithmic}
\Require{ 
    \\1. Ns: number of sample data
    \\2. Nt: number of transmit antennas
    \\3. Nr: number of receive antennas
    \\4. ChL: length of the channel
    \\5. Ch\_type: type of the channel (real, complex, user's input)
    \\6. Mod\_type: type of modulation (All)
    \\7. N: window size
    \\8. $N_p$: number of pilot symbols
    \\9. lambda: Ratio between SB and B-MRE 
    \\10. SNR\_i: signal noise ratio
    \\11. Output\_type: SER / BER / MSE Signal 
}
\Ensure{
    \\1. Err: SER / BER / MSE Signal
}
\\ \\
\State Random source: $0 \le $ data($Ns * Nt$) $ \le $ Mod\_type   
\State Generate symbols:  $\mathbf{s} \leftarrow $ Mod\_type(data) 
\State Generate channel: $\mathbf{h} \leftarrow \text{Generate\_channel(Nr * Nt, ChL, Ch\_type)}$
\State Generate input signal: $\mathbf{x} \leftarrow \mathbf{h}^T * \mathbf{s} + \mathbf{n}$
\State Compute B-MRE matrix $\mathbf{U}$:
$
\mathbf{U} \leftarrow \left(\mathbf{I}_{T (K-1)}, \mathbf{0}\right) \otimes \mathbf{x}^{H}(n)-\left(\mathbf{0}, \mathbf{I}_{T (K-1)}\right) \otimes \mathbf{x}^{H}(n+1)
$
\State Compute matrix $\mathcal{R}$: $\mathcal{R} \leftarrow \mathbf{U}^{H} \mathbf{U}$
\State Re-construct $\mathbf{x}$ to $\widetilde{\mathbf{X}}$: $\widetilde{\mathbf{X}} \leftarrow [\mathbf{x}(N-1), \ldots, \mathbf{x}\left(N_{p} - 1\right)]$
\State Compute matrix $\mathbf{A}$: $\mathbf{A} \leftarrow \mathbf{I}_{KT} \otimes \widetilde{\mathbf{X}}^H$
\State Compute SB-MRE equalizers matrix:
$
\mathbf{g}_{SB} \leftarrow \left(\mathbf{A}^H \mathbf{A} + \lambda \mathcal{R}\right)^{-1} \mathbf{A}^H \bar{\mathbf{s}}
$
\State Transform vector $\mathbf{g}_{SB}$ to full matrix form $\bar{\mathbf{G}}$: $
\bar{\mathbf{G}} \leftarrow \operatorname{reshape}(\mathbf{g}_{SB}, [Nr*N, Nt, ChL + N])
$
\State Equalize received signal: $\bar{\mathbf{s}}(n) \leftarrow \bar{\mathbf{G}}^H \mathbf{x}(n)$
\State Compute SER / BER / MSE Sig: Err $\leftarrow$ Err\_func($\mathbf{s}$, $\bar{\mathbf{s}}$, Output\_type)
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}