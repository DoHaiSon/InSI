#
> # **Performance mode**

## Non-blind (NB)

- [Finite Impulse Response (FIR) channel model](vi/algorithms/CRB_Mode/NB/CRB_NB_FIR.md)

- [Misspecified model](vi/algorithms/CRB_Mode/SB/CRB_NB_MISSPECIFIED.md)

- Specular channel model

## Blind (B)

- [Fast computation of the Gaussian CRB for blind SIMO system identification](vi/algorithms/CRB_Mode/B/CRB_Fast_GCRB_SIMO.md)

## Semi-blind (SB)

- Finite Impulse Response (FIR) channel model

- [Misspecified model](vi/algorithms/CRB_Mode/SB/CRB_SB_MISSPECIFIED.md)

- Specular channel model

## Side-information (Side-In)

- Structured channel model

## Informed (Inf)

- [Fisher Information Neural Estimation](vi/algorithms/CRB_Mode/Inf/CRB_Inf_FINE.md)


> # **Algorithms mode**

## Non-blind (NB) 

- Zero forcing (ZF)

    - [ZF for MIMO communications](vi/algorithms/Algo_Mode/NB/Algo_NB_ZF.md)

    - [ZF for OFDM](vi/algorithms/Algo_Mode/NB/Algo_NB_ZF-OFDM.md)

- Minimum Mean Square Error (MMSE)

    - [MMSE for MIMO communications](vi/algorithms/Algo_Mode/NB/Algo_NB_MMSE.md)

    - [MMSE for OFDM](vi/algorithms/Algo_Mode/NB/Algo_NB_MMSE-OFDM.md)

## Blind (B)

- Constant modulus algorithm (CMA)

    - CMA Analytical

    - [CMA Gradient](vi/algorithms/Algo_Mode/B/Algo_B_CMA_grad.md)

    - CMA Gradient adaptive

    - CMA Gradient block

    - CMA Gradient Unidimensional

    - CMA Newton

- Cross-relations (CR)

    - CR

    - CR Minimum

    - CR Minimum White

    - CR Unbiased

- Channel subspace (CS)

    - CS

    - CS LSFBL

    - CS LSFNL

    - CS MNS

    - CS OMNS

    - CS SCMA

    - CS SMNS

- [Expectation-Maximization (EM) for Non-linear MIMO communications](vi/algorithms/Algo_Mode/B/Algo_B_EM_Non-linear_MIMO.md)

- [Fisher Information (FI)](vi/algorithms/Algo_Mode/B/Algo_B_FI.md)

- GRDA
    
- Linear Prediction (LP)

- Least Squares Smoothing (LSS)

- Mutually Referenced Filters (MRE)

    - MRE Linear

    - MRE Quadratic

    - MRE Adaptive

- OP

- Singal subspace (SS)

    - SS

    - [SS Fast](vi/algorithms/Algo_Mode/B/Algo_B_SS_Fast.md)

- Two-step Maximum Likelihood (TSML)

## Semi-blind (SB)

- Semi-blind Mutually Referenced Filters (SB-MRE)

    - [SB-MRE](vi/algorithms/Algo_Mode/SB/Algo_SB_MRE.md)

    - SB-MRE\_rc

- [Expectation-Maximization (EM) for Non-linear MIMO communications](vi/algorithms/Algo_Mode/SB/Algo_SB_EM_Non-linear_MIMO.md)

## Side-information (Side-In)

- [Iterative Sequential Deep-neural Network for structured channel model](vi/algorithms/Algo_Mode/Side-In/Algo_Side-In_ISDNN.md)

## Informed (Inf)

- [Iterative Sequential Deep-neural Network for unstructured channel model](vi/algorithms/Algo_Mode/Inf/Algo_Inf_ISDNN.md)


> # **Demo mode**

## MIMO communications

- CRB
    - [Pilot-based](vi/algorithms/CRB_Mode/NB/CRB_NB_FIR.md)
    - Semi-blind
- Estimators
    - [Least-squares (LS)](vi/algorithms/Algo_Mode/NB/Algo_NB_ZF.md)
    - [B-EM](vi/algorithms/Algo_Mode/B/Algo_B_EM_Non-linear_MIMO.md)
    - [SB-EM](vi/algorithms/Algo_Mode/B/Algo_B_EM_Non-linear_MIMO.md)
- Detectors
    - [Least-squares (LS)](vi/algorithms/Algo_Mode/NB/Algo_NB_ZF.md)
    - [B-EM](vi/algorithms/Algo_Mode/B/Algo_B_EM_Non-linear_MIMO.md)
    - [SB-EM](vi/algorithms/Algo_Mode/B/Algo_B_EM_Non-linear_MIMO.md)

## Massive SIMO communications

- CRB
    - [Fast computation of the Gaussian CRB for blind SIMO system identification](vi/algorithms/CRB_Mode/B/CRB_Fast_GCRB_SIMO.md)

## MIMO-OFDM communications

- Estimator 
    - [Fast subspace](vi/algorithms/Algo_Mode/B/Algo_B_SS_Fast.md)

## Indoor localization

- CRB
    - [Beacons settings](vi/algorithms/Demo_Mode/Indoor_Localization/CRB_Indoor_Localization_Beacons.md)

## Dynamic phase tracking estimation

- CRB
    - [Fisher Information Neural Estimation](vi/algorithms/CRB_Mode/Inf/CRB_Inf_FINE.md)

- Estimator
    - [Naive Maximum Likelihood](vi/algorithms/Demo_Mode/DPTE/Demo_DPTE_Naive_MLE.md)