#
> # **Các kỹ thuật phân tích hiệu năng hệ thống sử dụng đường bao Cramer-Rao**

## Mô hình sử dụng tín hiệu Pilot (NB)

- [Mô hình kênh đáp ứng xung hữu hạn (FIR)](vi/algorithms/CRB_Mode/NB/CRB_NB_FIR.md)

- [Mô hình Misspecified](vi/algorithms/CRB_Mode/NB/CRB_NB_MISSPECIFIED.md)

- [Mô hình kênh Specular](vi/algorithms/CRB_Mode/NB/CRB_NB_SPECULAR.md)

## Mô hình xử lý mù (B)

- [Ước lượng nhanh chóng Gaussian CRB cho các hệ thống xử lý mù SIMO](vi/algorithms/CRB_Mode/B/CRB_Fast_GCRB_SIMO.md)

## Mô hình xử lý bán mù (SB)

- [Mô hình kênh đáp ứng xung hữu hạn (FIR)](vi/algorithms/CRB_Mode/SB/CRB_SB_FIR.md)

- [Mô hình Misspecified](vi/algorithms/CRB_Mode/SB/CRB_SB_MISSPECIFIED.md)

- [Mô hình kênh Specular](vi/algorithms/CRB_Mode/SB/CRB_SB_SPECULAR.md)

## Mô hình xử lý sử dụng thông tin bên lề (Side-In)

- [Mô hình kênh truyền có cấu trúc](vi/algorithms/CRB_Mode/Side-In/CRB_Side-In_STRUCTURED.md)

## Mô hình xử lý sử dụng tri thức mới (Inf)

- [Ước lượng thông tin Fisher sử dụng mạng Nơ-ron](vi/algorithms/CRB_Mode/Inf/CRB_Inf_FINE.md)


> # **Các giải thuật ước lượng kênh truyền**

## Kỹ thuật nhận dạng hệ thống sử dụng tín hiệu Pilot (NB) 

- Zero forcing (ZF)

    - [ZF cho các hệ MIMO](vi/algorithms/Algo_Mode/NB/Algo_NB_ZF.md)

    - [ZF cho các hệ OFDM](vi/algorithms/Algo_Mode/NB/Algo_NB_ZF-OFDM.md)

- Minimum Mean Square Error (MMSE)

    - [MMSE cho các hệ MIMO](vi/algorithms/Algo_Mode/NB/Algo_NB_MMSE.md)

    - [MMSE cho các hệ OFDM](vi/algorithms/Algo_Mode/NB/Algo_NB_MMSE-OFDM.md)

## Kỹ thuật nhận dạng hệ thống mù (B)

- Giải thuật Constant modulus (CMA)

    - CMA Analytical

    - [CMA Gradient](vi/algorithms/Algo_Mode/B/Algo_B_CMA_grad.md)

    - CMA Gradient adaptive

    - CMA Gradient block

    - CMA Gradient Unidimensional

    - CMA Newton

- Cross-relations (CR)

    - [CR](vi/algorithms/Algo_Mode/B/Algo_B_CR.md)

    - CR Minimum

    - CR Minimum White

    - CR Unbiased

- Không gian con kênh truyền (CS)

    - [CS](vi/algorithms/Algo_Mode/B/Algo_B_CS.md)

    - CS LSFBL

    - CS LSFNL

    - CS MNS

    - CS OMNS

    - CS SCMA

    - CS SMNS

- [Expectation-Maximization (EM) cho kênh truyền MIMO phi tuyến tính](vi/algorithms/Algo_Mode/B/Algo_B_EM_Non-linear_MIMO.md)

- [Thông tin Fisher (FI)](vi/algorithms/Algo_Mode/B/Algo_B_FI.md)

- [GRDA](vi/algorithms/Algo_Mode/B/Algo_B_GRDA.md)
    
- [Linear Prediction (LP)](vi/algorithms/Algo_Mode/B/Algo_B_LP.md)

- [Least Squares Smoothing (LSS)](vi/algorithms/Algo_Mode/B/Algo_B_LSS.md)

- Mutually Referenced Filters (MRE)

    - MRE Linear

    - [MRE Quadratic](vi/algorithms/Algo_Mode/B/Algo_B_MRE.md)

    - MRE Adaptive

- [OP](vi/algorithms/Algo_Mode/B/Algo_B_OP.md)

- Không gian con tín hiệu (SS)

    - [SS](vi/algorithms/Algo_Mode/B/Algo_B_SS.md)

    - [SS Fast](vi/algorithms/Algo_Mode/B/Algo_B_SS_Fast.md)

- [Two-step Maximum Likelihood (TSML)](vi/algorithms/Algo_Mode/B/Algo_B_TSML.md)

## Kỹ thuật nhận dạng hệ thống bán mù (SB)

- Semi-blind Mutually Referenced Filters (SB-MRE)

    - [SB-MRE](vi/algorithms/Algo_Mode/SB/Algo_SB_MRE.md)

    - [SB-MRE\_rc](vi/algorithms/Algo_Mode/SB/Algo_SB_MRE_rc.md)

- [Expectation-Maximization (EM) cho kênh truyền MIMO phi tuyến tính](vi/algorithms/Algo_Mode/SB/Algo_SB_EM_Non-linear_MIMO.md)

## Kỹ thuật nhận dạng hệ thống sử dụng thông tin bên lề (Side-In)

- [Iterative Sequential Deep-neural Network cho mô hình kênh truyền có cấu trúc](vi/algorithms/Algo_Mode/Side-In/Algo_Side-In_ISDNN.md)

## Kỹ thuật nhận dạng hệ thống sử dụng tri thức mới (Inf)

- [Iterative Sequential Deep-neural Network cho mô hình kênh truyền không sử dụng cấu trúc](vi/algorithms/Algo_Mode/Inf/Algo_Inf_ISDNN.md)


> # **Các mô hình thử nghiệm**

## Các hệ thống truyền thông MIMO

- CRB
    - Pilot-based
    - Semi-blind
- Bộ ước lượng
    - Least-squares (LS)
    - B-EM
    - SB-EM
- Bộ nhận dạng
    - Least-squares (LS)
    - B-EM
    - SB-EM

## Các hệ thống truyền thông SIMO-OFDM

- CRB
    - [Ước lượng nhanh chóng Gaussian CRB cho các hệ thống xử lý mù SIMO](vi/algorithms/CRB_Mode/B/CRB_Fast_GCRB_SIMO.md)

## Định vị trong nhà

- CRB
    - [Xác định số lượng và vị trí các beacons](vi/algorithms/Demo_Mode/Indoor_Localization/CRB_Indoor_Localization_Beacons.md)

## Ước lượng theo dõi pha động

- CRB
    - [Ước lượng thông tin Fisher sử dụng mạng Nơ-ron](vi/algorithms/CRB_Mode/Inf/CRB_Inf_FINE.md)

- Bộ ước lượng
    - [Naive Maximum Likelihood](vi/algorithms/Demo_Mode/DPTE/Demo_Naive_MLE.md)