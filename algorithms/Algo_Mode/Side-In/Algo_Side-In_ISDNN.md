### Iterative Sequential Deep-neural Network for structured channel model

In the work presented in [Thesis2023], we expanded upon the ISDNN approach to accommodate scenarios involving side-information. Specifically, we assumed that prior to the data detection phase, certain details - such as the Direction of Arrival (DoA) of the transmitter and the configuration of the receiver's antenna array, represented by $\boldsymbol{\varphi}$—were available. Leveraging the structured channel model described in the CRB for structured channel model, this information was utilized to convert the estimated channel matrix $\mathbf{H}$ into the matrix of path gains, denoted as $\boldsymbol{\beta}$. Through our simulation results, we demonstrated that utilizing $\boldsymbol{\beta}$ instead of $\mathbf{H}$ as the input for the proposed ISDNN network yielded superior performance compared to the original ISDNN method designed for unstructured channel models. The algorithmic representation of the ISDNN for the structured channel model can be found in **Algorithm 1**, while the corresponding simulation outcomes are presented in **Figure 1**.


[](../../../pseudo/Algo_SI_Structured.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_SI_Structured.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI Algorithms mode: ISDNN for Structured channel model.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Mandloi2017]: https://ieeexplore.ieee.org/document/7778172
[Thesis2023]: https://dohaison.github.io/assets/pdf/2023_Thesis.pdf