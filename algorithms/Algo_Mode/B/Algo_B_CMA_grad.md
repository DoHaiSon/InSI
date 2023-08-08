### Constant modulus algorithm

An adaptive digital filtering algorithm that can compensate for both frequency-selective multi-path and interference on constant envelope modulated signals is presented. The method exploits the fact that multi-path reception and various interference sources generate incidental amplitude modulation on the received signal. A class of so-called constant modulus performance functions is developed which are insensitive to the angle modulation. Simple adaptive algorithms for finite-impulse-response (FIR) digital filters are  implemented using a gradient search of the performance function. It is called Constant Modulus Algorithm [CMA]. The pseudo of this algorithm is shown in Algorithm. 1, and in the toolbox, the interface of CMA is shown in Figure 1.

[](../../../pseudo/Algo_B_CMA_grad.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_B_CMA.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI algorithms mode: Constant modulus algorithm.
</b>
</p>

[CMA]: https://ieeexplore.ieee.org/document/1164062