\begin{algorithm}
\caption{Algorithms mode: ISDNN for unstructured channel model}
\begin{algorithmic}
\Require{ 
    \\1. Nt: number of transmit antennas
    \\2. Nr: number of receive antennas
    \\3. N\_test: number of samples to test
    \\4. $\sigma$: error rate when generating dataset
    \\5. SNR\_i: signal noise ratio
}
\Ensure{
    \\1. Err: BER
}
\\ \\
\State Random source: $0 \le $~data($T * Nt$)~$ \le $ Mod\_type   
\State Generate symbols:  $\mathbf{s} \leftarrow $ QAM-16(data) 
\State Generate channel: $\mathbf{H} \leftarrow \text{Generate\_channel(Nr * Nt, 1, Ch\_type)}$
\State Generate input signal: $\mathbf{x} \leftarrow \mathbf{H} \mathbf{s} + \mathbf{n}$
\State Initialize variables and learning parameters: $\hat{\mathbf{s}}_1 \leftarrow \operatorname{diag}(\mathbf{H}^T\mathbf{H})\mathbf{H}^T\mathbf{x}$; $\mathbf{e}_1 \in  \mathcal{U}[0 \;\; 1)$; $\alpha^1_1~\in~\mathcal{U}[0 \;\; 1)$; $\alpha^2_1 \leftarrow 0.5$.
\For{(epoch = 1, $\cdots$, No\_epochs)}
    \For{k = 1, $\cdots$, K}
        \State Compute residual vector: $\mathbf{e}_{k+1} \leftarrow \mathbf{\operatorname{diag}(\mathbf{G}_\mathbf{H})}^{-1}\left(\mathbf{H}^\top \mathbf{x}-\mathbf{H}^\top \mathbf{H} \hat{\mathbf{s}}_k\right)$
        \State Compute $\boldsymbol{\mu}_{k}$: $\boldsymbol{\mu}_{k} \leftarrow \hat{\mathbf{s}}_k+\mathbf{e}_{k+1}+\alpha_k^1 \mathbf{e}_k$
        \State Update estimated source: $\hat{\mathbf{s}}_{k+1} \leftarrow \left(1-\alpha_k^2\right) \boldsymbol{\mu}_k + \alpha_k^2 \hat{\mathbf{s}}_k$
    \EndFor
    \State Compute Loss (MSE): $\mathcal{L}(\mathbf{s} ; \hat{\mathbf{s}}_{\boldsymbol{\Theta}}(\mathbf{H}, \mathbf{x})) \leftarrow \frac{1}{2T} \sum_{t=1}^{2T} {\left\| s_t-\hat{s}_t\right\|^2}$
    \State Back-propagate to update learning parameters: $\boldsymbol{\Theta} \leftarrow \operatorname{Adam}(\boldsymbol{\Theta}, \mathcal{L}(\mathbf{s} ; \hat{\mathbf{s}}_{\boldsymbol{\Theta}}(\mathbf{H}, \mathbf{x})))$
\EndFor
\State Compute BER: Err $\leftarrow$ Err\_func($\mathbf{s}$, $\hat{\mathbf{s}}$, Output\_type)
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}