# 🏠 iBuyer 房价预测与盈利评估（MLP 模型）  
**iBuyer House Price Prediction & Profitability Analysis (MLP)**

## 📌 项目简介 | Project Overview

本项目旨在构建一个机器学习模型来预测房屋售价，从而帮助 iBuyer 模型做出更精准的出价决策，并模拟其在不同接受场景下的盈利能力。  
This project develops machine learning models to predict property sale prices and simulate profitability under the iBuyer business model.

我们采用了多层感知器（MLP）模型进行回归预测，并评估了模型在所有房主接受出价、部分接受出价等假设场景下的利润率表现。  
We use multilayer perceptron (MLP) models to estimate home prices and evaluate iBuyer profitability under both full and selective offer acceptance scenarios.

---

## 🧠 使用技术 | Technologies

本项目使用以下主要技术栈：  
The project utilizes the following core tools and techniques:

- Python (PyTorch, pandas, matplotlib)
- MLP 模型（含两层与四层结构） / MLP architectures (2-layer and 4-layer)
- 正则化（L1 / L2）、Dropout、防过拟合处理  
  Regularization (L1/L2), Dropout to reduce overfitting
- Median Error Rate (MER) 回归指标  
  Regression metric: Median Error Rate (MER)
- 房价数据：私有 Kaggle 比赛数据集（带标签训练集 + 无标签测试集）  
  Data: Private Kaggle-style dataset (labeled train + unlabeled test)

---

## 🔧 方法与流程 | Methodology Summary

1. **数据探索与标准化 | Data Preprocessing and Scaling**  
   对房价进行归一化处理，并使用 z-score 对数值特征标准化  
   Normalized prices and standardized numerical features using z-score

2. **One-Hot 编码 | One-Hot Encoding**  
   将类别变量（如社区、房屋类型）转换为哑变量  
   Converted categorical variables (e.g., neighborhood, building type) to binary features

3. **模型构建 | Model Building**  
   - 两层 MLP 模型（256, 128） / 2-layer MLP (256, 128)  
   - 四层 MLP 模型（512, 256, 128, 64） / 4-layer MLP (512, 256, 128, 64)  
   - 使用 ReLU 或 LeakyReLU 激活，训练 200~300 轮  
     Activated by ReLU or LeakyReLU; trained for 200–300 epochs  
   - 使用 MER 评估训练与验证误差  
     MER used to evaluate model performance on training/validation sets

4. **正则化与 Dropout | Regularization & Overfitting Control**  
   引入 L2 正则与 Dropout（0.1~0.2）提升泛化能力  
   Used L2 regularization and dropout (0.1–0.2) to improve generalization

5. **最优模型评估 | Final Model Evaluation**  
   最终模型在验证集上的 MER 为 0.0958，泛化能力较强  
   Final model achieved validation MER of **0.0958**, indicating strong generalization

---

## 💰 盈利模拟 | Profitability Analysis

### 🧪 场景 1：所有房主接受报价（理想情况）  
### Scenario 1: All Homeowners Accept Offers (Ideal Case)

- 假设 iBuyer 目标利润率为 12%  
  Assumed target profit margin: 12%
- 实际平均利润率 ≈ **12.38%** ✅  
  Actual average profit margin ≈ **12.38%**
- 说明：模型预测价格基本可支撑预期利润  
  Suggests model predictions support expected profitability

### 🤝 场景 2：部分房主接受（更贴近现实）  
### Scenario 2: Selective Offer Acceptance (Realistic Case)

- 假设房主只接受接近真实价格 90% 的报价  
  Homeowners only accept offers ≥ 90% of real value
- 平均利润率 ≈ **-2.29%** ❌  
  Average profit margin ≈ **-2.29%**
- 说明：预测略有高估，导致亏损  
  Indicates overvaluation leads to loss in this scenario

### 📊 预测偏差分析 | Prediction Bias Analysis

- 平均预测偏差约为 +4.22%，说明模型略有高估  
  Average prediction bias: +4.22% → mild overestimation  
- 在房主接受的报价中，偏差升至 +18.3%，进一步影响盈利  
  For accepted offers, bias increased to +18.3%, impacting profits

---

## 📝 项目亮点 | Highlights

- 构建了多种 MLP 架构并进行超参数调优  
  Built and tuned multiple MLP architectures
- 综合使用正则化、Dropout 等技术防止过拟合  
  Applied regularization and dropout for overfitting control
- 基于真实商业逻辑评估模型盈利能力  
  Evaluated profitability based on realistic business assumptions
- 使用 MER 替代 MSE，更贴合定价与利润预期  
  Used MER instead of MSE to better capture pricing deviation impact

---

## 📁 文件说明 | File Structure

- `ibuyer-mlp-model.ipynb` – 主模型训练与分析代码  
  Main notebook for model training and profitability simulation
- `project-report.pdf` – 项目完整汇报文档  
  Final project report (methodology + insights)
- `checkpoint.pth` – 最佳模型权重（可选）  
  Best saved model checkpoint (optional)

---

## ✅ 小结 | Conclusion

该项目展示了如何将回归模型与商业目标（iBuyer 盈利）结合，既有模型精度的优化，也有真实场景的收益评估，是一项融合数据科学与商业判断的综合案例。  
This project integrates regression modeling with real-world business evaluation, showcasing both predictive power and profitability alignment under realistic scenarios.

🏆 **项目在 Duke 机器学习竞赛 总排名第七（共 72 组），并荣获 Certificate of Excellence。**  
🏆 **Ranked  7th overall out of 72 teams in Duke machine learning competition; awarded Certificate of Excellence.**
