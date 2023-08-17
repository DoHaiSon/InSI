\begin{algorithm}
\caption{Algorithms mode: Fast subspace algorithm}
\begin{algorithmic}
\Require{ 
    \\1. Ns: number of samples
    \\2. Nt: number of transmit antennas
    \\3. Nr: number of receive antennas
    \\4. N: number of channel's paths 
    \\5. K: number of OFDM sub carriers
    \\6. Ch\_Type: type of the channel (real, complex, user's input)
    \\7. Mod: type of modulation (All)
    \\8. SNR\_i: signal noise ratio
    \\9. Output\_type: MSE Channel
}
\Ensure{
    \\1. Err: MSE Channel
}
\\ \textbf{Constraint:} Nr $>$ Nt
\\ \\
\State Random source: $0 \le $ data($K*Nt*Ns$) $ \le $ Mod\_type   
\State Generate symbols:  $\mathbf{s} \leftarrow $ Mod\_type(data) 
\State Generate channel: $\mathbf{h} \leftarrow \text{Generate\_channel(Nr, Nt * N - 1, Ch\_type)}$
\State Generate input signal:
$
\mathbf{y}_k(t) \leftarrow \boldsymbol{\mathcal{H}}_k \mathbf{x}_k(t) + \mathbf{n}_t(k)
$ where
$
\boldsymbol{\mathcal{H}}_k \leftarrow \sum_{l = 0}^{N-1} \mathbf{H}(l) e^{-j2\pi\frac{k}{K}l} \leftarrow \mathbf{H}(\mathbf{e}_k^T \otimes \mathbf{I}_{N_t})
$
\State Estimate the subspace matrix ($\mathbf{C}_k$):
$
\hat{\mathbf{C}}_k \leftarrow \frac{1}{N_s} \sum_{t = 0}^{N_s - 1} \mathbf{y}_k(t) \mathbf{y}_k(t)^H
$
\State Compute the smallest ($N_r - Nt$) eigenvalues of $\mathbf{C}_k$:
$
\mathbf{C}_k = [\mathbf{U}_{k_s} \| \mathbf{U}_{k_n}] \begin{bmatrix}
    \Lambda_{k_s} & \mathbf{0} \\
    \mathbf{0}    & \lambda_{k_n}
\end{bmatrix}
\begin{bmatrix}
\mathbf{U}_{k_s}^H  \\
\mathbf{U}_{k_n}^H
\end{bmatrix}
$
\State Compute $\mathbf{Q}$ matrix:
$
\mathbf{Q} \leftarrow \sum_{k = 0}^{K - 1} \mathbf{E}_k \otimes \mathbf{I}_{N_t} \otimes \boldsymbol{\Pi}_k
$
where $\boldsymbol{\Pi} \leftarrow \mathbf{U}_{k_n} \mathbf{U}_{k_n}^H$ and $\mathbf{E}_k \leftarrow \mathbf{e}_k^H \mathbf{e}_k$.
\State Estimate channel $\hat{\mathbf{h}}$:
$
\hat{\mathbf{h}} \leftarrow \min \operatorname{eigenvector}(\mathbf{Q})
$
\State Compute MSE Ch: Err $\leftarrow$ Err\_func($\mathbf{h}, \hat{\mathbf{h}}$, Output\_type)
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}