\begin{algorithm}
\caption{Algorithms mode: ISDNN for structured channel model}
\begin{algorithmic}
\Require{ 
    \\1. N\_test: number of samples to test
    \\2. config: configuration of antenna arrays, i.e., ULA, UCyA
    \\3. $\sigma$: error rate when generating dataset
    \\4. SNR\_i: signal noise ratio
}
\Ensure{
    \\1. Err: BER
}
\\ \\
\State Random source: $0 \le $ data($T * Nt$) $ \le $ Mod\_type   
\State Generate symbols:  $\mathbf{s} \leftarrow $ QAM-16(data) 
\State Generate channel: $\mathbf{H} \leftarrow \text{Generate\_channel(Nr * Nt, 1, Ch\_type)}$
\State Generate input signal: $\mathbf{x} \leftarrow \mathbf{H} \mathbf{s} + \mathbf{n}$
\State Transform from $\mathbf{H}$ to $\hat{\boldsymbol{\beta}}$ using side-information of DoA and antenna array configuration at receiver:
$
\hat{\beta}_{l, t} = \frac{h_{l, t}} {\varphi_{l,t}}= \frac{h_{l, t}}{e^{-i k_s c_l (\theta_{l,t}, \phi_{l, t})}}
$
\State Transform from $\mathbf{x}$ to $\hat{\mathbf{x}}$ using side-information of DoA and antenna array configuration at receiver:
$
\hat{\mathbf{x}} \longleftarrow f_1(\mathbf{x}, \boldsymbol{\varphi})
$
\State Initialize variables and learning parameters: $\hat{\mathbf{s}}_1 \leftarrow \operatorname{diag}(\hat{\boldsymbol{\beta}}^T\hat{\boldsymbol{\beta}})\hat{\boldsymbol{\beta}}^T\hat{\mathbf{x}}$; $\mathbf{e}_1 \in  \mathcal{U}[0 \;\; 1)$; $\alpha^1_1~\in~\mathcal{U}[0 \;\; 1)$; $\alpha^2_1 \leftarrow 0.5$.
\For{(epoch = 1, $\cdots$, N\_epochs)}
    \For{k = 1, $\cdots$, K}
        \State Compute residual vector: $\mathbf{e}_{k+1} \leftarrow \operatorname{diag}(\mathbf{G}_{\hat{\boldsymbol{\beta}}})^{-1}\left(\hat{\boldsymbol{\beta}}^\top \hat{\mathbf{x}}-\hat{\boldsymbol{\beta}}^\top \hat{\boldsymbol{\beta}} \hat{\mathbf{s}}_k\right)$
        \State Compute $\boldsymbol{\mu}_{k}$: $\boldsymbol{\mu}_{k} \leftarrow \hat{\mathbf{s}}_k+\mathbf{e}_{k+1}+\alpha_k^1 \mathbf{e}_k$
        \State Update estimated source: $\hat{\mathbf{s}}_{k+1} \leftarrow \left(1-\alpha_k^2\right) \boldsymbol{\mu}_k + \alpha_k^2 \hat{\mathbf{s}}_k$
    \EndFor
    \State Compute Loss (MSE): $\mathcal{L}(\mathbf{s} ; \hat{\mathbf{s}}_{\boldsymbol{\Theta}}(\hat{\boldsymbol{\beta}}, \hat{\mathbf{x}})) \leftarrow \frac{1}{2T} \sum_{t=1}^{2T} {\left\| s_t-\hat{s}_t\right\|^2}$
    \State Back-propagate to update learning parameters: $\boldsymbol{\Theta} \leftarrow \operatorname{Adam}(\boldsymbol{\Theta}, \mathcal{L}(\mathbf{s} ; \hat{\mathbf{s}}_{\boldsymbol{\Theta}}(\hat{\boldsymbol{\beta}}, \hat{\mathbf{x}})))$
\EndFor
\State Compute BER: Err $\leftarrow$ Err\_func($\mathbf{s}$, $\hat{\mathbf{s}}$, Output\_type)
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}