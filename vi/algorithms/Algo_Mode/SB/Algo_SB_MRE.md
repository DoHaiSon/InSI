### Mutually Referenced Filters bán mù 

Trong giải thuật này, chúng tôi tập trung vào thuật toán "Bộ điều chỉnh có tương quan" (MRE) mù [MRE_original], là một thuật toán nhanh, hội tụ toàn cầu và linh hoạt trong việc triển khai (ví dụ, Batch, LMS, RLS, ...). Kể từ năm 1997, đã có một số nghiên cứu được đề xuất để phát triển thuật toán MRE. [GesbertSPAWC] đầu tiên đề xuất việc triển khai bằng phương pháp bình phương nhỏ nhất theo cách đệ quy (RLS) cho phương pháp MRE. Trong [Gesbert1997], Gesbert *et al.* giới thiệu phiên bản MIMO của phương pháp MRE. Nói chung, hầu hết các nghiên cứu được xem xét ở trên và các nghiên cứu khác đã cố gắng phát triển thuật toán MRE trong cách tiếp cận mù. Như đã giải thích ở trên, chúng thường có một hoặc nhiều hạn chế, ví dụ, hầu hết không hỗ trợ MIMO; yêu cầu tính toán tập trung cao khi số bộ điều chỉnh lớn; yêu cầu thông tin kênh nhiều, tức là thứ tự kênh và độ trễ giữa các bộ thu. Do đó, SB-MRE [APSIPA2023] sử dụng một số ký hiệu đào tạo để cải thiện hiệu suất của thành phần B-MRE. Để nâng cao hiệu quả của nó, chúng tôi nhằm giảm tổng chi phí của phương pháp SB-MRE thông qua hai cải tiến chính. Thứ nhất, chúng tôi giảm độ phức tạp của thành phần B-MRE bằng cách giảm số bộ điều chỉnh xuống chỉ còn 2. Thứ hai, chúng tôi sử dụng một thuật toán thích ứng đơn giản mà hiệu quả để giảm thiểu số ký hiệu đào tạo cần thiết trong phương pháp SB-MRE. Mã giả của SB-MRE được hiển thị trong **Algorithm 1** và ví dụ của nó trong InSI được minh họa trong **Hình 1**.

[](../../../../pseudo/Algo_SB_MRE.md ':include :type=code algorithm')


<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_Algo_SB_MRE.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Nhận dạng hệ thống: Mutually Referenced Filters bán mù.
</b>
</p>

[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230
[Ouahbi2021]: https://www.sciencedirect.com/science/article/abs/pii/S0165168421003340
[GesbertSPAWC]: https://ieeexplore.ieee.org/document/630052
[Gesbert1997]: https://ieeexplore.ieee.org/document/662308
[MRE_original]: https://ieeexplore.ieee.org/document/622953
[APSIPA2023]: https://