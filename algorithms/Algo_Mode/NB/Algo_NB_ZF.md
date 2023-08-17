### ZF for MIMO communications

The Zero Forcing (ZF) [Kay1993] channel model serves as a linear equalization method utilized in wireless communication systems to counteract issues like inter-symbol interference (ISI) and co-channel interference. These problems emerge when multiple signals sent concurrently through the same channel overlap and disrupt one another. The primary objective of the ZF channel model is to eradicate or decrease this interference by performing an inversion of the channel matrix. When considering MIMO systems, which involve multiple antennas for both transmission and reception, the ZF equalizer applies the inverse of the channel matrix to pre-process the received signals. This pre-processing effectively nullifies the interference components, leading to the term "Zero Forcing". The ZF equalizer's main goal is to mitigate interference by performing an inversion of the channel matrix. Inverting the matrix $\mathbf{h}$ enables us to reverse the impact of the channel on the transmitted signal $\mathbf{s}$. As a result, the received signal $\mathbf{x}$ can reconstruct the original transmitted signal while minimizing interference. 

**Algorithm 1** shows the pseudo code of ZF and MMSE algorithms for MIMO communications. Then, **Figure 1** represents a comparison of SER using the two above algorithms in InSI toolbox.

[](../../../pseudo/Algo_NB_ZF.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_NB_ZF.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI Algorithms mode: ZF and MMSE for MIMO communications.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230