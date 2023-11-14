set<-read.csv("E:/研究生/数据分析/2331581 李欣鸿 4R1/mycsv1.csv")
dim(set)
plot(set$lanechangeId,set$VelocityXSmooth, 
     xlab = "id", ylab = "vx",
     main = "Scatter Plot: vx vs. id",
     col = "blue", pch = 16, cex = 0.3)

a=rnorm(50)
b=0
for (i in 1:50){
  b=b+a[i]/50
}
b
#验证结果
mean(a)