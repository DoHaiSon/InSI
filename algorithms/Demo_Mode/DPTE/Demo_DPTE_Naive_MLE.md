### Naive Maximum Likelihood

In this demonstration, we give an example of using the (B)CRB to evaluate the performance of algorithms. Particularly, we consider a communication system called dynamical phase offset channel, where the signal is affected by carrier phase offsets following a Wiener process. We adopt here a naive maximum likelihood estimator (MLE). The estimator is naive in the sense that it does not account for the effect of noise. Naive MLE uses only the information of phase distortion of the received signals. One can see in **Figure 1** that the performance naive MLE only approaches the BCRB when the SNR is very high. This is totally reasonable considering the design of the estimator.

[](../../../pseudo/Demo_DPTE_Naive_MLE.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_D_DPTE.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Demonstrations: CRB and an estimator of dynamic phase tracking estimation.
</b>
</p>

[Mohamed2020]: https://ieeexplore.ieee.org/document/9187805/