#将iri.csv中的数据导入到set数据集中。
set<-read.csv("E:/研究生/数据分析/2331581 李欣鸿 4R2/iri.csv", stringsAsFactors = FALSE)
set$VISIT_DATE <- as.Date(paste0("2023-", set$VISIT_DATE), format = "%Y-%m/%d")

#筛选符合要求行数，生成子集subset
subset<-NULL
len<-dim(set)[1]
for (i in 1:len){
  if (!is.na(set[i,2])&&startsWith( set[i,2],"050")&&set[i,1]==6){
    subset<-rbind(subset,set[i,])
  }
}
#求统计参数：最大值、最小值、平均值
min_iri<-min(set[,5],na.rm = TRUE)
max_iri<-max(set[,5],na.rm = TRUE)
mean_iri<-mean(set[,5],na.rm = TRUE)

#将iri降序排列后，返回STATE_CODE
set_eff<-NULL
for (i in 1:len){
  if (!is.na(set[i,2])){
    set_eff<-rbind(set_eff,c(set[i,1],set[i,5]))
  }
}
set_eff_sorted<-set_eff[order(set_eff[,2],decreasing=TRUE),]
result<-set_eff_sorted[,1]

#剔除包含缺失值的行，将结果储存在set_eff_1中
set_eff_1<-NULL
for (i in 1:len){
  n<-0
  for (j in 1:5){
    if (is.na(set[i,j])){
      n<-n+1
    }
  }
  if(n==0){
    set_eff_1<-rbind(set_eff_1,set[i,])
  }
}
#计算由STATE_CODE, SHRP_ID标识的IRI的平均值
library(dplyr)
averaged_IRI <- set_eff_1 %>%
  group_by(STATE_CODE, SHRP_ID, VISIT_DATE) %>%
  summarise(mean_IRI = mean(IRI, na.rm = TRUE))

# 创建散点图
plot(averaged_IRI$VISIT_DATE, averaged_IRI$mean_IRI,
     xlab = "Date", ylab = "Mean IRI",
     main = "Scatter Plot: Mean IRI vs. Date",
     col = "blue", pch = 16, cex = 0.2)
