### Ước lượng thông tin Fisher sử dụng mạng Nơ-ron

Bài báo ước tính thông tin Fisher bằng mạng nơ-ron [Duy2023], được gọi là FINE, là một phương pháp thực nghiệm để ước tính ma trận thông tin Fisher (FIM). FINE không yêu cầu kiến thức về mô hình thống kê cơ bản và có thể được áp dụng để ước tính cả FIM và FIM Bayesian (BFIM), tức là phương pháp có thể áp dụng khi các thông số không biết cần quan tâm là xác định hoặc ngẫu nhiên. Ở đây, chúng tôi xem xét kênh pha động trong đó tín hiệu bị ảnh hưởng bởi sự lệch pha tần số theo quy trình Wiener. Giới hạn Cramer-Rao bayesian ước tính bằng FINE được so sánh với giới hạn Cramer-Rao phân tích và một xấp xỉ chạy theo hướng gọi là ABCRB. **Algorithm 1** cho thấy mã giả của CRB sử dụng phương pháp FINE. Sau đó, **Hình 1** thể hiện một so sánh của CRB bằng FINE, BCRB và ABCRB bằng công cụ InSI.

[](../../../../pseudo/CRB_I_FINE.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_I_FINE.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Đánh giá hiệu năng: FINE.
</b>
</p>

[Duy2023]: https://www.rev-jec.org/index.php/rev-jec/article/view/322/269