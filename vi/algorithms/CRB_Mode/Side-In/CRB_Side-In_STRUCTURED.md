### Mô hình kênh truyền có cấu trúc

Trong truyền thông, để khôi phục các tín hiệu nguồn một cách chính xác, hệ thống phải có thông tin trạng thái kênh (CSI). Các ký hiệu đào tạo biết trước, còn được gọi là ký hiệu định vị, được chèn vào các chuỗi dữ liệu để ước tính CSI và đồng bộ hóa. Độ dài của chuỗi định vị nên lớn hơn số phần tử trong mảng ăng-ten. Do số lượng phần tử ăng-ten lớn, ước tính kênh trong các hệ thống massive MIMO rất phức tạp với thời gian đào tạo dài [Liang2019]. Có hai mô hình kênh không dây phổ biến là mô hình không cấu trúc và mô hình cấu trúc. Mô hình không cấu trúc được sử dụng chủ yếu vì tính đơn giản nhưng thực sự không phù hợp cho sóng milimet với một số sóng phản xạ quan trọng. Bài báo này liên quan đến ước tính kênh bán mù trong hệ thống MIMO-OFDM sóng milimet. Các thuật toán ước tính kênh bán mù là sự kết hợp của các phương pháp dựa vào đào tạo truyền thống và các phương pháp mù. Chúng sử dụng một số ký hiệu định vị và các loại thông tin khác [abed1997]. Các thuật toán bán mù có thể giảm số lượng ký hiệu định vị một cách hiệu quả nhưng vẫn duy trì độ chính xác chấp nhận được [Rekik2021]. Trong mô hình kênh không cấu trúc, các đoạn đường giữa mỗi cặp ăng-ten truyền và ăng-ten thu được mô tả dưới dạng các hệ số phức [Swindlehurst2022], trong khi mô hình cấu trúc bao gồm các hệ số phức, Hướng của Khởi hành (DoD), và Hướng của Đến (DoA). Mô hình này cũng được gọi là mô hình kênh gương hoặc hình học [Ladaycia2017], [Swindlehurst2022].

<p float="left" style="text-align-last: center">
  <img src="./assets/img/Outputs/ULA.png" width=40%/>
  <img src="./assets/img/Outputs/UCyA.png" style="margin-left:10%" width=44%/>
</p>
<p style="text-align-last: center">
<b>
Figure 1. Các cấu hình ăng-ten được quan tâm: (a), Mảng thẳng cách đều (ULA); (b), Mảng trụ đồng nhất (UCyA).
</b>
</p>

Trong phần này [Son2023], chúng tôi phân tích ranh giới hiệu suất ước tính kênh bán mù trong các hình học mảng MIMO ba chiều. Đối với phương pháp bán mù, ngoài phần ký hiệu định vị, các ký hiệu dữ liệu được cho là độc lập và có thống kê biết trước. Hiệu suất của hệ thống được đo bằng CRB [Ladaycia2017] cho hai cấu trúc mảng ăng-ten, tức là Mảng Tuyến Tính Đồng Đều (ULA) và Mảng Trụ Đồng Đều (UCyA) như được thể hiện trong Hình 1. Từ kết quả mô phỏng, Mảng UCyA vượt trội hơn so với mảng ULA truyền thống liên quan đến SNR và số lượng phần tử trong mảng. Thuật toán 1 hiển thị mã giả cho mô hình kênh cấu trúc. Sau đó, Hình 2 thể hiện so sánh của CRB cho mô hình kênh cấu trúc sử dụng cấu hình ăng-ten ULA và UCyA trên công cụ InSI.

[CRB for structured channel model](../../../../pseudo/CRB_SI_Structured.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_SI_Structured.png">
</p>
<p style="text-align-last: center">
<b>
Figure 1. Đánh giá hiệu năng: Mô hình kênh truyền có cấu trúc.
</b>
</p>


[Liang2019]: https://ieeexplore.ieee.org/document/8807374
[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[abed1997]: https://ieeexplore.ieee.org/abstract/document/622507/
[Rekik2021]: https://ieeexplore.ieee.org/document/9723265/
[Son2023]: https://dohaison.github.io/assets/pdf/2023_SSP.pdf
[Swindlehurst2022]: https://ieeexplore.ieee.org/document/9771077