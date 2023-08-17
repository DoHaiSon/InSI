\begin{algorithm}
\caption{InSI algorithms mode: EM-based Non-linear MIMO communications}
\begin{algorithmic}
\Require{ 
    \\1. Ns: number of sample data
    \\2. Nt: number of transmit antennas
    \\3. Nr: number of receive antennas
    \\4. M: length of the channel
    \\5. Ch\_type: type of the channel (real, complex, user's input)
    \\6. Mod\_type: type of modulation (All)
    \\7. Threshold: threshold of EM algorithm
    \\8. Np: number of pilot symbols
    \\9. N\_iter\_max: number of maximum iterations EM 
    \\10. SNR\_i: signal noise ratio
    \\11. Output\_type: SER / BER / MSE Channel
}
\Ensure{
    \\1. Err: SER / BER / MSE Channel
}
\\ \\
\State Initialize variables 
\State Loop of the proposed EM-based algorithm:
\\
\textbf{E-step}: Find a proportional function to Q of the thetas, which gives the conditional expectation of the complete-data log-likelihood.
\\
$Q(\bm{\theta}, \bm{\theta}^{(m)}) \propto \sum_{\bm{x}_{ij} \in \mathcal{X}} \sum_{k=1}^{N_s} \left( -N_r \log (\sigma_v^2) - \lVert \bm{y}(k) - \bm{H\bar{x}}_{ij} \rVert^2 / \sigma_v^2 \right) \gamma_{\theta^(m)}(k;i,j)$
\\
\textbf{M-step}: Find the new theta that maximizes Q 
\State Estimate $\bm{\theta}$: $\bm{\theta}^{(m+1)} \leftarrow \underset{\bm{\theta}}{\operatorname{argmax}} ~Q(\bm{\theta}, \bm{\theta}^{(m)}) $ 
\State \Return Err $\leftarrow \bm{\theta}$
\end{algorithmic}
\end{algorithm}