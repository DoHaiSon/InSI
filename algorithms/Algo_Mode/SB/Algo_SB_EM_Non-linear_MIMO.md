### Expectation-Maximization (EM) for Non-linear MIMO communications

In modern communications systems, nonlinear distortions represent a critical challenge that significantly impacts performance. Addressing this concern, the authors in [Ouahbi2021] focused on the blind and semi-blind identification of nonlinear Single-Input Multiple-Output (SIMO) and Multiple-Input Multiple-Output (MIMO) channels. These channels are often encountered in real-world scenarios and can exhibit quadratic and cubic nonlinearities, adding complexity to the system model. Moreover, the authors provide insights into extending their work to encompass broader nonlinear models, enhancing its applicability. The authors' approach commences with the blind solution, initiated by a subspace technique. This approach serves as the foundation for subsequent steps aimed at removing ambiguities in the channel identification process. To further refine the results, the authors employ a Maximum Likelihood (ML) based processing strategy, facilitated by the Expectation-Maximization (EM) algorithm. This powerful algorithm enhances the accuracy of channel estimation, especially in challenging scenarios. For semi-blind channel identification, which incorporates both data and pilot signals, the authors' solution relies entirely on the EM algorithm. This approach allows the authors to effectively leverage the available information and iteratively enhance the estimation accuracy. To support the robustness and theoretical underpinnings of the authors' proposed solutions, they delve into identifiability results and performance bounds analysis. This analysis adds a layer of assurance regarding the reliability and effectiveness of the methods, particularly in blind and semi-blind contexts. For the InSI toolbox, we shortly provide the pseudo of SB-EM in **Algorithm 1** and the example of this method as shown in **Figure 1**.

[](../../../pseudo/Algo_SB_EM.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_SB_EM.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI Algorithms mode: Expectation-Maximization (EM) for Non-linear MIMO communications.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Ouahbi2021]: https://www.sciencedirect.com/science/article/abs/pii/S0165168421003340