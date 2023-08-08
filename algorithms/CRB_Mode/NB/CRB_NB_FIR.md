### Finite Impulse Response channel model

Almost wireless communication standards use the training sequences in the physical layer (i.e., preamble) to estimate the effects of the propagation channel in the received signals. Typically, OFDM transceivers insert $K_p$ pilot symbols, which are known in both the transmitter and receiver. Thus, the receiver can exploit these pilots for channel estimation. However, there is no way to perfect accuracy in wireless communication because we cannot compute a perfect CSI. To estimate the maximum possible accuracy in wireless communication systems, CRB is used for unbiased channel estimators. Basically, the CRB is given by [Kay1993]:
$$
    \text{CRB}(\boldsymbol{\Theta}) = \mathbf{J}_{\boldsymbol{\Theta}\boldsymbol{\Theta}}^{-1}
$$
with $\mathbf{J}_{\boldsymbol{\Theta}\boldsymbol{\Theta}}$ is the FIM (Fisher Information Matrix) and $\boldsymbol{\Theta}$ is the unknown parameters vector to be estimated. In Finite Impulse Response (FIR) channel model, $\boldsymbol{\Theta} \simeq	 \mathbf{h}$ [Ladaycia2017], FIM is associated to the known pilots denoted by $\mathbf{J}_{\boldsymbol{\Theta}\boldsymbol{\Theta}}^p$. Therefore, the parameters vector to be estimated is expressed by [Menni2012]:
$$
    \boldsymbol{\Theta}=\left[\mathbf{h}^{\top},  \quad  \left(\mathbf{h}^{*}\right)^{\top}\right]
$$

In massive MIMO-OFDM systems, $K_p$ pilots are arranged in OFDM symbols [Garro2020], and since the noise is an i.i.d random process, we could formulate FIM in the NB case as follows:
$$
\label{eq:9}
    \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p}=\sum_{i=1}^{K_{p}} \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}}
$$
with $\mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}}$ is the FIM associated with the $i$-th pilot [Kay1993] given by:

$$
    \label{eq:10}
    \begin{aligned}
        \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}} &=\mathbb{E}\left\{\left(\frac{\partial \ln p(\mathbf{y}(i), \mathbf{h})}{\partial \boldsymbol{\Theta}^{*}}\right)\left(\frac{\partial \ln p(\mathbf{y}(i), \mathbf{h})}{\partial \boldsymbol{\Theta}^{*}}\right)^{H}\right\} \\
    \end{aligned}
$$
where $\mathbb{E}$ is the expectation operator; $p(\mathbf{y}(i), \mathbf{h})$ is the probability density function (pdf) of the received signal given $\mathbf{h}$. The above is complex derivations. Hence, it can be expressed by:
$$
    \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}}=\frac{\mathbf{x}(i)^{H} \mathbf{x}(i)}{\sigma_{\mathbf{v}}^{2}}
$$

Algorithm 1 shows the pseudo code of CRB for FIR channel model. Then, Figure 1 represents an example of NB\_FIR on InSI toolbox.

[Finite Impulse Response channel model](../../../../pseudo/CRB_NB_FIR.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_NB_FIR.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Performance analysis: Finite Impulse Response channel model.
</b>
</p>


[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230