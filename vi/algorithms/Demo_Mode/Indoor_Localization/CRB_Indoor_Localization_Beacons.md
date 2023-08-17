### Xác định số lượng và vị trí các beacons cho bài toán định vị trong nhà

Trong thực nghiệm này, chúng tôi triển khai phương pháp FINE [Duy2023] để ước tính CRB Bayesian cho kịch bản định vị trong nhà. Mục tiêu của chúng tôi là xác định vị trí 2D của đối tượng mục tiêu di chuyển trong vùng quan tâm (ROI) hình vuông màu đỏ. Có tám bộ phát cố định và một số vật cản và bức tường trong môi trường. Chúng tôi thu thập các đo lường độ mạnh tín hiệu nhận được (RSS) giữa các bộ phát và các điểm trong ROI từ mô phỏng sử dụng Wireless Insite, một nền tảng theo dõi tia phổ biến. Các mẫu RSS này sau đó được đưa vào FINE để học BCRB của việc ước tính các thành phần $x$ và $y$ của vị trí. Người ta có thể chọn để kích hoạt và vô hiệu hóa bất kỳ bộ phát nào trong tập. BCRB có thể cho thấy ảnh hưởng của mỗi bộ phát đối với hiệu suất ước tính của hai thành phần của vị trí như minh họa trong **Algorithm 1**. Một số kết quả được hiển thị trong **Hình 1**.

[](../../../../pseudo/Demo_DPTE_Naive_MLE.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_D_IL.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Thử nghiệm: Xác định số lượng và vị trí các beacons cho bài toán định vị trong nhà.
</b>
</p>

[Duy2023]: https://www.rev-jec.org/index.php/rev-jec/article/view/322/269