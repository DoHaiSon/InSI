### Beacons settings for indoor localization

In this section, we deploy the FINE method [Duy2023] to estimate the Bayesian CRB for an indoor localization scenario. We aim to determine the 2D position of the target object moving in the red square region of interest (ROI). There are eight fixed-position beacons and few obstacles and walls in the environment. We collect the measurements of received signal strength (RSS) between the beacons and points in the ROI from simulation using Wireless Insite, a popular ray-tracing platform. These samples of RSS are then fed to FINE to learn the BCRB of estimating the $x$ and $y$ components of the position. One can choose to activate and deactivate any beacon in the set. The BCRB can give the impact of each of the beacons on the estimation performance of the two components of the position as illustrated in **Algorithm 1**. Some results are shown in **Figure 1**.

[](../../../pseudo/Demo_DPTE_Naive_MLE.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_D_IL.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Demonstrations: Beacons settings for Indoor localization.
</b>
</p>

[Duy2023]: https://www.rev-jec.org/index.php/rev-jec/article/view/322/269