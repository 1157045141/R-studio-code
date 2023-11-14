library(dplyr)
#导入数据
accident<-read.csv("E:/研究生/数据分析/2331581 李欣鸿 4R2/ACCIDENT.csv")
person<-read.csv("E:/研究生/数据分析/2331581 李欣鸿 4R2/PERSON.csv")
vehicle<-read.csv("E:/研究生/数据分析/2331581 李欣鸿 4R2/VEHICLE.CSV")
#识别公共属性，并作出交集intersection
cols=intersect(names(accident),names(person))
intersection <- inner_join(accident, person, by = cols)
#对INJ_SEV进行分类统计
result <- person %>%
  group_by(INJ_SEV) %>%
  summarise(count = n())
print(result)
#识别公共属性，用左连接left_join方法构造merge_data
cols_1=intersect(names(accident),names(vehicle))
merged_data <- left_join(accident,vehicle,by = cols_1)

# 报告结果的维度
dim_merged_data <- dim(merged_data)
print(paste("Dimensions of the merged dataset:", paste(dim_merged_data, collapse = " x")))

# 报告右侧数据集中一个变量的缺失值数量
missing_values_count <- sum(is.na(merged_data$variable_in_right_dataset))
print(paste("Number of missing values in the variable of the right dataset:", missing_values_count))
