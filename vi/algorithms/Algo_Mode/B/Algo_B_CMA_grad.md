### Giải thuật Constant modulus

Một thuật toán lọc kỹ thuật số thích nghi có khả năng bù đắp cho cả hiệu ứng đa đường tần số lựa chọn và nhiễu trên các tín hiệu điều chế với mô hình hộp hằn cố định được trình bày. Phương pháp này khai thác thực tế rằng việc tiếp nhận tín hiệu đa đường và các nguồn nhiễu khác tạo ra hiệu ứng biến đổi biên độ ngẫu nhiên trên tín hiệu nhận được. Một loại hàm hiệu suất đơn điệu cố định, gọi là hàm hệ số mô đun không nhạy cảm với biến đổi góc, được phát triển. Thuật toán thích nghi đơn giản cho bộ lọc số hữu hạn phản hồi xung (FIR) kỹ thuật số được thực hiện bằng cách tìm kiếm gradient của hàm hiệu suất. Nó được gọi là Thuật toán Mô đun Hằn Cố định [CMA]. Pseudo của thuật toán này được hiển thị trong **Algorithm 1**, và trong bộ công cụ, giao diện của CMA được hiển thị trong **Hình 1**.

[Giải thuật Constant modulus](../../../../pseudo/Algo_B_CMA_grad.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_B_CMA.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Nhận dạng hệ thống: Giải thuật Constant modulus.
</b>
</p>

[CMA]: https://ieeexplore.ieee.org/document/1164062