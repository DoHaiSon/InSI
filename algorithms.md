#
> # **Performance mode**

## Non-blind (NB)

- [Finite Impulse Response (FIR) channel model](algorithms/CRB_Mode/NB/CRB_NB_FIR.md)

- [Misspecified model](algorithms/CRB_Mode/NB/CRB_NB_MISSPECIFIED.md)

- [Specular channel model](algorithms/CRB_Mode/NB/CRB_NB_SPECULAR.md)

## Blind (B)

- [Fast computation of the Gaussian CRB for blind SIMO system identification](algorithms/CRB_Mode/B/CRB_Fast_GCRB_SIMO.md)

## Semi-blind (SB)

- [Finite Impulse Response (FIR) channel model](algorithms/CRB_Mode/SB/CRB_SB_FIR.md)

- [Misspecified model](algorithms/CRB_Mode/SB/CRB_SB_MISSPECIFIED.md)

- [Specular channel model](algorithms/CRB_Mode/SB/CRB_SB_SPECULAR.md)

## Side-information (Side-In)

- [Structured channel model](algorithms/CRB_Mode/Side-In/CRB_Side-In_STRUCTURED.md)

## Informed (Inf)

- [Fisher Information Neural Estimation](algorithms/CRB_Mode/Inf/CRB_Inf_FINE.md)


> # **Algorithms mode**

## Non-blind (NB) 

- Zero forcing (ZF)

    - [ZF for MIMO communications](algorithms/Algo_Mode/NB/Algo_NB_ZF.md)

    - [ZF for OFDM](algorithms/Algo_Mode/NB/Algo_NB_ZF-OFDM.md)

- Minimum Mean Square Error (MMSE)

    - [MMSE for MIMO communications](algorithms/Algo_Mode/NB/Algo_NB_MMSE.md)

    - [MMSE for OFDM](algorithms/Algo_Mode/NB/Algo_NB_MMSE-OFDM.md)

## Blind (B)

- Constant modulus algorithm (CMA)

    - CMA Analytical

    - [CMA Gradient](algorithms/Algo_Mode/B/Algo_B_CMA_grad.md)

    - CMA Gradient adaptive

    - CMA Gradient block

    - CMA Gradient Unidimensional

    - CMA Newton

- Cross-relations (CR)

    - [CR](algorithms/Algo_Mode/B/Algo_B_CR.md)

    - CR Minimum

    - CR Minimum White

    - CR Unbiased

- Channel subspace (CS)

    - [CS](algorithms/Algo_Mode/B/Algo_B_CS.md)

    - CS LSFBL

    - CS LSFNL

    - CS MNS

    - CS OMNS

    - CS SCMA

    - CS SMNS

- [Expectation-Maximization (EM) for Non-linear MIMO communications](algorithms/Algo_Mode/B/Algo_B_EM_Non-linear_MIMO.md)

- [Fisher Information (FI)](algorithms/Algo_Mode/B/Algo_B_FI.md)

- [GRDA](algorithms/Algo_Mode/B/Algo_B_GRDA.md)
    
- [Linear Prediction (LP)](algorithms/Algo_Mode/B/Algo_B_LP.md)

- [Least Squares Smoothing (LSS)](algorithms/Algo_Mode/B/Algo_B_LSS.md)

- Mutually Referenced Filters (MRE)

    - MRE Linear

    - [MRE Quadratic](algorithms/Algo_Mode/B/Algo_B_MRE.md)

    - MRE Adaptive

- [OP](algorithms/Algo_Mode/B/Algo_B_OP.md)

- Singal subspace (SS)

    - [SS](algorithms/Algo_Mode/B/Algo_B_SS.md)

    - [SS Fast](algorithms/Algo_Mode/B/Algo_B_SS_Fast.md)

- [Two-step Maximum Likelihood (TSML)](algorithms/Algo_Mode/B/Algo_B_TSML.md)

## Semi-blind (SB)

- Semi-blind Mutually Referenced Filters (SB-MRE)

    - [SB-MRE](algorithms/Algo_Mode/SB/Algo_SB_MRE.md)

    - [SB-MRE\_rc](algorithms/Algo_Mode/SB/Algo_SB_MRE_rc.md)

- [Expectation-Maximization (EM) for Non-linear MIMO communications](algorithms/Algo_Mode/SB/Algo_SB_EM_Non-linear_MIMO.md)

## Side-information (Side-In)

- [Iterative Sequential Deep-neural Network for structured channel model](algorithms/Algo_Mode/Side-In/Algo_Side-In_ISDNN.md)

## Informed (Inf)

- [Iterative Sequential Deep-neural Network for unstructured channel model](algorithms/Algo_Mode/Inf/Algo_Inf_ISDNN.md)


> # **Demo mode**

## MIMO communications

- CRB
    - Pilot-based
    - Semi-blind
- Estimators
    - Least-squares (LS)
    - B-EM
    - SB-EM
- Detectors
    - Least-squares (LS)
    - B-EM
    - SB-EM

## SIMO-OFDM communications

- CRB
    - [Fast computation of the Gaussian CRB for blind SIMO system identification](algorithms/CRB_Mode/B/CRB_Fast_GCRB_SIMO.md)

## Indoor localization

- CRB
    - [Beacons settings](algorithms/Demo_Mode/Indoor_Localization/CRB_Indoor_Localization_Beacons.md)

## Dynamic phase tracking estimation

- CRB
    - [Fisher Information Neural Estimation](algorithms/CRB_Mode/Inf/CRB_Inf_FINE.md)

- Estimator
    - [Naive Maximum Likelihood](algorithms/Demo_Mode/DPTE/Demo_Naive_MLE.md)