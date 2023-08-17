### Iterative Sequential Deep-neural Network cho mô hình kênh truyền có cấu trúc

Trong luận văn [Thesis2023], chúng tôi đã mở rộng phương pháp ISDNN để điều chỉnh các kịch bản liên quan đến thông tin phụ. Cụ thể, chúng tôi giả định rằng trước giai đoạn phát hiện dữ liệu, một số chi tiết nhất định - chẳng hạn như Hướng sóng đến (DoA) của bộ truyền và cấu hình của mảng ăng-ten của bộ thu, được biểu thị bởi $\boldsymbol{\varphi}$ - có sẵn. Tận dụng mô hình kênh có cấu trúc được mô tả trong CRB cho mô hình kênh có cấu trúc, thông tin này được sử dụng để chuyển đổi ma trận kênh ước tính $\mathbf{H}$ thành ma trận các hệ số đường truyền, được ký hiệu là $\boldsymbol{\beta}$. Qua kết quả mô phỏng của chúng tôi, chúng tôi đã chứng minh rằng việc sử dụng $\boldsymbol{\beta}$ thay vì $\mathbf{H}$ làm đầu vào cho mạng ISDNN được đề xuất mang lại hiệu suất tốt hơn so với phương pháp ISDNN gốc được thiết kế cho mô hình kênh không cấu trúc. Biểu diễn thuật toán của ISDNN cho mô hình kênh có cấu trúc có thể được tìm thấy trong **Algorithm 1**, trong khi các kết quả mô phỏng tương ứng được trình bày trong **Hình 1**.


[](../../../../pseudo/Algo_SI_Structured.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_SI_Structured.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Nhận dạng hệ thống: ISDNN cho mô hình kênh truyền có cấu trúc.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Mandloi2017]: https://ieeexplore.ieee.org/document/7778172
[Thesis2023]: https://dohaison.github.io/assets/pdf/2023_Thesis.pdf