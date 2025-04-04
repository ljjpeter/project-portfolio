# 🎵 TikTok 热门音乐预测（R语言机器学习）  
**TikTok Music Popularity Prediction using Machine Learning in R**

## 📌 项目简介 | Project Overview

本项目旨在预测 TikTok 平台歌曲的流行度，帮助内容创作者、平台推荐系统以及广告商更高效地识别潜力音乐。  
This project aims to predict song popularity on TikTok using historical data, enabling creators, recommendation engines, and advertisers to better identify trending music.

我们使用 Kaggle 发布的 2021 年 TikTok 热门歌曲数据，构建了多个机器学习模型，对歌曲的音乐属性（如能量、舞蹈性、节奏等）进行建模，预测其受欢迎程度（0-100 分）。  
Using the 2021 TikTok popular songs dataset from Kaggle, we built multiple machine learning models based on musical attributes to predict song popularity scores (0 to 100).

---

## 🧠 使用技术 | Tools & Techniques

本项目使用以下工具与技术：  
The project utilizes the following tools and techniques:

- R (tidyverse, randomForest, glmnet, keras)
- 数据预处理与标准化（Standardization, One-Hot Encoding）  
  Data preprocessing and standardization (Z-score, one-hot encoding)
- 模型对比：PCA + Linear Regression, LASSO, Random Forest, Neural Network  
  Model comparison: PCA regression, LASSO, random forest, neural network
- 模型评价指标：OOS R², MAE, RMSE  
  Evaluation metrics: OOS R², MAE, RMSE
- 可视化：预测值 vs 实际值 散点图、误差分析图等  
  Visualizations: predicted vs actual plots, error analysis

---

## 🔧 建模流程 | Modeling Workflow

1. **数据清洗与标准化 | Data Cleaning & Scaling**  
   - 移除无关字段（如歌曲名、艺术家名）  
     Removed non-predictive fields like song name and artist  
   - 转换类别变量（如 key / mode）为数值型  
     Converted categorical variables (key, mode) to numeric format  
   - 标准化所有特征，提升模型稳定性  
     Standardized features to improve model stability

2. **模型构建 | Models Developed**  
   - 🧮 PCA + Linear Regression：维度降维后线性拟合，便于解释  
     PCA-based linear model for dimensionality reduction and interpretability  
   - 🌲 Random Forest：非线性建模，效果强但不易解释  
     Strong nonlinear performance, but less interpretable  
   - 🧪 LASSO Regression：线性稀疏建模，便于特征选择  
     Regularized linear model for feature selection  
   - 🤖 Neural Network：适合复杂数据，但易过拟合  
     Suitable for nonlinear patterns, but prone to overfitting in small data

3. **模型表现 | Model Evaluation**  
   - ✅ LASSO 表现最佳：OOS R² = 0.169，MAE = 0.64，RMSE = 0.91  
     LASSO performed best: OOS R² = 0.169, MAE = 0.64, RMSE = 0.91  
   - 🌲 Random Forest 次之：OOS R² = 0.129，MAE = 0.63，RMSE = 0.93  
     Random Forest: OOS R² = 0.129, MAE = 0.63, RMSE = 0.93  
   - 🤖 Neural Net 效果一般：受限于数据量，泛化能力较弱  
     Neural network underperformed due to limited data and overfitting

---

## 💡 商业应用 | Business Use Cases

- 🎯 **音乐版权策略优化**  
  Predict potential hits to acquire music rights in advance  
- 📈 **广告推荐提升**  
  Use trending music to boost ad click-through rates  
- 📊 **算法推荐优化**  
  Integrate model predictions into music recommender systems  
- 🧪 **AB 测试辅助**  
  Evaluate impact of featured music on user interaction via experiments

---

## ⚠️ 项目局限与建议 | Limitations & Future Work

- 样本量有限，R² 偏低 → 建议扩展历史数据与交互数据  
  Small dataset size limits performance; suggest expanding input data  
- 未建模时间因素，无法考虑曲目热度随时间演化  
  No temporal modeling; unable to track trends over time  
- 后续部署建议滚动训练更新模型，适应音乐趋势变化  
  Recommend retraining with rolling windows to follow new trends

---

## 📁 文件说明 | File Structure

- `TikTok Model.R` – 所有模型训练与分析代码  
  Full training, modeling, and visualization code in R  
- `DS Final Report.pdf` – 完整项目报告（含建模、部署与伦理）  
  Full report including modeling details, deployment & ethical discussion

---

## 📂 数据来源 | Data Source

项目使用的公开数据来自 Kaggle 平台：  
Dataset is publicly available on Kaggle:

🔗 [TikTok Popular Songs 2021 (Kaggle)](https://www.kaggle.com/datasets/maharshipandya/tiktok-popular-songs-2021)  
> 数据集包含 190 首歌曲、18 个特征；目标变量为 `track_pop`（流行度评分）  
> Includes 190 songs with 18 features; target variable is `track_pop` (popularity score)

---

## ✅ 项目总结 | Conclusion

本项目展示了如何结合机器学习与商业视角，构建用于流媒体平台的内容预测模型。通过对比多种算法，我们探索了解释力、准确度与可部署性的平衡点。  
This project showcases the use of machine learning to support business decisions in content curation. By comparing various models, we explored trade-offs between interpretability, accuracy, and deployability.

