### Minimum Mean Square Error for MIMO communications

The Minimum Mean Square Error (MMSE) [Kay1993] method is another equalization technique employed in wireless communication systems. The MMSE method aims to minimize the mean square error between the received signal and the estimated transmitted signal by considering the statistical properties of the channel and noise. The MMSE method is well-regarded for its ability to handle various interference and noise conditions. However, it involves more complex calculations than straightforward techniques like Zero Forcing. Despite its computational complexity, the MMSE method performs better in scenarios with challenging interference and noise environments. 

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