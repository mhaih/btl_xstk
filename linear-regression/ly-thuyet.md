## 1. Mô hình hồi quy tuyến tính
Mô hình hồi quy tuyến tính giả sử có các tham số $\beta_0$, $\beta_1$, ..., $\beta_{p - 1}$ và $\sigma^2$ sao cho tại quan sát thứ i $(X_1, X_2, ..., X_{p - 1}) = (x_{1i}, x_{1i}, ..., x_{(p - 1)i})$, ta có mối quan hệ:
$$Y_i = \beta_0 + \beta_1 x_{1i} + \beta_2 x_{2i} + ... + \beta_{p - 1} x_{(p-1)i} + \varepsilon_i$$
Trong đó:
* i = 1, 2, ..., n: Có n quan sát trong mẫu.
* p: Có tổng cộng p tham số hồi quy và p - 1 biến dự báo.

    Khi p = 2, ta có mô hình hồi quy tuyến tính đơn giản, khi p > 2, ta có mô hình hồi quy tuyến tính bội.
* **$\beta_i$:** Các hệ số hồi quy, đo lường sự thay đổi của $Y$ khi $X_i$ thay đổi 1 đơn vị và các biến khác không đổi.
* **$\varepsilon_i$ ~ $N(0, \sigma^2)$:** Đại diện cho những yếu tố không chắc chắn.

Ta có dạng ma trận của mô hình:
$$Y = X\beta + \varepsilon$$
Với:
$$Y = \begin{bmatrix} Y_1 \\ Y_2 \\ \vdots \\ Y_n \end{bmatrix}, \quad X = \begin{bmatrix} 1 & x_{11} & x_{21} & \dots & x_{(p - 1)1} \\ 1 & x_{12} & x_{22} & \dots & x_{(p - 1)2} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & x_{1n} & x_{2n} & \dots & x_{(p - 1)n} \end{bmatrix}, \quad \beta = \begin{bmatrix} \beta_0 \\ \beta_1 \\ \vdots \\ \beta_{p - 1} \end{bmatrix}, \quad \varepsilon = \begin{bmatrix} \varepsilon_1 \\ \varepsilon_2 \\ \vdots \\ \varepsilon_n \end{bmatrix}$$

## 2. Các giả định cơ bản:

* **Tính tuyến tính:** Mối quan hệ giữa $X$ và $Y$ phải là tuyến tính.
* **Tính độc lập:** Các sai số $\varepsilon_i$ độc lập với nhau.
* **Phương sai đồng nhất:** phương sai $\sigma^2$ của các sai số $\varepsilon_i$ là bằng nhau.
* **Phân phối chuẩn của sai số:** Sai số $\varepsilon_i$ cần tuân theo phân phối chuẩn $N(0, \sigma^2)$.
* Không có sai số khi đo lường giá trị của các biến dự báo.

## 3. Ước lượng tham số
Các tham số $\beta_0$, $\beta_1$, ..., $\beta_{p - 1}$ và $\sigma^2$ được ước lượng từ mẫu dựa trên phương pháp bình phương tối thiểu, nghĩa là tính toán các tham số để tối thiểu hoá biểu thức:
$$\sum (y_i - (\beta_0 + \beta_1 x_{1i} + \beta_2 x_{2i} + ... + \beta_{p - 1} x_{(p - 1)i}))^2$$

Với $y_i$ là giá trị thực tế của biến phụ thuộc tại quan sát thứ i.

Khi Y = y, phương pháp bình phương tối thiểu cho ta ước lượng của các tham số:
$$\hat{\beta} = (X^T X)^{-1} X^T y$$
$$\hat{\sigma}^2 = \frac{SSE}{n - p}$$

## 4. Phân rã phương sai
Nếu ta ký hiệu hiệu $y_i$ và $\hat{y_i}$ lần lượt là là giá trị thực tế và giá trị dự đoán của biến phụ thuộc tại quan sát thứ i, $\bar{y}$ là giá trị trung bình của mọi $y_i$, ta có:

* **SST (Total Sum of Squares):** Tổng bình phương sai lệch toàn bộ, đo lường sự biến thiên của các giá trị thực tế $y_i$ xung quanh giá trị trung bình $\bar{y}$.
    $$SST = \sum_{i=1}^{n} (y_i - \bar{y})^2$$
* **SSR (Regression Sum of Squares):** Tổng bình phương hồi quy, đo lường phần biến thiên được giải thích bởi mô hình (sự sai lệch của giá trị dự báo $\hat{y}_i$ so với trung bình $\bar{y}$).
    $$SSR = \sum_{i=1}^{n} (\hat{y}_i - \bar{y})^2$$
* **SSE (Error Sum of Squares):** Tổng bình phương sai số, đo lường phần biến thiên không được giải thích bởi mô hình (sai lệch giữa thực tế và dự báo).
    $$SSE = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2$$

**Mối quan hệ tổng quát:**
$$SST = SSR + SSE$$

## 5. Hệ số tương quan, hệ số xác định, hệ số lạm phát phương sai và hiện tượng đa cộng tuyến
#### **5.1. Hệ số tương quan** (Pearson)
$r_{XY}$ đặc trưng cho độ ràng buộc tuyến tính giữa X và Y.
$$r_{XY} = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\sum (x_i - \bar{x})^2 \sum (y_i - \bar{y})^2}}$$
* Khoảng giá trị: $−1 ≤ r_{XY} ≤ 1$
* Khi $|r_{XY}|$ càng gần 1, mối quan hệ tuyến tính giữa X và Y càng mạnh

#### **5.2. Hệ số xác định** 
$R^2$ đo lường tỷ lệ biến thiên của biến phụ thuộc ($Y$) được giải thích bởi các biến độc lập ($X$) trong mô hình.
$$R^2 = \frac{SSR}{SST} = 1 - \frac{SSE}{SST}$$
* **Khoảng giá trị:** $0 \le R^2 \le 1$.
* **$R^2$ càng gần 1** thì mô hình giải thích được càng nhiều biến thiên của dữ liệu, độ phù hợp càng cao.

#### 5.3. **Hiện tượng đa cộng tuyến** 
Hiện tượng đa cộng tuyến xảy ra khi các biến độc lập có tương quan mạnh với nhau. Hiện tượng này làm tăng sai số chuẩn của các hệ số $\beta$, khiến chi mô hình thiếu ổn định.

**Hệ số lạm phát phương sai** (VIF) đo lường mức độ đa cộng tuyến giữa một biến độc lập với các biến độc lập còn lại trong mô hình hồi quy.
$$VIF_j = \frac{1}{1 - R_j^2}$$
**Trong đó:** $R_j^2$ là hệ số xác định khi hồi quy biến độc lập $x_j$ theo tất cả các biến độc lập còn lại trong mô hình. Ngưỡng đánh giá như sau:
* **$VIF = 1$:** Không có hiện tượng đa cộng tuyến.
* **$1 < VIF < 5$:** Đa cộng tuyến mức độ nhẹ, thường có thể chấp nhận được.
* **$VIF > 5$:** Đa cộng tuyến nghiêm trọng, có thể làm sai lệch các ước lượng và cần xem xét loại bỏ biến hoặc xử lý dữ liệu.

## 6. Một số kiểm định trên mô hình
#### **6.1. Kiểm định hệ số hồi quy riêng lẻ (t-Test)**
Dùng để đánh giá ý nghĩa thống kê của từng biến độc lập $X_j$ trong mô hình.
* **$H_0: \beta_j = 0$**: Biến $X_j$ không có tác động đến $Y$.
* **$H_1: \beta_j \neq 0$**: Biến $X_j$ có tác động đến $Y$.
$$t = \frac{\hat{\beta}_j}{se(\hat{\beta}_j)}$$
**Trong đó:**
* $\hat{\beta}_j$: Hệ số hồi quy ước lượng của biến $X_j$.
* $se(\hat{\beta}_j)$: Sai số chuẩn của hệ số hồi quy đó.

Bác bỏ $H_0$ nếu: **$|t| > t_{\alpha/2, n-p}$** hoặc **$p\text{-value} < \alpha$**.

**Kết luận:** Nếu bác bỏ $H_0$, biến $X_j$ có ý nghĩa thống kê trong việc giải thích biến phụ thuộc $Y$.

#### **6.2. Kiểm định sự phù hợp tổng thể (Overall F-Test)**
Dùng để xác định xem ít nhất một biến độc lập trong mô hình có tác động đáng kể đến biến phụ thuộc hay không.
* **$H_0: \beta_1 = \beta_2 = \dots = \beta_p = 0$** (Mô hình không có ý nghĩa).
* **$H_1:$** Có ít nhất một hệ số $\beta_j \neq 0$ ($j = 1, \dots, p - 1$).

Bảng phân tích phương sai (ANOVA), với $n$ quan sát và $p-1$ biến độc lập (tổng cộng $p$ tham số tính cả intercept):
| Nguồn biến thiên | Tổng bình phương ($SS$) | Bậc tự do ($df$) | Trung bình bình phương ($MS$) | Giá trị $F$ |
| :--- | :--- | :--- | :--- | :--- |
| **Hồi quy (Regression)** | $SSR$ | $p - 1$ | $MSR = \frac{SSR}{p - 1}$ | $F = \frac{MSR}{MSE}$ |
| **Sai số (Error)** | $SSE$ | $n - p$ | $MSE = \frac{SSE}{n - p}$ | |
| **Tổng cộng (Total)** | $SST$ | $n - 1$ | | |

Bác bỏ $H_0$ nếu: **$F > F_{\alpha, (p-1, n-p)}$** hoặc **$p\text{-value} < \alpha$**.

**Kết luận:** Nếu bác bỏ $H_0$, mô hình hồi quy phù hợp với tập dữ liệu về mặt tổng thể.

#### 6.3. Kiểm định Breusch-Pagan
Dùng để kiểm tra giả định **phương sai sai số đồng nhất**.
* $H_0$: Phương sai sai số không đổi (đồng nhất).
* $H_1$: Phương sai sai số thay đổi (có hiện tượng phương sai thay đổi).
Bác bỏ $H_0$ nếu $p\text{-value} < \alpha$.

**Kết luận:** Nếu bác bỏ $H_0$, các ước lượng hệ số vẫn không chệch nhưng không còn hiệu quả nhất, làm sai lệch các khoảng tin cậy và kiểm định $t, F$.


#### 6.4. Kiểm định Shapiro-Wilk
Dùng để kiểm tra giả định **phân phối chuẩn của phần dư**.
* $H_0$: Phần dư tuân theo phân phối chuẩn.
* $H_1$: Phần dư không tuân theo phân phối chuẩn.
Bác bỏ $H_0$ nếu $p\text{-value} < \alpha$.

**Kết luận:** Giả định này quan trọng đối với các mẫu nhỏ để đảm bảo tính chính xác của các kiểm định $t$ và $F$. Với mẫu lớn, vi phạm này ít nghiêm trọng hơn nhờ Định lý giới hạn trung tâm.

