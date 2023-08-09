\begin{algorithm}
\caption{Performance analysis: Structured channel model}
\begin{algorithmic}
\Require{ 
    \\1. Nt: number of transmit antennas
    \\2. Nr: number of receive antennas
    \\3. config: configuration of antenna arrays 
    \\4. Nr\_UCA: number of antennas per UCA (UCyA)
    \\5. Nr\_ULA: number of layers ULA (UCyA)
    \\6. L: number of paths
    \\7. K: number of OFDM subcarriers
    \\8. M: number of pilot symbols per OFDM symbol
    \\9. method: OP / SB
    \\10. SNR\_i: signal noise ratio
}
\Ensure{
    \\1. Err: CRB
}
\\ \\ 
\State Generate channel parameters: $\beta \sim \mathcal{C} \mathcal{N}\left(0, 1 \right)$; $\phi^\circ \sim \mathcal{U}(-\pi/2, \pi/2)$; $\theta^\circ \sim \mathcal{U}(-\pi/2, \pi/2)$
\State Generate antenna configurations: $\boldsymbol{s}_p(\text{ULA})$; $\boldsymbol{s}_p(\text{UCyA})$
\State Generate channel: $h_{r, j} \leftarrow \sum\limits_{l=0}^{L-1} \beta_{l, j} \cdot e^{-i k_c s(\theta_{l, j}, \phi_{l, j})} $
\State Compute derivations: $\frac{\partial \boldsymbol{h}}{\partial \boldsymbol{\Theta}} \leftarrow \left[\frac{\partial \boldsymbol{h}}{\partial \boldsymbol{\beta}}, \frac{\partial \boldsymbol{h}}{\partial \boldsymbol{\beta^*}}, \frac{\partial \boldsymbol{h}}{\partial \boldsymbol{\theta}},    \frac{\partial \boldsymbol{h}}{\partial \boldsymbol{\phi}}\right]$
\State Compute FIM ($\mathbf{J}^p_{\boldsymbol{h} \boldsymbol{h}}$) of channel $\boldsymbol{h}$: $\mathbf{J}^p_{\boldsymbol{h} \boldsymbol{h}} \leftarrow \frac{\partial \boldsymbol{h}}{\partial \boldsymbol{\Theta}} \mathbf{J}^p_{\Theta \Theta} {\frac{\partial \boldsymbol{h}}{\partial \boldsymbol{\Theta}}}^{H}$
\State Compute FIM of semi-blind approach: 
$\mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{SB} \leftarrow \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p} + \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{d}$
\State Compute CRB: $\text{Err} \leftarrow \mathbf{J}_{\boldsymbol{\Theta}\boldsymbol{\Theta}}^{-1}$
\\
\State \Return Err
\end{algorithmic}
\end{algorithm}