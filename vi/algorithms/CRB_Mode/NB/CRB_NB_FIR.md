### Mô hình kênh đáp ứng xung hữu hạn (FIR)

Gần như tất cả các tiêu chuẩn truyền thông không dây sử dụng các chuỗi huấn luyện trong tầng vật lý (tức là tiền tố) để ước tính hiệu ứng của kênh truyền trong các tín hiệu nhận được. Thông thường, các máy truyền nhận OFDM chèn vào $K_p$ ký hiệu định vị, được biết đến cả ở trạng thái máy phát và máy thu. Do đó, máy thu có thể tận dụng những ký hiệu định vị này để ước tính kênh. Tuy nhiên, không có cách nào để đạt độ chính xác hoàn hảo trong truyền thông không dây vì chúng ta không thể tính toán một CSI hoàn hảo. Để ước tính độ chính xác tối đa có thể đạt được trong hệ thống truyền thông không dây, CRB được sử dụng cho bộ ước tính kênh không thiên vị. Cơ bản, CRB được cho bởi [Kay1993]:
$$
    \text{CRB}(\boldsymbol{\Theta}) = \mathbf{J}_{\boldsymbol{\Theta}\boldsymbol{\Theta}}^{-1}
$$
với $\mathbf{J}_{\boldsymbol{\Theta}\boldsymbol{\Theta}}$ là ma trận thông tin Fisher (FIM) và $\boldsymbol{\Theta}$ là vector tham số không biết cần ước tính. Trong mô hình kênh đáp ứng xung hữu hạn (FIR), $\boldsymbol{\Theta} \simeq	 \mathbf{h}$ [Ladaycia2017], FIM liên quan đến các ký hiệu định vị biết trước được ký hiệu bởi $\mathbf{J}_{\boldsymbol{\Theta}\boldsymbol{\Theta}}^p$. Do đó, vector tham số cần ước tính được biểu thị bởi [Menni2012]:
$$
    \boldsymbol{\Theta}=\left[\mathbf{h}^{\top},  \quad  \left(\mathbf{h}^{*}\right)^{\top}\right]
$$

Trong hệ thống massive MIMO-OFDM, $K_p$ ký hiệu định vị được sắp xếp trong các ký hiệu OFDM [Garro2020], và vì nhiễu là một quá trình ngẫu nhiên độc lập và đồng nhất, chúng ta có thể sử dụng ma trận thông tin Fisher (FIM) trong trường hợp NB (không mù) như sau:
$$
\label{eq:9}
    \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p}=\sum_{i=1}^{K_{p}} \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}}
$$
với $\mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}}$ là FIM liên quan đến ký hiệu định vị thứ $i$ [Kay1993] được cho bởi:

$$
    \label{eq:10}
    \begin{aligned}
        \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}} &=\mathbb{E}\left\{\left(\frac{\partial \ln p(\mathbf{y}(i), \mathbf{h})}{\partial \boldsymbol{\Theta}^{*}}\right)\left(\frac{\partial \ln p(\mathbf{y}(i), \mathbf{h})}{\partial \boldsymbol{\Theta}^{*}}\right)^{H}\right\} \\
    \end{aligned}
$$
trong đó $\mathbb{E}$ là toán tử kỳ vọng; $p(\mathbf{y}(i), \mathbf{h})$ là hàm mật độ xác suất (pdf) của tín hiệu nhận được cho trước $\mathbf{h}$. Những phép toán phức tạp được mô tả ở trên. Do đó, chúng có thể được biểu thị bởi:
$$
    \mathbf{J}_{\boldsymbol{\Theta} \boldsymbol{\Theta}}^{p_{i}}=\frac{\mathbf{x}(i)^{H} \mathbf{x}(i)}{\sigma_{\mathbf{v}}^{2}}
$$

Thuật toán 1 hiển thị mã giả cho mô hình kênh FIR. Sau đó, Hình 1 mô tả một ví dụ về NB\_FIR trên công cụ InSI.

[Mô hình kênh Finite Impulse Response](../../../../pseudo/CRB_NB_FIR.md ':include :type=code algorithm')

<p style="text-align-last: center">
<img src="./assets/img/Outputs/InSI_NB_FIR.png">
</p>
<p style="text-align-last: center">
<b>
Hình 1. Đánh giá hiệu năng: Mô hình kênh Finite Impulse Response.
</b>
</p>


[Kay1993]: https://dl.acm.org/doi/abs/10.5555/151045
[Ladaycia2017]: https://ieeexplore.ieee.org/abstract/document/7956173
[Garro2020]: https://ieeexplore.ieee.org/document/9040540
[Menni2012]: https://ieeexplore.ieee.org/abstract/document/6094230