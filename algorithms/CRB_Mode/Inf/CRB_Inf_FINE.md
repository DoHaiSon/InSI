### Fisher Information Neural Estimation

Fisher information neural estimatio [Duy2023], which is referred to as FINE, is an empirical method to estimate the Fisher information matrix (FIM). FINE does not require the knowledge of the underlying statistical model and can be applied to estimate both the FIM and the Bayesian FIM (BFIM), i.e., the method is applicable when the unknown parameters of interest are either deterministic or random. Here, we consider the dynamical phase offset channel where the signal is affected by carrier phase offsets following a Wiener process. The BCRB estimated by FINE is compared with the analytical BCRB and an asymptotic approximation so-called ABCRB. **Algorithm 1** shows the pseudo code of CRB using FINE method. Then, **Figure 1** represents a comparison of CRB by FINE, BCRB, and ABCRB using InSI toolbox.

[](../../../pseudo/CRB_I_FINE.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_I_FINE.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Performance analysis: FINE.
</b>
</p>

[Duy2023]: https://www.rev-jec.org/index.php/rev-jec/article/view/322/269