### Giải thuật ước lượng kênh truyền nhanh sử dụng không gian con tín hiệu

Trong nghiên cứu [Rekik2023], các tác giả giải quyết thách thức về việc ước tính kênh dựa trên không gian mù và bán mù trong hệ thống truyền thông MIMO-OFDM. Phương pháp đề xuất giảm đáng kể phức tạp tính toán trong khi đảm bảo ước tính kênh chính xác so với các phương pháp hiện có. Bằng cách tận dụng tính chất trực giao trong việc điều chế OFDM, phương pháp ước tính ma trận hiệp phương sai và không gian nhiễu đồng thời cho từng tín hiệu phụ vận. Xử lý song song này được tiếp tục bởi quá trình tối ưu hóa toàn cầu để giảm thiểu một hàm chi phí để tạo ra các ước tính hệ số kênh chính xác. Nghiên cứu cũng đi sâu vào các điều kiện để xác định kênh, cùng việc xác định số lượng tối thiểu của tín hiệu phụ vận cần thiết để có một giải pháp duy nhất. Các mô phỏng số học được thực hiện để xác minh những kết quả này. Với mục đích làm rõ, **Thuật toán 1** tóm tắt mã giả của phương pháp này và một biểu đồ biểu diễn kết quả của nó được trình bày trong **Hình 1**.

[](../../../../pseudo/Algo_B_Fast_SS.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_B_Fast_SS.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Nhận dạng hệ thống: Giải thuật ước lượng kênh truyền nhanh sử dụng không gian con tín hiệu.
</b>
</p>

[Rekik2023]: https://