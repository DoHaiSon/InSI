### Zero forcing cho các hệ MIMO

Giải thuật Zero Forcing (ZF) [Kay1993] được sử dụng như một phương pháp cân bằng tuyến tính trong các hệ thống truyền thông không dây để chống lại các vấn đề như nhiễu nhiều ký hiệu (ISI) và nhiễu đồng kênh. Những vấn đề này xuất hiện khi nhiều tín hiệu được gửi đồng thời qua cùng một kênh, gây chồng chéo và gây xáo trộn cho nhau. Mục tiêu chính của mô hình kênh ZF là loại bỏ hoặc giảm thiểu nhiễu này bằng cách thực hiện việc nghịch đảo ma trận kênh. Khi xem xét các hệ thống MIMO, trong đó có nhiều ăng-ten cho cả truyền và thu sóng, bộ cân bằng ZF áp dụng nghịch đảo của ma trận kênh để tiền xử lý tín hiệu nhận được. Tiền xử lý này hiệu quả làm giảm thiểu các thành phần nhiễu, dẫn đến thuật ngữ "Zero Forcing". Mục tiêu chính của bộ cân bằng ZF là giảm nhiễu bằng cách thực hiện việc nghịch đảo ma trận kênh. Việc nghịch đảo ma trận $\mathbf{h}$ cho phép chúng ta đảo ngược tác động của kênh lên tín hiệu được truyền $\mathbf{s}$. Kết quả là, tín hiệu nhận được $\mathbf{x}$ có thể tái tạo lại tín hiệu gốc được truyền trong khi giảm thiểu nhiễu.

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