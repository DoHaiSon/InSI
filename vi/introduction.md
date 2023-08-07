#
# Các thông số của InSI

Hỗ trợ cả người dùng chuyên nghiệp và cá nhân, toolbox này được thiết kế cho nghiên cứu và phát triển cũng như giảng dạy. Chúng tôi hướng tới việc dễ sử dụng và khả năng mở rộng bao gồm:

- **Giao diện**:
    - Tương tác: các thuật toán trong viễn thông thường ở dạng trừu tượng và không trực quan cho người mới bắt đầu (ví dụ, sinh viên) hiểu thông số đầu vào của chúng. Do đó, chúng tôi nhấn mạnh trực quan hóa trong toolbox của chúng tôi. Ví dụ, khi người dùng chọn một thông số, một đoạn phim tương ứng sẽ xuất hiện trên mô hình hệ thống để người dùng có thể quan sát hiệu ứng của thông số này. Do đó, đối với mỗi thuật toán, phải bao gồm một mô hình hệ thống cùng với bộ thông số và tương tác của nó.

    - Độc lập: 
        - Thuật toán: mỗi nghiên cứu thường có các giả định và điều kiện thử nghiệm khác nhau. Do đó, trong toolbox này, chúng tôi chia các thuật toán được chọn thành các mô-đun độc lập, với các bộ thông số tương ứng, mô hình hệ thống, giá trị mặc định, và các yếu tố khác để mang lại kết quả gần nhất với nghiên cứu gốc. Hơn nữa, việc phân tách các thuật toán này giúp thêm hoặc loại bỏ các thuật toán mà không ảnh hưởng đến các thuật toán khác. Tính năng mô-đun này hữu ích cho việc mở rộng toolbox.

        - Chế độ: toolbox này có ba chế độ (tức là phân tích hiệu năng, thuật toán và demo). Vì các chế độ này có các hoạt động, giao diện và thời gian chạy khác nhau, chúng tôi phân tách mã nguồn của chúng một cách độc lập.

- **Thuật toán**:
    - Mô tả: để nghiên cứu có thể tái sản xuất, chúng tôi thêm các ghi chú về đầu vào/đầu ra và mã giả định của thuật toán (trong một tài liệu riêng) ở đầu của các hàm theo đề xuất chuẩn MatLab [trợ giúp].

    - Ví dụ: các bộ thông số trong các thí nghiệm của bài báo gốc được thêm vào như "giá trị mặc định" và cũng cung cấp một ví dụ thực hành.

    - Tài liệu tham khảo: bài báo gốc và công trình liên quan được trích dẫn trong mô tả của mỗi hàm.

- **InSI_modtool**: Toolbox InSI đi kèm với InSI_modtool, một tiện ích GUI nhỏ được sử dụng để tạo thuật toán định nghĩa bởi người dùng.

- **Hỗ trợ MatLab**: chúng tôi cố gắng sử dụng các hàm tích hợp thông thường để hỗ trợ các phiên bản MatLab cũ càng nhiều càng tốt. Hầu hết các hàm được lựa chọn để hoạt động với MatLab từ phiên bản R2006. Tuy nhiên, chúng tôi đề xuất sử dụng các phiên bản MatLab cao hơn năm 2014.

# Giao diện người dùng đồ họa InSI (GUI)

## Kiến trúc ứng dụng

<p style="text-align-last: center">
<img src="./assets/img/InSI_architecture.svg">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Kiến trúc của bộ công cụ InSI.
</b>
</p>

Dựa trên các thông số trên, chúng tôi đã phân chia kiến trúc toolbox thành bốn tầng như hình 1.

- **GUI**: khi InSI được khởi tạo, người dùng có thể chọn chế độ, tức là Thuật toán, Hiệu năng hoặc Bản demo. Mỗi chế độ tương ứng với bảng điều khiển, thông số đầu vào và giao diện đầu ra. Ngoài ra, InSI\_modtool là tiện ích nhỏ của chúng tôi trong GUI để tạo thuật toán được định nghĩa bởi người dùng.

- **Dữ liệu**: tầng này là một cầu nối giữa GUI (người dùng) và thuật toán (phía sau). InSI hoạt động bằng cách thu thập các biến đầu vào từ GUI và tổng hợp chúng vào một cấu trúc dữ liệu đã xác định trước, sau đó truyền vào thuật toán phía sau để xử lý. Sau khi thực thi, đầu ra của các hàm thuật toán là các giá trị của trục "x" và "y", được lưu trữ trong tầng dữ liệu. Tiếp theo, GUI xử lý "Tùy chọn hình ảnh" được chỉ định bởi người dùng, lấy dữ liệu từ tầng dữ liệu và cuối cùng trình bày các hình ảnh kết quả cho người dùng.

- **Thuật toán**: Hình 2 trình bày một cây từ điển của InSI. Tất cả các thuật toán của ba chế độ được lưu trữ trong thư mục "Algorithms". Chúng được chia thành các nhóm và chế độ; mỗi thuật toán đều được đính kèm với một tệp thông số. Ví dụ, trong Hình 2, chức năng của phương pháp tiếp cận mù của thuật toán không gian con nhanh được đặt tên là "B_SS_Fast" được lưu trữ trong thư mục nhóm mù và chế độ Algo. Điều này có nghĩa là hàm này là một phương pháp ước lượng kênh mù, và phiên bản của nó là "Fast", được tách riêng khỏi các phiên bản thuật toán không gian con khác.

<p style="text-align-last: center">
<img src="./assets/img/InSI_dict.png" width=35%>
</p>
<p style="text-align-last: center">
<b>
Hình 2. Cấu trúc cây thư mục của InSI.
</b>
</p>

## Giao diện bảng điều khiển

<p style="text-align-last: center">
<img src="./assets/img/InSI_dashboard_interface.svg" width=70%>
</p>
<p style="text-align-last: center">
<b>
Hình 3. Bảng điều khiển InSI.
</b>
</p>

Tương ứng với các chế độ, toolbox sẽ hiển thị cho người dùng một bảng điều khiển như hình 3. Bảng điều khiển này được chia thành năm khu vực như sau:

1. **Thanh trình đơn**: thanh trình đơn này cung cấp một số chức năng hữu ích, bao gồm tùy chọn hình ảnh, lựa chọn phông chữ, điều chỉnh kích thước phông chữ và trợ giúp về toolbox. Ví dụ, trong các tùy chọn hình ảnh, người dùng có linh hoạt chọn giữa ba tùy chọn, tức là có thể giữ lại tất cả kết quả trong một hình ảnh duy nhất bằng cách sử dụng tính năng "kết hợp", hoặc có thể vẽ mỗi kết quả trong hình ảnh riêng biệt của nó bằng cách sử dụng tính năng "đơn" hoặc "riêng biệt". Những tính năng này có cùng chức năng như hai lệnh tích hợp sẵn của MatLab, tức là *hold on* và *subplot*.

2. **Mô hình của thuật toán**: bảng điều khiển này trình bày một hình ảnh cập nhật theo thời gian thực của mô hình hệ thống, phản ánh động đến thuật toán đang được sử dụng. Hơn nữa, mô hình hệ thống cho phép tương tác tương tác với các thông số đầu vào được chọn.

3. **Không gian làm việc InSI**: các kết quả không chỉ được hiển thị trên hình ảnh mà còn được lưu trong một không gian làm việc riêng biệt. Ngoài ra, người dùng cũng có thể ẩn/hiện các đường trên hình ảnh từ không gian làm việc này.

4. **Chọn mô hình**: các thuật toán/chức năng có sẵn được chia thành năm nhóm, tức là Non-blind (NB), Blind (B), Simi-blind (SB), Side-information (Side-In), và Informed (Inf).

5. **Nút Chuyển chế độ**: người dùng có thể chuyển giữa các chế độ Hiệu năng/Thuật toán/Bản demo bằng nút này nếu họ bỏ qua trong bước đầu tiên.


## Giao diện thông số đầu vào

<p style="text-align-last: center">
<img src="./assets/img/InSI_input_interface.svg" width=70%>
</p>
<p style="text-align-last: center">
<b>
Hình 4. Giao diện thông số đầu vào của InSI.
</b>
</p>

Sau khi chọn NB / B / SB / Side-In / Inf trong giao diện Bảng điều khiển, giao diện đồ họa người dùng (GUI) của các thông số đầu vào tương ứng sẽ xuất hiện như được minh họa trong Hình 4. GUI này được chia thành năm khu vực như sau:

1. **Thuật toán**: ô trên cùng hiển thị tên của thuật toán, trong khi ô phía dưới chỉ ra phiên bản tương ứng với thuật toán đã chọn. Ví dụ, đó có thể là phiên bản Gradient (Grad) của thuật toán CMA.

2. **Tham số**: dựa trên thuật toán và phiên bản, các tham số được xác định trước được hiển thị trong khu vực "Params". Các tham số này có thể xuất hiện dưới dạng danh sách thả xuống để người dùng chọn hoặc ô để người dùng nhập từ bàn phím. Khi người dùng chọn / sửa đổi các ô giá trị, GUI bảng điều khiển tương tác để minh họa thông số đó trên mô hình thuật toán. Số lượng tối đa của các tham số đầu vào là 10.

3. **Loại đầu ra**: người dùng có thể chọn loại đầu ra của thuật toán, ví dụ như tỷ lệ lỗi bit (BER), tỷ lệ lỗi ký hiệu (SER), độ lỗi bình phương trung bình tín hiệu (MSE Sig) và độ lỗi bình phương trung bình kênh (MSE Ch).

4. **Nút Thực thi**: chức năng của nút thực thi là thu thập tất cả các thông số trong khu vực Tham số đầu vào và truyền chúng đến thuật toán phía sau để xử lý tiếp.

5. **Nút Trợ giúp**: nút này mở tài liệu của thuật toán được chọn. Hộp thoại trợ giúp không chỉ hiển thị nội dung tương tự như lệnh trợ giúp mà còn cung cấp cho người dùng tùy chọn truy cập trực tiếp vào bài báo gốc của thuật toán.

## Giao diện đầu ra

<p float="left" style="text-align-last: center">
  <img src="./assets/img/InSI_output.png" width=40%/>
  <img src="./assets/img/InSI_output_subplot.png" style="margin-left:10%" width=44%/>
</p>
<p style="text-align-last: center">
<b>
Hình 5. Giao diện đầu ra InSI.
</b>
</p>

Sau khi nhận kết quả từ các thuật toán phía sau, hộp công cụ trình bày/trình bày chúng vào một hình ảnh tiêu chuẩn MatLab như được thể hiện trong Hình 5. Tương tự như đồ thị tiêu chuẩn trong MatLab, giao diện này dễ dàng chỉnh sửa. Trong Hình 5, tất cả kết quả được giữ trong một hình ảnh cho phép so sánh hiệu suất giữa các thuật toán. Ngược lại, chế độ hình ảnh riêng biệt chia các kết quả thành các hình ảnh khác nhau.

## Giao diện InSI_modtool

<p style="text-align-last: center">
<img src="./assets/img/InSI_modtool_interface.svg" width=70%>
</p>
<p style="text-align-last: center">
<b>
Hình 6. InSI_modtool.
</b>
</p>

InSI\_modtool là một tiện ích mà chúng tôi đã phát triển để cho phép người dùng tạo các thuật toán tùy chỉnh của riêng họ. Tiện ích này được chia thành hai bước riêng biệt, minh họa trong Hình 6. Trong bước đầu tiên, như được miêu tả trong hình ở phía trái, người dùng chọn chế độ, mô hình, loại đầu ra và xác định tên thuật toán. Tiếp theo, trong bước thứ hai, như được thể hiện trong hình ở phía bên phải, người dùng có thể tuần tự xác định các tham số cần thiết. Đầu ra của tiện ích này là một thư mục chứa mẫu mã thuật toán, mô hình hệ thống và tệp tham số.

[trợ giúp]: https://www.mathworks.com/help/matlab/matlab_prog/add-help-for-your-program.html