### Expectation-Maximization (EM) cho kênh truyền MIMO phi tuyến tính

Trong các hệ thống truyền thông hiện đại, các hiện tượng biến dạng phi tuyến đang đại diện cho một thách thức quan trọng ảnh hưởng đáng kể đến hiệu suất. Để giải quyết vấn đề này, các tác giả trong [Ouahbi2021] tập trung vào việc xác định mù và bán mù của kênh phi tuyến Đa Đầu Vào Một Đầu Ra (SIMO) và Đa Đầu Vào Đa Đầu Ra (MIMO). Những kênh này thường xuất hiện trong các tình huống thực tế và có thể thể hiện các phi tuyến chất bậc hai và bậc ba, làm tăng thêm phức tạp cho mô hình hệ thống. Hơn nữa, các tác giả cung cấp cái nhìn sâu rộng để mở rộng công việc của họ để bao gồm các mô hình phi tuyến rộng hơn, nâng cao tính ứng dụng của nó. Phương pháp của các tác giả bắt đầu bằng giải pháp mù, được khởi đầu bởi một kỹ thuật không gian con. Phương pháp này đóng vai trò là nền tảng cho các bước tiếp theo nhằm loại bỏ sự mập mờ trong quá trình xác định kênh. Để tinh chỉnh kết quả thêm, các tác giả sử dụng một chiến lược xử lý dựa trên Xác Suất Tối Đa (ML), được hỗ trợ bởi thuật toán Expectation-Maximization (EM). Thuật toán mạnh mẽ này tăng cường độ chính xác của việc ước tính kênh, đặc biệt là trong các tình huống khó khăn. Đối với việc xác định kênh bán mù, tích hợp cả tín hiệu dữ liệu và tín hiệu đào tạo, giải pháp của các tác giả hoàn toàn dựa vào thuật toán EM. Phương pháp này cho phép các tác giả tận dụng hiệu quả thông tin có sẵn và tăng cường độ chính xác của việc ước tính theo phương pháp lặp. Để hỗ trợ tính mạnh mẽ và cơ sở lý thuyết của các giải pháp đề xuất của các tác giả, họ đi sâu vào kết quả về khả năng xác định và phân tích giới hạn hiệu suất. Phân tích này thêm một lớp đảm bảo về độ tin cậy và hiệu quả của các phương pháp, đặc biệt trong ngữ cảnh mù và bán mù. Đối với công cụ InSI, chúng tôi tóm tắt ngắn gọn mã giả của SB-EM trong **Algorithm 1** và ví dụ về phương pháp này như thể hiện trong **Hình 1**.

[](../../../../pseudo/Algo_SB_EM.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_SB_EM.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Nhận dạng hệ thống: Expectation-Maximization (EM) cho kênh truyền MIMO phi tuyến tính.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Ouahbi2021]: https://www.sciencedirect.com/science/article/abs/pii/S0165168421003340