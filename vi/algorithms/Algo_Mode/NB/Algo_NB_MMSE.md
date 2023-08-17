### Minimum Mean Square Error cho các hệ MIMO

Phương pháp Sai Số Trung Bình Tối Thiểu (MMSE) [Kay1993] là một kỹ thuật cân bằng khác được áp dụng trong hệ thống truyền thông không dây. Phương pháp MMSE nhằm giảm thiểu sai số bình phương trung bình giữa tín hiệu nhận được và tín hiệu truyền ước tính bằng cách xem xét các tính chất thống kê của kênh và nhiễu. Phương pháp MMSE được đánh giá cao về khả năng xử lý các điều kiện nhiễu và nhiễu khác nhau. Tuy nhiên, nó yêu cầu tính toán phức tạp hơn so với các kỹ thuật trực tiếp như Zero Forcing. Bất chấp độ phức tạp tính toán, phương pháp MMSE hoạt động tốt hơn trong các tình huống có môi trường nhiễu và nhiễu khó khăn.

**Algorithm 1** là mã giả của các thuật toán ZF và MMSE cho truyền thông MIMO. Sau đó, **Hình 1** thể hiện sự so sánh của tỷ lệ lỗi ký hiệu (SER) sử dụng hai thuật toán trên công cụ InSI.

[quicksort](../../../../pseudo/Algo_NB_ZF.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="../../../assets/img/Outputs/InSI_Algo_NB_ZF.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Nhận dạng hệ thống: ZF và MMSE cho các hệ MIMO.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230