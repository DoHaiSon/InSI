\begin{algorithm}
\caption{Performance analysis: Misspecified CRB}
\begin{algorithmic}
\Require{ 
    \\1. Nt: number of transmit antennas
    \\2. Nr: number of receive antennas
    \\3. L\_tr: true channel order
    \\4. L\_pt: misspecified channel order
    \\5. K: number of unknown data blocks
    \\6. SNR\_i: signal noise ratio 
}
\Ensure{
    \\1. Err: CRB \\
}
\textbf{Constraint:} Nr * N $>$ Nt (Ltr + N - 1)
\\ \\
\State \% Initialize variables: 
\State $\sigma_n \leftarrow$ 30
\State Sigma $\leftarrow 10^{(-(\text{SNR\_i} / 10))}$
\If {L\_pt $>$ L\_tr}
    \State If channel order is overspecified, we include some irrelevant parameters in the system model: 
$
\boldsymbol{y}\leftarrow\tilde{\mathcal{X}} \tilde{\boldsymbol{h}}+\boldsymbol{n}\leftarrow\left[\mathcal{X}_{\mathrm{add}} \mathcal{X}\right]\left[\begin{array}{c}
\boldsymbol{h}_{\mathrm{add}} \\
\boldsymbol{h}
\end{array}\right]+\boldsymbol{n}
$
    \State The best unbiased estimator $\widehat{\boldsymbol{h}}_{t r}(\boldsymbol{y})$ of $\boldsymbol{h}$ as: 
$
\operatorname{MSE}\left(\widehat{\boldsymbol{h}}_{t r}(\boldsymbol{y})\right)\leftarrow\sigma_n^2\left(\boldsymbol{\mathcal { X }}^H \boldsymbol{\mathcal { X }}\right)^{-1}
$
\EndIf
\If{L\_pt $<$ L\_tr}
    \State If channel order is e underspecification, we exclude some channel parameters that actually appear in the system model: 
$
\boldsymbol{y}\leftarrow\mathcal{X} \boldsymbol{h}+\boldsymbol{n}\leftarrow\left[\boldsymbol{\mathcal { X }}_{\mathrm{omit}} \tilde{\mathcal{X}}\right]\left[\begin{array}{c}
\boldsymbol{h}_{\mathrm{omit}} \\
\tilde{\boldsymbol{h}}
\end{array}\right]+\boldsymbol{n}
$
    \If{$\boldsymbol{x}$ is deterministic}
        \State 
$
\operatorname{MSE}_f\left\{\widehat{\tilde{\boldsymbol{h}}}_{t r}(\boldsymbol{y})\right\}\leftarrow\sigma_n^2\left(\tilde{\boldsymbol{\mathcal{X}}}^H \boldsymbol{Z}_{\text {omit }} \tilde{\boldsymbol{\mathcal { X }}}\right)^{-1}
$
where $\boldsymbol{Z}_{\text {omit }}\leftarrow\boldsymbol{I}-\mathcal{X}_{\text {omit }}\left(\mathcal{X}_{\text {omit }}^H\boldsymbol{\mathcal{X}}_{\text {omit }}\right)^{-1}\boldsymbol{\mathcal{X}}_{\text {omit }}^H$.
    \EndIf

    \If{$\boldsymbol{x}$ is stochastic}
        \State
$
\operatorname{MSE}_f\left\{\widehat{\tilde{\boldsymbol{h}}}_{t r}(\boldsymbol{y})\right\}\leftarrow\sigma_n^2 \mathbb{E}_f\left\{\left(\tilde{\boldsymbol{\mathcal { X }}}^H \boldsymbol{Z}_{\mathrm{omit}} \tilde{\boldsymbol{\mathcal{H}}}\right)^{-1}\right\}
$
    \EndIf
\EndIf
\If {L\_pt = L\_tr}
    \If{$\boldsymbol{x}$ is deterministic}
        \State The deterministic GMCRB can be derived directly from the following FIM:
$
\mathrm{FIM}_{\boldsymbol{\theta}}\leftarrow\frac{1}{\sigma_n^2}
\times\left[\begin{array}{ccccc}
\boldsymbol{\mathcal{X}}^H\boldsymbol{\mathcal{X}} &\boldsymbol{\mathcal{X}}^H \boldsymbol{\mathcal{H}} & \mathbf{0} & \mathbf{0} & \mathbf{0} \\
\boldsymbol{\mathcal{H}}^H\boldsymbol{\mathcal{X}} & \boldsymbol{\mathcal{H}}^H \boldsymbol{\mathcal{H}} & \mathbf{0} & \mathbf{0} & \mathbf{0} \\
\mathbf{0} & \mathbf{0} &\boldsymbol{\mathcal{X}}^{\top} \boldsymbol{\mathcal { X }}^* &\boldsymbol{\mathcal{X}}^{\top} \boldsymbol{\mathcal{H}}^* & \mathbf{0} \\
\mathbf{0} & \mathbf{0} & \boldsymbol{\mathcal{H}}^{\top}\boldsymbol{\mathcal{X}}^* & \boldsymbol{\mathcal{H}}^{\top} \boldsymbol{\mathcal{H}}^* & \mathbf{0} \\
\mathbf{0} & \mathbf{0} & \mathbf{0} & \mathbf{0} & \frac{N_r N}{\sigma_n^2}
\end{array}\right] 
$
    \EndIf

    \If{$\boldsymbol{x}$ is stochastic}
        \State 
$
\operatorname{FIM}_{\boldsymbol{\theta}}(i, j)\leftarrow\operatorname{tr}\left\{\boldsymbol{C}^{-1} \frac{\partial \boldsymbol{C}}{\partial \theta_i^*} \boldsymbol{C}^{-1} \frac{\partial \boldsymbol{C}}{\partial \theta_j}\right\}
$
    \EndIf
\EndIf
\State Compute CRB: Err $\leftarrow \operatorname{MSE}\left\{\widehat{\tilde{\boldsymbol{h}}}(\boldsymbol{y})\right\}$ or $\operatorname{trace}(\text{FIM})^{-1}$
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}