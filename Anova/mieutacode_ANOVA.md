# MIÊU TẢ CHI TIẾT QUY TRÌNH XỬ LÝ CODE (ANOVA)

**Môi trường thực hiện:** Kaggle Notebook (Ngôn ngữ R).
**Dữ liệu đầu vào:** `gpu_ready_for_models.csv` (Dữ liệu đã qua bước làm sạch).

Quy trình xử lý mã nguồn được chia thành 5 giai đoạn chính nhằm đảm bảo tính khách quan và chính xác của các kết luận thống kê.

## 1. Thiết lập hệ thống và Tiền xử lý
* **Cấu hình hiển thị:** Sử dụng `options(scipen = 999)` để ép hệ thống hiển thị số thập phân đầy đủ thay vì số mũ (e+), giúp các bảng số liệu hàng triệu đơn vị trở nên thưa và dễ đọc hơn.
* **Lọc dữ liệu:** Tiến hành lọc bỏ các nhóm chuẩn bộ nhớ có số lượng mẫu dưới 50. Việc này giúp loại bỏ nhiễu và đảm bảo mỗi nhóm trong phân tích ANOVA đều có đủ tính đại diện.
* **Định dạng dữ liệu:** Chuyển đổi biến `Memory_Type` sang dạng `Factor` để R nhận diện chính xác đây là các nhóm phân loại trong bài toán so sánh trung bình.

## 2. Trực quan hóa dữ liệu (Exploratory Data Analysis)
* **Sử dụng biểu đồ Boxplot:** Giúp quan sát sơ bộ sự phân tán và giá trị trung vị của công suất (`Max_Power`) theo từng loại bộ nhớ. 
* **Mục tiêu:** Phát hiện sớm các giá trị ngoại lệ (outliers) và nhận định cảm quan về sự chênh lệch giữa các nhóm (ví dụ: GDDR5 thường nằm ở mức cao hơn hẳn).

## 3. Kiểm tra các giả định tiên quyết
Đây là bước quan trọng để xác định độ tin cậy của mô hình:
* **Kiểm định Levene:** Sử dụng hàm `leveneTest()` từ gói `car` để kiểm tra tính đồng nhất phương sai giữa các nhóm.
* **Đồ thị Q-Q Plot:** Được vẽ thông qua lệnh `plot(model, which = 2)`. Nếu các điểm dữ liệu bám sát đường chéo, giả định phần dư tuân theo phân phối chuẩn được thỏa mãn.

## 4. Thực thi mô hình ANOVA và Welch's ANOVA
* **Mô hình chính:** Sử dụng hàm `aov()` để tính toán bảng ANOVA. Kết quả tập trung vào giá trị **F-statistic** (độ lệch giữa các nhóm) và **p-value** (mức độ ý nghĩa).
* **Mô hình đối chứng (Welch's ANOVA):** Vì dữ liệu thực tế thường vi phạm giả định đồng nhất phương sai, nhóm đã bổ sung hàm `oneway.test(..., var.equal = FALSE)`. Đây là bước kiểm tra chéo nhằm đảm bảo kết luận cuối cùng vẫn đúng ngay cả khi phương sai không đều.

## 5. Phân tích hậu định (Post-hoc Analysis)
* **Hàm thực hiện:** `TukeyHSD(model)`.
* **Mục tiêu:** Sau khi ANOVA xác nhận "có sự khác biệt", Tukey HSD sẽ chỉ ra cụ thể "cặp nào khác biệt".
* **Kết quả:** Code xuất ra bảng so sánh chi tiết từng cặp (ví dụ: GDDR5 so với DDR3) kèm theo khoảng tin cậy 95% và p-value điều chỉnh (p-adj).
