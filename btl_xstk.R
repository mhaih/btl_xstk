# 1. Cài thư viện
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)
library(GGally)
library(car)
library(leaps)
library(lmtest)
gpu_raw <- read.csv("All_GPUs.csv")
cat("----------------------- TIỀN XỬ LÝ DỮ LIỆU -----------------------")
cat("\n--- DỮ LIỆU THÔ BAN ĐẦU ---\n")
head(gpu_raw)

gpu_data <- gpu_raw[, c("Manufacturer", "Core_Speed", "Max_Power", "Memory_Type",
                   "Memory", "Memory_Bandwidth", "Memory_Speed", "Memory_Bus", 
                   "Process", "ROPs", "TMUs", "Notebook_GPU") ]
cat("\n--- DỮ LIỆU THÔ BAN ĐẦU SAU KHI CHỌN 12 CỘT DỮ LIỆU QUAN TRỌNG ---\n")
head(gpu_data)

cat("\n---XỬ LÍ ĐỊNH DẠNG DỮ LIỆU---\n")
process_multiplier <- function(column) {
  column <- as.character(column)
  
  base_val <- as.numeric(str_extract(column, "\\d+"))
  
  mult_raw <- str_extract(column, "(?i)x[^0-9]*\\d+")
  
  mult <- as.numeric(str_extract(mult_raw, "\\d+"))
  
  mult[is.na(mult)] <- 1
  
  return(base_val * mult)
}

gpu_data[] <- lapply(gpu_data, function(x) gsub("^\\n- $", NA, x))

gpu_clean <- gpu_data %>%
  mutate(
    Core_Speed = as.numeric(str_remove(Core_Speed, " MHz")),
    Max_Power = as.numeric(str_remove(Max_Power, " Watts")),
    Memory = as.numeric(str_remove(Memory, " MB")),
    Memory_Speed = as.numeric(str_remove(Memory_Speed, " MHz")),
    Memory_Bus = as.numeric(str_remove(Memory_Bus, " Bit")),
    Process = as.numeric(str_remove(Process, "nm")),
    TMUs = as.numeric(str_extract(as.character(TMUs), "[\\d\\.]+")),
    Memory_Bandwidth = ifelse(str_detect(Memory_Bandwidth, "MB/sec"),
                              as.numeric(str_extract(Memory_Bandwidth, "[\\d\\.]+")) / 1000,
                              as.numeric(str_extract(Memory_Bandwidth, "[\\d\\.]+"))),
    
    ROPs = process_multiplier(ROPs),
    Manufacturer = ifelse(Manufacturer %in% c("", "\n-", " "), NA, trimws(Manufacturer)),
    Memory_Type = ifelse(Memory_Type %in% c("", "\n-", " "), NA, trimws(Memory_Type)),
    
    Notebook_GPU = ifelse(Notebook_GPU == "Yes", TRUE, FALSE)
 ) %>%
filter(Manufacturer %in% c("Nvidia", "AMD", "Intel", "ATI"))

head(gpu_clean)
cat("\n---XỬ LÍ DỮ LIỆU BỊ KHUYẾT (NA)---\n")
na_summary <- data.frame(
  Variable = names(gpu_clean),
  Missing_Count = colSums(is.na(gpu_clean)),
  Missing_Percentage = round(colMeans(is.na(gpu_clean)) * 100, 2)
)

cat("\n--- BẢNG TÓM TẮT DỮ LIỆU KHUYẾT THIẾU ---\n")
print(na_summary)


# Dựa vào bảng na_summary ở trên, nhóm đưa ra chiến lược xử lý như sau:
# 1. Nhóm biến Memory_Bandwidth, Memory_Bus ... có tỷ lệ khuyết cực thấp 
#    => Xóa các dòng khuyết (Drop NA) để giữ tính chân thực của dữ liệu mục tiêu.
# 2. Nhóm biến Core_Speed, Process, Memory_Speed... có tỷ lệ khuyết nhiều
                     
gpu_clean <- gpu_clean %>%
  drop_na(Memory_Type, Memory_Bus, Memory_Speed, Memory_Bandwidth)

# 2. Fill Median cho Nhóm 3 (Các biến độc lập khuyết nhiều)
gpu_clean <- gpu_clean %>%
  mutate(
    Core_Speed = ifelse(is.na(Core_Speed), median(Core_Speed, na.rm = TRUE), Core_Speed),
    Memory = ifelse(is.na(Memory), median(Memory, na.rm = TRUE), Memory),
    Process = ifelse(is.na(Process), median(Process, na.rm = TRUE), Process),
    ROPs = ifelse(is.na(ROPs), median(ROPs, na.rm = TRUE), ROPs),
    TMUs = ifelse(is.na(TMUs), median(TMUs, na.rm = TRUE), TMUs),
    Max_Power = ifelse(is.na(Max_Power), median(Max_Power, na.rm = TRUE), Max_Power)
  )
# Kiểm tra lại chắc chắn đã hết NA chưa
cat("\n Kiểm tra sau khi làm sạch \n")
print(colSums(is.na(gpu_clean)))

cat("\n---THỐNG KÊ MÔ TẢ---\n")
cat("\n---Kiểm tra các giá trị đặc trưng của mẫu---\n")
gpu_clean $ Manufacturer<-as.factor(gpu_clean$Manufacturer)
gpu_clean $ Memory_Type<-as.factor(gpu_clean$Memory_Type)
summary(gpu_clean)


# 1. Pie : manufacturer

pie_manuf <- gpu_clean %>% 
  count(Manufacturer) %>% 
  mutate(prop = n / sum(n) * 100,
         legend_label = paste0(Manufacturer, " (", round(prop, 1), "%)")) %>%
  ggplot(aes(x = "", y = prop, fill = legend_label)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(title = "    Proportion of GPUs by Manufacturer", fill = "Manufacturer")

print(pie_manuf)

# 2. Pie Chart: Notebook GPU

pie_notebook <- gpu_clean %>% 
  count(Notebook_GPU) %>% 
  mutate(Type = ifelse(Notebook_GPU, "Yes", "No"),
         prop = n / sum(n) * 100,
         legend_label = paste0(Type, " (", round(prop, 1), "%)")) %>%
  ggplot(aes(x = "", y = prop, fill = legend_label)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_manual(values = c("tomato", "steelblue")) +
  labs(title = "       Proportion of Notebook GPUs", fill = "Form Factor")

print(pie_notebook)

# 3. Bar Chart: Memory Type Frequency         
bar_memtype <- ggplot(gpu_clean, aes(x = reorder(Memory_Type, Memory_Type, function(x) -length(x)))) +
  geom_bar(fill = "mediumseagreen", color = "black") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "   Frequency of Memory Types", x = "Memory Type", y = "Count")

print(bar_memtype)

#4. Histogram
numeric_vars <- c("Core_Speed", "Max_Power", "Memory_Bandwidth", 
                  "Memory_Speed")
units <- c("MHz", "Watts", "GB/s", "MHz")
par(mar = c(5, 5, 4, 2) + 0.1, xaxs = "i")

for (i in seq_along(numeric_vars)) {
  var <- numeric_vars[i]
  data_vec <- gpu_clean[[var]]
  unit <- units[i]
  breaks_vec <- pretty(data_vec, n = 14)
  
  h <- hist(data_vec, breaks = breaks_vec, plot = FALSE)
  hist(data_vec, 
       breaks = breaks_vec, 
       col = "skyblue", 
       border = "black",
       main = paste("Histogram of", gsub("_", " ", var), "(", unit, ")"),
       xlab = paste(gsub("_", " ", var), "(", unit, ")"),
       ylab = "Frequency",
       labels = TRUE,
       xlim = range(breaks_vec),
       ylim = c(0, max(h$counts) * 1.15), 
       las = 1,
       xaxt = "n")
  
  axis(1, at = breaks_vec)
}



#5.Pair plot
vars_for_pairs <- gpu_clean %>% 
  select(Max_Power, Core_Speed,Memory, Memory_Bandwidth, Memory_Speed,Memory_Bus,Process, ROPs, TMUs)
p_pairs <- ggpairs(
  vars_for_pairs,
  title = "Correlation Matrix of Key Hardware Metrics",
  lower = list(continuous = wrap("points", alpha = 0.3, size = 0.5, color = "darkred")),
  upper = list(continuous = wrap("cor", size = 2))
) +
  theme(
    text = element_text(size = 7),
    axis.text = element_text(size = 5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

print(p_pairs)
boxplot<-gpu_clean
                                                
# 6. boxplot1: so sánh Max power theo Notebook GPU (gpu cho laptop (yes) hoặc desktop (no))

boxplot$Form_Factor <- ifelse(boxplot$Notebook_GPU == TRUE, "Laptop GPU", "Desktop GPU")

p_ttest <- ggplot(boxplot, aes(x = Form_Factor, y = Max_Power, fill = Form_Factor)) +
  geom_boxplot(alpha = 0.7, outlier.color = "red", outlier.shape = 1) +
  theme_minimal() +
  scale_fill_manual(values = c("Desktop GPU" = "steelblue", "Laptop GPU" = "tomato")) +
  labs(title = "      Boxplot: Max Power by Form Factor (Desktop vs Laptop)",
       x = "Type of GPU ", y = "Max Power (Watts)") +
  theme(legend.position = "none")

print(p_ttest)

#7. box plot so sánh giữa 1 vài loại mem type 
top_mem_types <- c("GDDR5", "GDDR3", "DDR3", "DDR2")
gpu_anova_data <- gpu_clean %>% filter(Memory_Type %in% top_mem_types)

p_anova <- ggplot(gpu_anova_data, aes(x = reorder(Memory_Type, Max_Power, median), y = Max_Power, fill = Memory_Type)) +
  geom_boxplot(alpha = 0.8) +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "      Boxplot: Max Power across Top Memory Types",
       x = "Memory type", y = "Max Power (Watts)") +
  theme(legend.position = "none")

print(p_anova)

#8
p_reg1 <- ggplot(boxplot, aes(x = Max_Power, y = Memory_Bandwidth)) +
  
  # Vẽ Desktop trước (nằm dưới)
  geom_point(data = subset(boxplot, Form_Factor == "Desktop GPU"),
             color = "steelblue", alpha = 0.5) +
  
  # Vẽ Laptop sau (nằm trên)
  geom_point(data = subset(boxplot, Form_Factor == "Laptop GPU"),
             color = "tomato", alpha = 0.7) +
  
  geom_smooth(aes(color = Form_Factor), method = "lm", se = FALSE, linewidth = 1.2) +
  
  theme_minimal() +
  labs(title = "Scatter Plot: Max Power vs Memory Bandwidth",
       x = "Max Power (Watts)", 
       y = "Memory Bandwidth (GB/sec)",
       color = "Form Factor") +
  
  scale_color_manual(values = c("Desktop GPU" = "steelblue", 
                                "Laptop GPU" = "tomato")) +
  theme(legend.position = "bottom")

print(p_reg1)  

p_reg4 <- ggplot(boxplot, aes(x = TMUs, y = Memory_Bandwidth)) +
  
  # Desktop (vẽ trước)
  geom_point(data = subset(boxplot, Form_Factor == "Desktop GPU"),
             color = "steelblue", alpha = 0.5) +
  
  # Laptop (vẽ sau → nằm trên)
  geom_point(data = subset(boxplot, Form_Factor == "Laptop GPU"),
             color = "tomato", alpha = 0.7) +
  
  geom_smooth(aes(color = Form_Factor), method = "lm", se = FALSE, linewidth = 1.2) +
  
  theme_minimal() +
  labs(title = "Scatter Plot: TMUs vs Memory Bandwidth",
       x = "TMUs (Count)",
       y = "Memory Bandwidth (GB/sec)",
       color = "Form Factor") +
  
  scale_color_manual(values = c("Desktop GPU" = "steelblue",
                                "Laptop GPU" = "tomato")) +
  
  theme(legend.position = "bottom")

print(p_reg4)    

#Kiểm định 1 mẫu
nvidia_coreSpeed <- subset(gpu_clean, Manufacturer == "Nvidia")$Core_Speed
n <- length(nvidia_coreSpeed)
cat("Kích thước mẫu là:", n)

print("vẽ biểu đồ Q-Q kiểm tra phân phối chuẩn")
qqnorm(nvidia_coreSpeed)
qqline(nvidia_coreSpeed)

print("shapiro test kiểm tra phân phối chuẩn")
shapiro.test(nvidia_coreSpeed)

n <- length(nvidia_coreSpeed)
cat("Kích thước mẫu là:", n)

z_alpha <- qnorm(1 - 0.05)
cat("Xác định miền bác bỏ W: \n")
cat("Giá trị tới hạn z_alpha:", z_alpha, "\n")
cat("Miền bác bỏ: W = (", z_alpha, "; +∞ )\n", sep="")

x_bar <- mean(nvidia_coreSpeed)
sd <- sd(nvidia_coreSpeed)
n <- length(nvidia_coreSpeed)
a0 <- 950
z_qs <- (x_bar - a0) / (sd / sqrt(n))

cat("Trung bình mẫu (x_bar):", x_bar, "\n")
cat("Độ lệch chuẩn (sd):", sd, "\n")
cat("Kích thước mẫu (n):", n, "\n")
cat("Giá trị kiểm định z_qs:", z_qs, "\n")

if(z_qs > z_alpha){
  cat (" Bác bỏ H0\n")
} else{
  cat (" Không bác bỏ H0: Không có đủ bằng chứng thóng kế\n")
}

#Kiểm định 2 mẫu
nvidia_vram <- subset(gpu_clean, Manufacturer == "Nvidia")$Memory
amd_vram <- subset(gpu_clean, Manufacturer == "AMD")$Memory

str(nvidia_vram)
str(amd_vram)

print("vẽ biểu đồ Q-Q kiểm tra phân phối chuẩn")
qqnorm(nvidia_vram, main = "Q-Q Plot cho VRAM NVIDIA")
qqline(nvidia_vram, col = "red")
qqnorm(amd_vram, main = "Q-Q Plot cho VRAM AMD")
qqline(amd_vram, col = "blue")

print("shapiro test kiểm tra phân phối chuẩn")
shapiro.test(nvidia_vram)
shapiro.test(amd_vram)

n1 <- length(nvidia_vram)
n2 <- length(amd_vram)
cat("Kích thước mẫu NVIDIA (n1) là:", n1, "\n")
cat("Kích thước mẫu AMD (n2) là:", n2, "\n")

z_alpha <- qnorm(1 - 0.05)

cat("Xác định miền bác bỏ W: \n")
cat("Giá trị tới hạn z_alpha:", z_alpha, "\n")
cat("Miền bác bỏ: W = (",z_alpha, "; +∞ )\n", sep="")


# Tính toán các đặc trưng mẫu cho NVIDIA 
n1 <- length(nvidia_vram)
x1_bar <- mean(nvidia_vram)
s1 <- sd(nvidia_vram)

# Tính toán các đặc trưng mẫu cho AMD 
n2 <- length(amd_vram)
x2_bar <- mean(amd_vram)
s2 <- sd(amd_vram)

# Tính toán giá trị kiểm định U_{qs}
z_qs <- (x1_bar - x2_bar) / sqrt((s1^2 / n1) + (s2^2 / n2))

# Hiển thị bảng thông số tóm tắt
cat("--- THÔNG SỐ MẪU NVIDIA ---\n")
cat("Kích thước mẫu (n1): ", n1, "\n")
cat("Trung bình (x1_bar):  ", x1_bar, " MB\n")
cat("Độ lệch chuẩn (s1):   ", s1, "\n\n")

cat("--- THÔNG SỐ MẪU AMD ---\n")
cat("Kích thước mẫu (n2): ", n2, "\n")
cat("Trung bình (x2_bar):  ", x2_bar, " MB\n")
cat("Độ lệch chuẩn (s2):   ", s2, "\n\n")

cat("--- KẾT QUẢ TÍNH TOÁN ---\n")
cat("Giá trị kiểm định z_qs: ", z_qs, "\n")





#ANOVA
df_2way <- gpu_clean %>%
  filter(Manufacturer != "ATI") %>% 
  group_by(Manufacturer, Notebook_GPU) %>%
  filter(n() > 20) %>%
  ungroup() %>%
  mutate(
    Manufacturer = as.factor(Manufacturer),
    Notebook_GPU = as.factor(ifelse(as.logical(Notebook_GPU), "Laptop", "Desktop"))
  ) %>%
  droplevels()

cat("\n--- 1. KIỂM TRA ĐIỀU KIỆN CỠ MẪU CỦA CÁC TỔ HỢP ---")
cat("\nMục tiêu: Đảm bảo dữ liệu đủ lớn ở mỗi nhóm (>20) để kết luận có ý nghĩa.\n")
print(table(df_2way$Manufacturer, df_2way$Notebook_GPU))

p_inter <- ggplot(df_2way, aes(x = Notebook_GPU, y = Max_Power, color = Manufacturer, group = Manufacturer)) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.2, aes(group = Manufacturer)) + 
  stat_summary(fun = mean, geom = "point", size = 3) +
  labs(title = "Biểu đồ Tương tác: Manufacturer và Loại thiết bị",
       subtitle = "Đường nối giá trị trung bình công suất giữa Laptop và Desktop",
       x = "Loại thiết bị", y = "Công suất trung bình (W)") +
  theme_minimal()
print(p_inter)

# 2. Boxplot to show distribution

cat("\n[ĐANG VẼ: BIỂU ĐỒ BOXPLOT]\n")
cat("Ghi chú: Quan sát độ trải rộng của dữ liệu và các giá trị ngoại lệ.\n")
p_box <- ggplot(df_2way, aes(x = Manufacturer, y = Max_Power, fill = Notebook_GPU)) +
  geom_boxplot(alpha = 0.7) +
  labs(title = "Distribution of Max Power by Manufacturer and Device Type",
       x = "Manufacturer",
       y = "Max Power (W)") +
  theme_bw()
print(p_box)


cat("\n--- BƯỚC 2: KIỂM ĐỊNH CÁC GIẢ ĐỊNH ---")
model_2way <- aov(Max_Power ~ Manufacturer * Notebook_GPU, data = df_2way)

# 4.2. Kiểm định Levene (Đồng nhất phương sai)
cat("\n[KIỂM ĐỊNH LEVENE - H0: Phương sai các nhóm bằng nhau]\n")
print(leveneTest(Max_Power ~ Manufacturer * Notebook_GPU, data = df_2way))

cat("\n--------------------------------------------------------------")
cat("\n--- BƯỚC 2.2: KIỂM TRA GIẢ ĐỊNH PHÂN PHỐI CHUẨN ---")
cat("\nMục tiêu: Đảm bảo phần dư (residuals) tuân theo phân phối chuẩn.")
cat("\n--------------------------------------------------------------\n")

cat("\n--- 1. ĐỒ THỊ Q-Q PLOT ---\n")
cat("Cách đọc: Nếu các điểm dữ liệu nằm sát đường chéo, giả định phân phối chuẩn được thỏa mãn.\n")
plot(model_2way, which = 2)

cat("\n--- 2. KIỂM ĐỊNH SHAPIRO-WILK ---\n")
cat("H0: Dữ liệu tuân theo phân phối chuẩn.")
cat("\nNếu p-value > 0.05: Chấp nhận H0, dữ liệu có phân phối chuẩn.\n")
print(shapiro.test(residuals(model_2way)))

cat("\n--- BƯỚC 3: KẾT QUẢ ANOVA 2 NHÂN TỐ ---")
cat("\nTrọng tâm: Xem dòng Manufacturer:Notebook_GPU để kết luận về sự tương tác.\n")
print(summary(model_2way))

cat("\n--- BƯỚC 4: KIỂM ĐỊNH HẬU ĐỊNH TUKEY HSD ---")
tukey_2way <- TukeyHSD(model_2way)
print(tukey_2way$`Manufacturer:Notebook_GPU`)

par(mar=c(5, 15, 4, 2)) 
plot(tukey_2way, las = 1, col = "darkred")





#Hồi quy tuyến tính
cat("----------------------- HỒI QUY TUYẾN TÍNH BỘI -----------------------\n")
cat("Bỏ qua một số biến phân loại, còn lại:\n")
cols_to_ignore = c("Manufacturer", "Memory_Type", "Notebook_GPU")
gpu_filter <- gpu_clean[, !(names(gpu_clean) %in% cols_to_ignore)]
print(names(gpu_filter))

cat("Tìm các mô hình tốt nhất bằng tìm kiếm vét cạn:\n")
best_models <- summary(regsubsets(Max_Power ~ ., data = gpu_filter))
print(best_models$which)

cat("Hệ số xác định điều chỉnh của các mô hình và mô hình tốt nhất:\n")
print(best_models$adjr2)
print(which.max(best_models$adjr2))

cat("Xây dựng mô hình ban đầu:\n")
base_model <- lm(Max_Power ~ ., data = gpu_filter)
print(base_model)

cat("VIF của mô hình ban đầu:\n")
vif(base_model)

cat("VIF của mô hình rút gọn biến:\n")
model_1 <- lm(Max_Power ~ . - Memory_Bandwidth, data = gpu_filter)
vif(model_1)

cat("Kiểm định hệ số hồi quy của biến đã rút gọn:\n")
summary(base_model)$coefficients["Memory_Bandwidth",]

cat("Kiểm định hệ số hồi quy tổng thể:\n")
summary(base_model)$coefficients


main_model <- base_model

cat("Biểu đồ phần dư và biểu đồ Q-Q:\n")
plot(main_model, which = 1)
plot(main_model, which = 2)

cat("Kiểm định Shapiro-Wilk và Breush-Pagan:\n")
shapiro.test(main_model$residuals)
bptest(main_model)

cat("Đánh giá mô hình:\n")
summary(main_model)
