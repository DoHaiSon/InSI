### Fast subspace 

In their recent work [Rekik2023], the authors tackle the challenge of blind and semi-blind subspace-based channel estimation in MIMO-OFDM communication systems. The proposed approach significantly reduces computational complexity while ensuring precise channel estimation compared to existing methods. Leveraging the orthogonality inherent in OFDM modulation, the method estimates covariance matrices and noise subspaces concurrently for individual subcarriers. This parallel processing is followed by a global optimization process that minimizes a cost function to derive accurate channel coefficient estimates. The study also delves into conditions for channel identifiability, along with determining the minimum number of subcarriers required for a unique solution. Numerical simulations are conducted to validate these findings. For clarity, **Algorithm 1** outlines the pseudo code of this method, and a visual representation of its results is presented in **Figure 1**.

[](../../../pseudo/Algo_B_Fast_SS.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_B_Fast_SS.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI algorithms mode: Fast subspace algorithm.
</b>
</p>

[Rekik2023]: https://