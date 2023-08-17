### Semi-blind Mutually Referenced Filters 

In this task, we focus on the blind "Mutually referenced equalizers" (MRE) [MRE_original] algorithm, which is fast, global convergence, and flexible in implementation (i.e., Batch, LMS, RLS, ...). Since 1997, several studies have been proposed to develop the MRE algorithm. [GesbertSPAWC] firstly proposed recursive least-squares (RLS) implementation for the MRE method. In [Gesbert1997], Gesbert *et al.* introduced the MIMO version of the MRE method. Generally, most of the studies reviewed above and others tried to develop the MRE algorithm in the blind approach. As explained above, they often have one or more drawbacks, e.g., most are not support MIMO; intensive computational is required when the number of equalizers is large; they require several channel information, i.e., channel order and delay between receivers. Hence, SB-MRE [APSIPA2023] uses a few pilot symbols to improve the performance of the B-MRE component. To further enhance its effectiveness, we aim to reduce the overall cost of the SB-MRE method through two key improvements. Firstly, we decrease the complexity of the B-MRE component by reducing the number of equalizers to just 2. Secondly, we employ a straightforward adaptive algorithm that effectively minimizes the number of pilot symbols required in the SB-MRE method. The pseudo code of SB-MRE is shown in **Algorithm 1** and its example in InSI is illustrated in **Figure 1**.

[](../../../pseudo/Algo_SB_MRE.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_SB_MRE.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI Algorithms mode: Semi-blind Mutually Referenced Filters.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Ouahbi2021]: https://www.sciencedirect.com/science/article/abs/pii/S0165168421003340
[GesbertSPAWC]: https://ieeexplore.ieee.org/document/630052
[Gesbert1997]: https://ieeexplore.ieee.org/document/662308
[MRE_original]: https://ieeexplore.ieee.org/document/622953
[APSIPA2023]: https://