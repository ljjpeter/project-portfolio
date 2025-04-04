# 🏠 iBuyer 房价预测与盈利评估（MLP 模型）  
**iBuyer House Price Prediction & Profitability Analysis (MLP)**

## 📌 项目简介 | Project Overview

本项目旨在构建一个机器学习模型来预测房屋售价，从而帮助 iBuyer 模型做出更精准的出价决策，并模拟其在不同接受场景下的盈利能力。  
This project develops machine learning models to predict property sale prices and simulate profitability under the iBuyer business model.

我们采用了多层感知机（MLP）模型进行回归预测，并评估了模型在所有房主接受出价、部分接受出价等假设场景下的利润率表现。  
We use multilayer perceptron (MLP) models to estimate home prices and evaluate iBuyer profitability under both full and selective offer acceptance scenarios.

---

## 🧠 使用技术 | Technologies

- Python (PyTorch, pandas, matplotlib)
- MLP 模型（含两层与四层结构）
- 正则化（L1 / L2）、Dropout、防过拟合处理
- Median Error Rate (MER) 回归指标
- 房价数据：Kaggle 数据集（带标签训练集 + 无标签测试集）

---

## 🔧 方法与流程 | Methodology Summary

1. **数据探索与标准化**：对房价进行归一化处理，并使用 z-score 对数值特征标准化  
   Data normalization and standardization using z-score scaling

2. **One-Hot 编码**：将类别变量（如社区、房屋类型）转换为哑变量  
   One-hot encoding for categorical features

3. **模型构建**：  
   - **两层 MLP 模型**（256, 128）  
   - **四层 MLP 模型**（512, 256, 128, 64）  
   - 各模型使用 ReLU 或 LeakyReLU 激活，训练 200~300 轮  
   - 使用 MER 评估训练与验证误差  

4. **正则化与 Dropout**：引入 L2 正则、Dropout（0.1~0.2）减少过拟合  
   Regularization and dropout applied to improve generalization

5. **最优模型评估**：最终模型在验证集上的 MER 为 0.0958，泛化能力较强  
   Final model achieves validation MER of **0.0958**, showing good generalization

---

## 💰 盈利模拟 | Profitability Analysis

### 🧪 场景 1：所有房主接受报价（理想情况）  
- 假设 iBuyer 目标利润率为 12%  
- 实际平均利润率 ≈ **12.38%** ✅  
- 说明：模型预测价格基本可支撑预期利润

### 🤝 场景 2：部分房主接受（更贴近现实）  
- 假设房主只接受接近真实价格 90% 的报价  
- 平均利润率 ≈ **-2.29%** ❌  
- 说明：在选择性接受场景中，模型偏高估值，导致盈利能力下降

### 📊 预测偏差分析  
- 平均预测偏差约为 +4.22%，说明模型**略有高估**  
- 在房主接受的报价中，偏差进一步升至 +18.3%，影响盈利

---

## 📝 项目亮点 | Highlights

- 构建了多种 MLP 架构并进行超参数调优  
- 综合使用 L1/L2 正则、Dropout 等防过拟合手段  
- 商业场景结合模型误差进行实际利润率分析  
- 使用 MER 替代 MSE，更贴合价格区间大、比例对比的需求

---

## 📁 文件说明 | File Structure

- `ibuyer-mlp-model.ipynb` – 主模型训练与分析代码  
- `project-report.pdf` – 项目完整汇报文档  
- `checkpoint.pth` – 保存的最佳模型权重（可选）

---

## ✅ 小结 | Conclusion

该项目展示了如何将回归模型与商业目标（iBuyer 盈利）结合，既有模型精度的优化，也有真实场景的收益评估，是一项融合数据科学与商业判断的综合案例。  
This project integrates regression modeling with real-world business evaluation, showcasing both predictive power and profitability alignment under realistic scenarios.

