### Misspecified model

In [Thanh2021], we derive performance lower bounds for semi-blind channel estimation in MIMO-OFDM systems with prior propagation channel information in the presence of channel order misspecification. We propose to use the misspecified Cramer-Rao bound (MCRB), which is an extension of CRB for misspecification models, to analyze the theoretical performance limit of channel estimators. Two closed-form expressions of the MCRB are derived for unbiased training-based estimators and semi-blind estimators. Experimental results indicate that such prior information will gain the performance limit of channel estimators even when the order is underestimated. **Algorithm 1** shows the pseudo code of CRB for the misspecified model. Then, **Figure 1** represents an example of NB and SB versions misspecified in the InSI toolbox.

[](../../../pseudo/CRB_SB_Misspecified.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_NB_Misspecified.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Performance analysis: CRB for Misspecified model.
</b>
</p>

[Thanh2021]: https://ieeexplore.ieee.org/abstract/document/9537597