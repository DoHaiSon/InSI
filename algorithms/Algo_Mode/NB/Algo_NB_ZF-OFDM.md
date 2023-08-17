### Zero forcing for OFDM

SISO-OFDM [Cho2010] is a communication system where a single transmitter sends data over a channel to a single receiver using the OFDM modulation scheme. OFDM divides the high-speed data stream into multiple lower-speed substreams that are transmitted in parallel over different subcarriers. This helps combat the effects of multipath fading and frequency-selective fading, making it suitable for high datarate and robust communication. **Algorithm 1** shows the pseudo code of ZF and MMSE algorithms for OFDM communications. Then, **Figure 1** represents a comparison of SER using the two above algorithms in the InSI toolbox.

[](../../../pseudo/Algo_NB_ZF-OFDM.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_NB_ZF-OFDM.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI Algorithms mode: ZF and MMSE for SISO-OFDM communications.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Cho2010]: https://ieeexplore.ieee.org/book/5675894