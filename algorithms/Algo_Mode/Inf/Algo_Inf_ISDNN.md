### Iterative Sequential Deep-neural Network for unstructured channel model

Iterative Sequential Deep-neural Network (ISDNN) for unstructured channel model is a model-driven network proposed in [Thesis2023]. The definition of the unstructured channel model is given in CRB Structured channel model. The objective of this network is to reduce the complexity of data detection on massive MIMO systems by learning processes. This network is built based on the original estimator ISD [Mandloi2017] and the deep unfolding method. **Algorithm 1** presents the pseudo code of ISDNN for the unstructured model. Note that the offline-training process lasts a lot of time so in InSI, we embedded a trained model and users only test on this model. Due to this reason, the input of this algorithm has a small number of parameters. **Figure 1** illustrates an example output of ISDNN for the unstructured channel model in different error rate values. This value stands for error when generating the input dataset, for example, when creating a channel matrix with an error rate $\sigma$ as follows:
$$
\mathbf{H}_{imperfect} = \mathbf{H} \pm \sigma\mathbf{H}
$$

[](../../../pseudo/Algo_I_Unstructured.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_I_Unstructured.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. InSI Algorithms mode: ISDNN for unstructured channel model.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Mandloi2017]: https://ieeexplore.ieee.org/document/7778172
[Thesis2023]: https://dohaison.github.io/assets/pdf/2023_Thesis.pdf