# Kiểm định giả thuyết thống kê
## Các khái niệm chung
**Định nghĩa** Việc dùng các kết quả của mẫu để xem xét có nên bác bỏ giả thuyết $H$ nào đó hay chưa được gọi là kiểm định giả thuyết $H$. Giả thuyét kiểm định $H$ còn được gọi là giả thuyết không và còn hiệu là $H_0$. Cùng với đó là giả thuyết đối lập $\overline{H}$ hay $H_1$.

Giả thuyết không đại diện cho trạng thía "Bình thường", không có sự thay đổi. 

Giả thuyết về sự thay đổi, có tác dụng hoặc có sự khác biệt. Thường là giả thuyết mà nhà nghiên cứu muốn tìm bằng chứng đề chứng minh. 

Bài toán kiểm định có thể đi đến một trong hai kết luân: bác bỏ $H_0$ và chấp nhận $H_1$, hoặc chưa bác  bỏ $H_0$ và chưa chấp nhận $H_1$.

**Sai lầm trong kiểm định**

Khi kiểm định ta có thể mắc hai loại sai lầm:
- Sai lầm loại I: bác bỏ $H_0$ khi $H_0$ đúng. Ký hiệu là $\alpha$, còn gọi là mức ý nghĩa của kiểm định. Mức ý nghĩa thường được chọn là 0.05, có nghĩa là chấp nhận sai lầm loại I với xác suất 5%.
$$
\alpha = P(\text{bác bỏ } H_0 | H_0 \text{ đúng} )
$$
- Sai lầm loại II: công nhận $H_0$ trong khi $H_0$ sai. Ký hiệu là $\beta$. Mức ý nghĩa của sai lầm loại II thường được chọn là 0.20, có nghĩa là chấp nhận sai lầm loại II với xác suất 20%. Và lực kiểm định là $1-\beta$, có nghĩa là xác suất bác bỏ $H_0$ khi $H_0$ sai.

$$
\beta = P(\text{không bác bỏ } H_0 | H_0 \text{ sai} )
$$

**Các trường hợp kiểm định:**
---

| Loại kiểm định | Giả thiết Không ($H_0$) | Giả thiết Đối ($H_1$) | Miền bác bỏ|
| :--- | :--- | :--- | :--- |
| **Hai phía (Two-tailed)** | $H: P = P_0$ | $H: P \neq P_0$ | Nằm ở cả hai đầu của phân phối. |
| **Phía Phải (Right-tailed)** | $H: P \leq P_0$ | $H: P > P_0$ | Nằm ở đầu bên phải (giá trị lớn). |
| **Phía Trái (Left-tailed)** | $H: P \geq P_0$ | $H: P < P_0$ | Nằm ở đầu bên trái (giá trị nhỏ). |
---

**Quy trình kiểm định**:
1. Xét mẫu $W = (X_1, X_2,...,X_n)$ chọn thống kê $G = G(X_1, X_2,..., X_n)$. Điều kiện dặt ra là $G$ phải có phân phối xác định khi $H_0$ đúng. Thống kê $G$ được gọi là tiêu chuẩn kiểm định. Thực hiện phép thử $G$ sẽ nhận được giá trị quan sát được $g$.
2. Xác định miền bác bỏ $RR$ của $G$, cho trước mức ý nghĩa $\alpha$. Miền bác bỏ $RR$ là miền $W_{\alpha}$ thỏa:
$$P(G \in W_{\alpha} | H_0) = \alpha$$
- Có vô số miền $W_{\alpha}$ như vậy. Trong đó, ta sẽ chọn miền bác bỏ sao cho xác xuất mắc sai lầm loại II là nhỏ nhất. Phần bù của miền bác bỏ là miền chấp nhận và ký hiệu là $AR$.

3. Nếu giá trị quan sát được của $G$ rơi vào miền bác bỏ $RR$, thì bác bỏ $H_0$ và chấp nhận $H_1$. Ngược lại, nếu giá trị quan sát được của $G$ rơi vào miền chấp nhận $AR$, thì chưa bác bỏ $H_0$ và chưa chấp nhận $H_1$.

**P-value**

 là xác xuất để ta nhận được dữ liệu quan sát được hoặc dữ liệu cực đoan hơn với giả định rằng giả thuyết $H_0$ đúng. Nếu P-value nhỏ hơn mức ý nghĩa $\alpha$, thì bác bỏ $H_0$.
 $$P_{value} < \alpha \Leftrightarrow g \in W_{\alpha}$$
  Ngược lại, nếu P-value lớn hơn hoặc bằng mức ý nghĩa $\alpha$, thì chưa bác bỏ $H_0$.
$$
P_{value} \geq \alpha \Leftrightarrow g \notin W_{\alpha} 
$$

## Bài toán kiểm định một mẫu.

### Bài toán kiểm định tỉ lệ một mẫu.

Cho tổng thể $X$, trong đó có tỷ lệ phần tử mang dấu hiệu $A$ nào đó trong tổng thể là $p$ ($p$ chưa biết). Dùng thống kê từ mẫu, thực hiện kiểm định $p$ với $p_0$ ($p_0$ là giá trị cho trước), xét với mức ý nghĩa $\alpha$.

**Giả định:** Cỡ mẫu $n$ lớn ($n \geq 30$), để phân phối chuẩn xấp xỉ phân phối nhị thức $n(1 - p_0) \ge 5$, $n p_0 \ge 5$. $f = \frac{m}{n}$ là tỷ lệ quan sát được từ mẫu ($m$ là số phần tử có dấu hiệu $A$).

---

| Điều kiện | $H_0$ | $H_1$ | Tiêu chuẩn kiểm định | Miền bác bỏ $RR$ |
| :--- | :---: | :---: | :---: | :--- |
| **Kiểm định hai phía** | $p = p_0$ | $p \neq p_0$ | $U_{qs} = \frac{f - p_0}{\sqrt{\frac{p_0(1 - p_0)}{n}}}$ | $(-\infty, -z_{\alpha/2}) \cup (z_{\alpha/2}, +\infty)$ |
| **Kiểm định phía trái** | $p = p_0$ (hoặc $p \ge p_0$) | $p < p_0$ | $U_{qs} = \frac{f - p_0}{\sqrt{\frac{p_0(1 - p_0)}{n}}}$ | $(-\infty, -z_{\alpha})$ |
| **Kiểm định phía phải** | $p = p_0$ (hoặc $p \le p_0$) | $p > p_0$ | $U_{qs} = \frac{f - p_0}{\sqrt{\frac{p_0(1 - p_0)}{n}}}$ | $(z_{\alpha}, +\infty)$ |

---


### Bài toán kiểm định trung bình một mẫu.

Cho tổng thể $X$ có kỳ vọng là $a$ ($a$ chưa biết). Dùng thống kê từ mẫu, thực hiện kiểm định $a$ với $a_0$ ($a_0$ là giá trị cho trước), xét với mức ý nghĩa $\alpha$.

---

| Phân bố của tổng thể | $H_0$ | $H_1$ | Tiêu chuẩn kiểm định | Miền bác bỏ $RR$ |
| :--- | :---: | :---: | :--- | :--- |
| $X$ có phân phối chuẩn, đã biết $\sigma^2$ | $a = a_0$ | $\begin{matrix} a \neq a_0 \\ a < a_0 \\ a > a_0 \end{matrix}$ | $U_{qs} = \frac{\bar{x} - a_0}{\sigma}\sqrt{n}$ | $\begin{matrix} (-\infty; -z_{\alpha/2}) \cup (z_{\alpha/2}; +\infty) \\ (-\infty; -z_{\alpha}) \\ (z_{\alpha}; +\infty) \end{matrix}$ |
| $X$ có phân phối chuẩn, chưa biết $\sigma^2$ | $a = a_0$ | $\begin{matrix} a \neq a_0 \\ a < a_0 \\ a > a_0 \end{matrix}$ | $T_{qs} = \frac{\bar{x} - a_0}{s}\sqrt{n}$ | $\begin{matrix} (-\infty; -t_{\alpha/2;(n-1)}) \cup (t_{\alpha/2;(n-1)}; +\infty) \\ (-\infty; -t_{\alpha;(n-1)}) \\ (t_{\alpha;(n-1)}; +\infty) \end{matrix}$ |
| $X$ có phân phối tùy ý, $n \ge 30$, đã biết hoặc chưa biết $\sigma^2$ | $a = a_0$ | $\begin{matrix} a \neq a_0 \\ a < a_0 \\ a > a_0 \end{matrix}$ | $\bullet$ Nếu biết $\sigma$: $U_{qs} = \frac{\bar{x} - a_0}{\sigma}\sqrt{n}$<br><br>$\bullet$ Nếu chưa biết $\sigma$: $U_{qs} = \frac{\bar{x} - a_0}{s}\sqrt{n}$ | $\begin{matrix} (-\infty; -z_{\alpha/2}) \cup (z_{\alpha/2}; +\infty) \\ (-\infty; -z_{\alpha}) \\ (z_{\alpha}; +\infty) \end{matrix}$ |

---

## Bài toán kiểm định hai mẫu.
### Bài toán kiểm định tỉ lệ hai mẫu.
Cho hai tổng thể $X$ và $Y$, trong đó có tỷ lệ phần tử mang dấu hiệu $A$ nào đó trong tổng thể là $p_1$ và $p_2$ ($p_1$ và $p_2$ chưa biết). Dùng thống kê từ mẫu, thực hiện kiểm dịnh để so sánh $p_1$ và $p_2$, xét với mức ý nghĩa $\alpha$.

**Giả định:**
* Hai mẫu độc lập.
* Cỡ mẫu $n_1$ và $n_2$ lớn: $n_i f_i \ge 5$ và $n_i(1 - f_i) \ge 5$ với $i \in \{1, 2\}$.

---

| Điều kiện | $H_0$ | $H_1$ | Tiêu chuẩn kiểm định | Miền bác bỏ $RR$ |
| :--- | :---: | :---: | :---: | :--- |
| **Kiểm định hai phía** | $p_1 = p_2$ | $p_1 \neq p_2$ | $U_{qs} = \frac{f_1 - f_2}{\sqrt{\bar{f}(1 - \bar{f})}} \sqrt{\bar{n}}$ | $(-\infty; -z_{\alpha/2}) \cup (z_{\alpha/2}; +\infty)$ |
| **Kiểm định phía trái** | $p_1 = p_2$ | $p_1 < p_2$ | $U_{qs} = \frac{f_1 - f_2}{\sqrt{\bar{f}(1 - \bar{f})}} \sqrt{\bar{n}}$ | $(-\infty; -z_{\alpha})$ |
| **Kiểm định phía phải** | $p_1 = p_2$ | $p_1 > p_2$ | $U_{qs} = \frac{f_1 - f_2}{\sqrt{\bar{f}(1 - \bar{f})}} \sqrt{\bar{n}}$ | $(z_{\alpha}; +\infty)$ |

---

**Trong đó:**
* $f_1 = \frac{m_1}{n_1}$ và $f_2 = \frac{m_2}{n_2}$ lần lượt là tỷ lệ quan sát của hai mẫu.
* $\bar{f} = \frac{m_1 + m_2}{n_1 + n_2}$ là tỷ lệ chung của hai mẫu.
* $\bar{n} = \frac{n_1 \cdot n_2}{n_1 + n_2}$ là cỡ mẫu rút gọn.
* $z_{\alpha}$ tra bảng phân phối Laplace
### Bài toán kiểm định trung bình hai mẫu.
Cho hai tổng thể $X$ và $Y$ có kỳ vọng lần lượt là $a_1$ và $a_2$ ($a_1, a_2$ chưa biết). Dùng thống kê từ hai mẫu độc lập hoặc phụ thuộc để so sánh $a_1$ và $a_2$, xét với mức ý nghĩa $\alpha$.

---

| Phân bố của tổng thể | $H_0$ | $H_1$ | Tiêu chuẩn kiểm định | Miền bác bỏ ($RR$) |
| :--- | :---: | :---: | :--- | :--- |
| **Độc lập, phân phối chuẩn, đã biết $\sigma_1^2, \sigma_2^2$** | $a_1 = a_2$ | $\begin{matrix} a_1 \neq a_2 \\ a_1 < a_2 \\ a_1 > a_2 \end{matrix}$ | $U_{qs} = \frac{\bar{x} - \bar{y}}{\sqrt{\frac{\sigma_1^2}{n_1} + \frac{\sigma_2^2}{n_2}}}$ | $\begin{matrix} (-\infty; -z_{\alpha/2}) \cup (z_{\alpha/2}; +\infty) \\ (-\infty; -z_{\alpha}) \\ (z_{\alpha}; +\infty) \end{matrix}$ |
| **Độc lập, phân phối chuẩn, chưa biết $\sigma^2$ ($\sigma_1^2 = \sigma_2^2$)** | $a_1 = a_2$ | $\begin{matrix} a_1 \neq a_2 \\ a_1 < a_2 \\ a_1 > a_2 \end{matrix}$ | $T_{qs} = \frac{\bar{x} - \bar{y}}{s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}}$ | $\begin{matrix} (-\infty; -t_{\alpha/2; n_1+n_2-2}) \cup (t_{\alpha/2; n_1+n_2-2}; +\infty) \\ (-\infty; -t_{\alpha; n_1+n_2-2}) \\ (t_{\alpha; n_1+n_2-2}; +\infty) \end{matrix}$ |
| **Độc lập, phân phối chuẩn, chưa biết $\sigma^2$ ($\sigma_1^2 \neq \sigma_2^2$)** | $a_1 = a_2$ | $\begin{matrix} a_1 \neq a_2 \\ a_1 < a_2 \\ a_1 > a_2 \end{matrix}$ | $T_{qs} = \frac{\bar{x} - \bar{y}}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}$ | $\begin{matrix} (-\infty; -t_{\alpha/2; \nu}) \cup (t_{\alpha/2; \nu}; +\infty) \\ (-\infty; -t_{\alpha; \nu}) \\ (t_{\alpha; \nu}; +\infty) \end{matrix}$ |
| **Độc lập, phân phối tùy ý, $n_1, n_2 \ge 30$** | $a_1 = a_2$ | $\begin{matrix} a_1 \neq a_2 \\ a_1 < a_2 \\ a_1 > a_2 \end{matrix}$ | $\bullet$ Nếu biết $\sigma$: $U_{qs} = \frac{\bar{x} - \bar{y}}{\sqrt{\frac{\sigma_1^2}{n_1} + \frac{\sigma_2^2}{n_2}}}$<br><br>$\bullet$ Nếu chưa biết $\sigma$: $U_{qs} = \frac{\bar{x} - \bar{y}}{\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}$ | $\begin{matrix} (-\infty; -z_{\alpha/2}) \cup (z_{\alpha/2}; +\infty) \\ (-\infty; -z_{\alpha}) \\ (z_{\alpha}; +\infty) \end{matrix}$ |
| **Phụ thuộc theo cặp, phân phối chuẩn, chưa biết $\sigma_D^2$** | $a_1 = a_2$ | $\begin{matrix} a_1 \neq a_2 \\ a_1 < a_2 \\ a_1 > a_2 \end{matrix}$ | $T_{qs} = \frac{\bar{d}}{s_D / \sqrt{n}}$ | $\begin{matrix} (-\infty; -t_{\alpha/2; n-1}) \cup (t_{\alpha/2; n-1}; +\infty) \\ (-\infty; -t_{\alpha; n-1}) \\ (t_{\alpha; n-1}; +\infty) \end{matrix}$ |
| **Phụ thuộc theo cặp, phân phối tùy ý, $n \ge 30$** | $a_1 = a_2$ | $\begin{matrix} a_1 \neq a_2 \\ a_1 < a_2 \\ a_1 > a_2 \end{matrix}$ | $\bullet$ Nếu biết $\sigma_D$: $U_{qs} = \frac{\bar{d}}{\sigma_D / \sqrt{n}}$<br><br>$\bullet$ Nếu chưa biết $\sigma_D$: $U_{qs} = \frac{\bar{d}}{s_D / \sqrt{n}}$ | $\begin{matrix} (-\infty; -z_{\alpha/2}) \cup (z_{\alpha/2}; +\infty) \\ (-\infty; -z_{\alpha}) \\ (z_{\alpha}; +\infty) \end{matrix}$ |

---
**Trong đó:**

* $\bar{x}, \bar{y}$: Trung bình mẫu thu được từ tổng thể 1 và tổng thể 2.
* $\bar{d}$: Trung bình của các hiệu số $d_i = x_i - y_i$.
* **Dấu hiệu quy ước xét phương sai (Khi chưa biết $\sigma_1^2, \sigma_2^2$):**
    * **Trường hợp $\sigma_1^2 = \sigma_2^2$:** Dấu hiệu nhận biết là **$\frac{s_1}{s_2} \in [\frac{1}{2}; 2]$**. 
      $\rightarrow$ Tính phương sai chung: $s_p^2 = \frac{(n_1 - 1)s_1^2 + (n_2 - 1)s_2^2}{n_1 + n_2 - 2}$
    * **Trường hợp $\sigma_1^2 \neq \sigma_2^2$:** Dấu hiệu nhận biết là **$\frac{s_1}{s_2} \notin [\frac{1}{2}; 2]$**. 
      $\rightarrow$ Tính bậc tự do $\nu$ làm tròn số nguyên: $\nu = \frac{\left( \frac{s_1^2}{n_1} + \frac{s_2^2}{n_2} \right)^2}{\frac{(s_1^2/n_1)^2}{n_1-1} + \frac{(s_2^2/n_2)^2}{n_2-1}}$
* $s_D$: Độ lệch chuẩn của dãy hiệu số $d_i$.
* $z_{\alpha}$ tra bảng Laplace, $t_{\alpha}$ tra bảng Student.

