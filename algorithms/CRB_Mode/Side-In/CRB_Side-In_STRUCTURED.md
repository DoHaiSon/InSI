### Structured channel model

In communications, to recover source signals exactly, systems must get the channel state information (CSI). The known training symbols, aka pilots, are inserted in the data sequences to estimate CSI and synchronization. The length of pilot sequence should be larger than the number of elements in the antenna array. Because of the huge number of antenna elements, channel estimation in massive MIMO systems is very complex with a long training overhead [Liang2019]. There are two popular wireless channel models that are unstructured and structured models. The unstructured model is used mostly because of simplicity but it is not really suitable for millimeter wave with several significant reflective waves. This paper relates to semi-blind channel estimation in millimeter wave MIMO-OFDM systems. SB channel estimation algorithms are combinations of conventional training-based methods and blind methods. They use several pilot symbols and other kinds of information [abed1997]. SB algorithms can reduce the number of pilot symbols efficiently but maintain acceptable accuracy [Rekik2021]. In the unstructured channel model, paths between each pair of transmitter and receiver antenna are described as complex gains [Swindlehurst2022] while the structured model includes complex gains, Directions of Departure (DoD), and Directions of Arrival (DoA). This model is also called specular or geometric channel model [Ladaycia2017], [Swindlehurst2022].

<p float="left" style="text-align-last: center">
  <img src="./assets/img/Outputs/ULA.png" width=40%/>
  <img src="./assets/img/Outputs/UCyA.png" style="margin-left:10%" width=44%/>
</p>
<p style="text-align-last: center">
<b>
Figure 1. Geometric antenna structures: (a), Uniform Linear Array (ULA); (b), Uniform Cylindrical Array (UCyA).
</b>
</p>

In this section [Son2023], we analyze the SB channel estimation performance bound in 3D-massive MIMO array geometries. For the SB method, besides the pilots part, the data symbols are assumed to be i.i.d and known statistical. The performances of systems are measured by CRB [Ladaycia2017] for two antenna array structures, i.e., Uniform Linear Array (ULA) and Uniform Cylindrical Array (UCyA) as shown in Figure 1. From the simulation results, the UCyA outperforms the traditional ULA array regarding SNR and the number of elements in arrays. Algorithm 1 shows the pseudo code of CRB for structured channel model. Then, Figure 2 represents a comparison of CRB for the structured channel model using ULA and UCyA antenna configurations on InSI toolbox.

[CRB for structured channel model](../../../pseudo/CRB_SI_Structured.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_SI_Structured.png">
</p>
<p style="text-align-last: center">
<b>
Figure 2. Performance analysis: Structured channel model.
</b>
</p>


[Liang2019]: https://ieeexplore.ieee.org/document/8807374
[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[abed1997]: https://ieeexplore.ieee.org/abstract/document/622507/
[Rekik2021]: https://ieeexplore.ieee.org/document/9723265/
[Son2023]: https://dohaison.github.io/assets/pdf/2023_SSP.pdf
[Swindlehurst2022]: https://ieeexplore.ieee.org/document/9771077