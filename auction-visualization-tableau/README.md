# 📊 Data-Driven Auction Planning 拍卖优化可视化分析  
**How to Create a More Competitive Next Auction?**

> 📢 **查看完整交互式可视化仪表板请点击下方链接 ⬇️**  
> 📢 **To view the full interactive Tableau dashboard, please use the link below ⬇️**  
> 🔗 [📊 View on Tableau Public / Tableau 在线仪表板](https://public.tableau.com/views/Data-DrivenAuctionPlanning/OverallStory)

---

## 📌 项目简介 | Project Overview

本项目通过构建 Tableau 仪表板，深入分析线上拍卖平台中的买家、卖家、拍品与区域经理等多维度行为与表现。我们希望为下一轮拍卖提供数据驱动的战略建议，提升盈利能力与市场竞争力。  
This project leverages Tableau dashboards to analyze multidimensional behaviors and performance across buyers, sellers, items, and regional managers on an online auction platform. Our goal is to provide strategic, data-driven recommendations to enhance competitiveness and profitability for future auctions.

---

## 🧠 项目结构 | Key Analytical Sections

### 1. **总览仪表板 | Overview Dashboard**
- 显示总销量（196K 件）、销售额（$951M）、利润（$86.4M）等核心指标  
  Key performance indicators include total items sold (196K), total revenue ($951M), and profit ($86.4M)
- 各州销量排名及月度趋势（12 月高峰，1 月低谷）  
  Sales by state and seasonal trends (peak in December, lowest in January)
- 行业分布（Construction、Vehicles、Agriculture）与高利润商品分布  
  Industry breakdown and top-performing item categories
- 数据清洗：使用 Fixed Calculation 去除重复 item ID  
  Data cleaning using fixed calculation to remove duplicate item IDs

### 2. **买家分析 | Buyer Analysis**
- 构建 Buyer Score（利润 40%、参与度 30%、出价频率 20%、活跃度 10%）  
  Developed Buyer Score with weights: profit (40%), participation (30%), bidding frequency (20%), and activity (10%)
- 地图热力图识别高潜力区域与优质小型买家群体  
  Geo heatmaps to identify high-value buyer regions and small but high-quality buyer segments
- 建议：建立忠诚度计划、VIP 奖励机制和定向营销  
  Recommendations: implement loyalty programs, VIP targeting, and personalized marketing strategies

### 3. **卖家分析 | Seller Analysis**
- 构建 Seller Score（年利润 40%、销售量 30%、参与度 30%）  
  Designed Seller Score based on annual profit (40%), item volume (30%), and auction participation (30%)
- 中部地区卖家表现最强 → 建议优化拍卖地策略  
  Sellers in central regions scored highest → refine auction site planning accordingly
- 支持行业优选策略，注重质量而非数量  
  Industry-focused seller optimization: prioritize seller quality over quantity

### 4. **拍品分析 | Item Analysis**
- 最佳拍卖地：KS 州；低销量异常州：LV 和 UT  
  Kansas (KS) emerged as the most profitable auction location; Las Vegas (LV) and Utah (UT) underperformed
- 商品状态分析：新车、低里程、高利润  
  Item condition analysis showed that new, low-mileage vehicles yielded highest profits
- 类别表现：Vans、Passenger Vehicles、Tractors 最具价值  
  High-profit item categories: vans, passenger vehicles, tractors
- 建议优化评分系统，综合考虑新旧程度、销量与毛利  
  Recalibrate scoring mechanism to balance age, volume, and margin

### 5. **拍卖经理分析 | Manager Performance**
- 不同经理的地理分布与管理绩效一览  
  Evaluated geographical distribution and KPI performance of regional managers
- 发现：无经理地区平均利润更高 → 建议精简配置  
  Insight: states without managers showed higher average profitability → consider trimming low-performing staff
- 顶尖表现：  
  - 最佳买家经理：Doug Mehner  
  - 最佳卖家经理：Bob McBride  
  Top Managers: Doug Mehner (Buyer side), Bob McBride (Seller side)

---

## ✅ 项目结论 | Key Recommendations

- 将 KS 州设为重点拍卖区域  
  Prioritize Kansas as a strategic auction hub  
- 重点维护前 50 位高分买家与高效卖家群体  
  Focus on nurturing top 50 buyers and high-performing sellers  
- 聚焦 Construction 类拍品，强化高利润品类管理  
  Expand Construction category listings to increase profitability  
- 保留顶尖经理，重新配置低效区域经理资源  
