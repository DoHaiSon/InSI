### Naive Maximum Likelihood

Trong thực nghiệm này, chúng tôi cung cấp một ví dụ về việc sử dụng (B)CRB để đánh giá hiệu suất của các thuật toán. Cụ thể, chúng tôi xem xét một hệ thống truyền thông được gọi là kênh độ lệch pha động, trong đó tín hiệu bị ảnh hưởng bởi độ lệch pha của tín hiệu mang theo quá trình Wiener. Ở đây, chúng tôi áp dụng một bộ ước tính hợp lý tối đa ngây thơ (MLE). Bộ ước tính này ngây thơ trong ý nghĩa rằng nó không tính đến ảnh hưởng của nhiễu. MLE ngây thơ chỉ sử dụng thông tin về méo pha của tín hiệu nhận được. Bạn có thể thấy trong **Hình 1** rằng hiệu suất của MLE ngây thơ chỉ tiến gần đến BCRB khi tỷ lệ tín hiệu trên nhiễu (SNR) rất cao. Điều này hoàn toàn hợp lý khi xem xét thiết kế của bộ ước tính.

[](../../../../pseudo/Demo_DPTE_Naive_MLE.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_D_DPTE.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Thử nghiệm: CRB và bộ ước tính theo dõi pha động.
</b>
</p>

[Mohamed2020]: https://ieeexplore.ieee.org/document/9187805/