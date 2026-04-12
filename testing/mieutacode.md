**Môi trường:** Kaggle Notebook (Ngôn ngữ R).

**Lưu ý:**
gpu_clean đọc từ file "gpu_clean.csv" đã được làm sạch dữ liệu. 

Giải quyết 2 bài toán (Kiểm định 1 mẫu và Kiểm định 2 mẫu). Mỗi bài toán được chia thành 4 bước

Ở Bước thứ nhất sử dụng kết hợp 2 cách để kiểm tra phân phối chuẩn:
```R
qqnorm(nvidia_coreSpeed)
qqline(nvidia_coreSpeed)
```
Nếu các điểm dữ liệu bám sát dọc theo đường thẳng chéo, dữ liệu có phân phối chuẩn. Nếu các điểm bị cong, uốn lượn hoặc lệch xa đường thẳng (đặc biệt ở hai đầu mút), dữ liệu vi phạm giả định phân phối chuẩn.

```R
shapiro.test(nvidia_coreSpeed)
```
Giả thuyết $H_0$: Dữ liệu tuân theo phân phối chuẩn.

Nếu p-value > 0.05: Chưa đủ cơ sở bác bỏ $H_0$ $\rightarrow$ Dữ liệu đạt chuẩn.
Nếu p-value < 0.05: Bác bỏ $H_0$ $\rightarrow$ Dữ liệu không chuẩn

hàm  $qnorm(x) \equiv \Phi^{-1}(x)$.

Các bước khác thì tương tự như trong slide.