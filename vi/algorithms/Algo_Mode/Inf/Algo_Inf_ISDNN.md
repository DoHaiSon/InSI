### Iterative Sequential Deep-neural Network cho mô hình kênh truyền không sử dụng cấu trúc

Mạng Neuron Học Sâu Tuần Tự Lặp (ISDNN) cho mô hình kênh không cấu trúc là một mạng dựa trên mô hình được đề xuất trong [Thesis2023]. Định nghĩa của mô hình kênh không cấu trúc được cho trong Mô hình kênh có cấu trúc CRB. Mục tiêu của mạng này là giảm độ phức tạp của quá trình phát hiện dữ liệu trên hệ thống MIMO khổng lồ bằng cách học quá trình. Mạng này được xây dựng dựa trên bộ ước tính gốc ISD [Mandloi2017] và phương pháp mở rộng sâu. **Algorithm 1** trình bày mã giả của ISDNN cho mô hình không cấu trúc. Lưu ý rằng quá trình huấn luyện ngoại tuyến mất rất nhiều thời gian nên trong InSI, chúng tôi đã nhúng một mô hình đã được huấn luyện và người dùng chỉ cần thử nghiệm trên mô hình này. Do lý do này, đầu vào của thuật toán này có số lượng tham số nhỏ. **Hình 1** minh họa một ví dụ về kết quả đầu ra của ISDNN cho mô hình kênh không cấu trúc ở các giá trị tỷ lệ lỗi khác nhau. Giá trị này đại diện cho lỗi khi tạo tập dữ liệu đầu vào, ví dụ, khi tạo ma trận kênh với tỷ lệ lỗi $\sigma$ như sau:
$$
\mathbf{H}_{imperfect} = \mathbf{H} \pm \sigma\mathbf{H}
$$

[](../../../../pseudo/Algo_I_Unstructured.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_I_Unstructured.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Nhận dạng hệ thống: ISDNN cho mô hình kênh truyền không sử dụng cấu trúc.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Mandloi2017]: https://ieeexplore.ieee.org/document/7778172
[Thesis2023]: https://dohaison.github.io/assets/pdf/2023_Thesis.pdf