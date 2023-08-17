### Mô hình Misspecified

Trong nghiên cứu [Thanh2021], tác giả đề xuất các giới hạn thấp về hiệu suất cho ước tính kênh bán mù trong hệ thống MIMO-OFDM với thông tin kênh truyền trước trong trường hợp không chính xác về thứ tự kênh. Chúng tôi đề xuất sử dụng giới hạn Cramer-Rao không chính xác (MCRB), một sự mở rộng của CRB cho các mô hình không chính xác, để phân tích giới hạn hiệu suất lý thuyết của bộ ước tính kênh. Hai biểu thức đóng cho MCRB được rút ra cho các bộ ước tính dựa vào đào tạo không thiên vị và bộ ước tính bán mù. Kết quả thực nghiệm cho thấy rằng thông tin trước như vậy sẽ đạt được giới hạn hiệu suất của bộ ước tính kênh ngay cả khi thứ tự bị đánh giá thấp hơn. **Algorithm 1** cho thấy mã giả của CRB cho mô hình không chính xác. Sau đó, **Hình 1** thể hiện một ví dụ về phiên bản NB và SB không chính xác trong công cụ InSI.

[](../../../../pseudo/CRB_SB_Misspecified.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_NB_Misspecified.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Đánh giá hiệu năng: CRB cho mô hình Misspecified.
</b>
</p>

[Thanh2021]: https://ieeexplore.ieee.org/abstract/document/9537597