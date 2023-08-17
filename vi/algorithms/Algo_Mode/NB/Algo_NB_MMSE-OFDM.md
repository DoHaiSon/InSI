### Minimum Mean Square Error cho các hệ OFDM

SISO-OFDM [Cho2010] là một hệ thống truyền thông trong đó một bộ phát đơn gửi dữ liệu qua một kênh đến một bộ thu đơn bằng cách sử dụng mô hình điều chế OFDM. OFDM chia luồng dữ liệu tốc độ cao thành nhiều luồng con tốc độ thấp hơn được truyền song song qua các tín hiệu phụ vận. Điều này giúp chống lại tác động của mất đường đi nhiều lối và mất kênh tùy chọn tần số, làm cho nó phù hợp cho việc truyền thông tốc độ dữ liệu cao và mạnh mẽ. **Thuật toán 1** cho thấy mã giả của các thuật toán ZF và MMSE cho truyền thông OFDM. Sau đó, **Hình 1** thể hiện sự so sánh của tỷ lệ lỗi ký hiệu (SER) sử dụng hai thuật toán trên công cụ InSI.

[](../../../../pseudo/Algo_NB_ZF-OFDM.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_NB_ZF-OFDM.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Nhận dạng hệ thống: ZF and MMSE cho các hệ SISO-OFDM.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Cho2010]: https://ieeexplore.ieee.org/book/5675894