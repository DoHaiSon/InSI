### Fast computation of the Gaussian CRB for blind SIMO system identification

In [Mohamed2020], the authors explore blind system identification in single-input multiple-output (SIMO) systems. This involves estimating system parameters without knowing the input signal. This has applications in fields like telecommunications and audio processing. The authors' research makes significant strides by introducing innovative methodologies tailored for efficiently computing the Gaussian Cramér-Rao Bound (GCRB). The novel approach stands out for its ability to streamline computations, making them more feasible for practical applications compared to conventional techniques. To illustrate, the algorithm shown in **Algorithm 1** has been developed and demonstrated to showcase the practicality of the authors' proposed methods. Furthermore, the authors embark on an insightful analysis of the CRB's behavior as the signal-to-noise ratio (SNR) escalates. By establishing a robust theoretical framework and uncovering crucial insights into the CRB's dynamics, the authors' work not only enriches the theoretical understanding but also lays a foundation for the development of effective and precise blind system identification algorithms that find utility in real-world scenarios. An example of output using this method is shown in **Figure 1**.

[](../../../pseudo/CRB_B_Fast_GCRB_SIMO.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_B_Fast_CRB.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Performance analysis: FINE.
</b>
</p>

[Mohamed2020]: https://ieeexplore.ieee.org/document/9187805/