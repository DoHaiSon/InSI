# Phát triển bộ công cụ InSI

Chào mừng bạn đến trang phát triển của bộ công cụ (toolbox) InSI cho MatLab! Trang này cung cấp thông tin để người dùng cập nhật và đóng góp cho toolbox, cũng như thông tin dành cho các nhà phát triển muốn đóng góp vào dự án.

## Cách đóng góp

Chúng tôi rất hoan nghênh đóng góp từ cộng đồng để cải thiện tính năng, thêm tính năng mới, sửa lỗi và cải thiện tính khả dụng chung của InSI toolbox. Dưới đây là các bước để đóng góp vào mã nguồn mở của InSI:

1. **Báo cáo lỗi**: Nếu bạn gặp bất kỳ lỗi, vấn đề hoặc hành vi không mong muốn nào khi sử dụng toolbox, vui lòng báo cáo chúng trên [hệ thống theo dõi vấn đề](https://github.com/DoHaiSon/InSI/issues). Hãy giúp chúng tôi bằng cách cung cấp thông tin chi tiết và các bước để tái tạo lại vấn đề bạn đang gặp phải.

2. **Yêu cầu tính năng**: Nếu bạn có ý tưởng cho các tính năng mới, cải thiện hoặc bổ sung cho toolbox, hãy đề xuất chúng như [yêu cầu tính năng](https://github.com/DoHaiSon/InSI/issues). Chúng tôi trân trọng phản hồi của bạn và sẽ xem xét mọi đề xuất.

3. **Đóng góp mã**: Nếu bạn là nhà phát triển và muốn đóng góp mã vào InSI toolbox, bạn có thể gửi yêu cầu cập nhật (pull requests). Hãy đảm bảo mã của bạn tuân theo tiêu chuẩn của chúng tôi và bao gồm các bài kiểm tra thích hợp để duy trì chất lượng mã.

4. **Tài liệu**: Cải thiện tài liệu là rất quan trọng cho tính khả dụng của toolbox. Bạn có thể đóng góp bằng cách sửa lỗi chính tả, thêm ví dụ, cải thiện giải thích hoặc tạo các phần tài liệu mới.

5. **Kiểm tra và xác thực**: Hỗ trợ chúng tôi đảm bảo tính ổn định và đáng tin cậy của toolbox bằng cách kiểm tra các tính năng hiện có, xác minh các sửa lỗi và xác thực tính năng mới.

## Bắt đầu với việc phát triển

Để bắt đầu đóng góp vào bộ công cụ InSI, làm theo các bước sau:

1. **Fork Repository**: Fork (tách) InSI toolbox repository về tài khoản GitHub của bạn bằng cách nhấp vào nút "Fork" ở góc phải trên của [trang repository](https://github.com/DoHaiSon/InSI).

2. **Clone Repository**: Sao chép repository đã fork về máy tính cá nhân của bạn sử dụng Git:

```terminal
$|git clone https://github.com/DoHaiSon/InSI
```

3. **Tạo nhánh mới**: Tạo một nhánh mới cho các đóng góp của bạn. Điều này giúp giữ các thay đổi của bạn cách ly khỏi nhánh phát triển chính:

```terminal
InSI>|success| git checkout -b my-feature-branch
```

4. **Thực hiện thay đổi**: Thực hiện các thay đổi, sửa lỗi hoặc thêm tính năng mới.

5. **Chạy các bài kiểm tra**: Trước khi gửi các thay đổi, hãy chạy bộ kiểm tra hiện có để đảm bảo mọi thứ hoạt động đúng.

6. **Commit và Push**: Commit các thay đổi của bạn và đẩy chúng lên repository đã fork:

```terminal
InSI>|success| git add .
InSI>|success| git commit -m "Thêm tính năng mới của tôi"
InSI>|success| git push origin my-feature-branch
```

7. **Gửi yêu cầu cập nhật**: Cuối cùng, gửi yêu cầu kéo từ nhánh của bạn đến repository chính của InSI toolbox. Chúng tôi sẽ xem xét các thay đổi của bạn và đưa ra phản hồi.

## Cộng đồng và liên hệ

Tham gia cộng đồng InSI để cập nhật thông tin, thảo luận ý tưởng và tương tác với các đóng góp viên khác.

Cảm ơn vì sự quan tâm của bạn trong việc đóng góp vào InSI toolbox! Đóng góp của bạn đóng vai trò quan trọng trong việc cải thiện việc nhận dạng hệ thống truyền thông không dây cho các nhà nghiên cứu và kỹ sư trên toàn thế giới. Hãy cùng nhau xây dựng một bộ công cụ tuyệt vời!
