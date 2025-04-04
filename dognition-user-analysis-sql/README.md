# 🐶 Dognition 用户行为分析（User Behavior Analysis）

## 📌 项目概览 | Project Overview

本项目基于犬类认知训练应用 **Dognition** 的真实用户数据，使用 SQL 在 Jupyter Notebook 中进行深入分析，目标是清洗数据、识别主键、构建实体关系模型（ERD），并为用户行为理解打下基础。

This project analyzes real user data from the canine cognitive training app **Dognition**. It involves SQL-based data cleaning, primary key identification, and ER modeling within a Jupyter Notebook environment.

> 📅 项目时间：2024 Fall（杜克大学 MQM 项目）  
> 🧑‍🤝‍🧑 团队：Team 20 — Chuqi Fang, Yaqi Jia, Jianjun Lei, Charlaine Jo

---

## 🔍 核心任务与发现 | Key Tasks & Findings

### ✅ 数据清洗与主键识别 | Table Cleaning & Primary Keys

- `complete_tests` 表  
  - 原始记录数：193,246 → 清洗后：177,667  
  - 主键字段：`created_at`, `test_name`, `dog_guid`

- `dogs` 表  
  - 无重复记录，主键为：`dog_guid`

- `exam_answers` 表  
  - 原始记录数：2,458,699 → 清洗后：2,452,440  
  - 去重 & 去空值操作成功

### 🧩 实体关系图（ERD）| Entity Relationship Diagram

使用 **ERDPlus** 构建 ER 图，明确定义了狗狗（用户）、测试记录、答题内容之间的关系。  

ER diagram was created using **ERDPlus** to define the structure and relationships between dogs, test records, and exam answers.

---

## ✨ 项目亮点 | Highlights

- 精准使用 SQL 分组校验主键逻辑  
- 搭建整洁的数据结构，有助于后续可视化分析或用户分群  
- 展现了数据工程思维与业务理解的结合

- Used SQL grouping logic to validate primary keys  
- Built clean data structure ready for downstream visualization or segmentation  
- Showcases a strong combination of data engineering and business thinking

---

## 🛠️ 技术栈 | Tools & Tech

- PostgreSQL / SQL  
- Jupyter Notebook  
- ERDPlus (ER 图绘制)  
- Pandas（用于结果辅助验证）

---

## 📁 文件说明 | Files

- `Dognition_User_SQL_Jupyter_ERDPlus.ipynb` – 主分析文件（Main analysis notebook）  
- `ERD.png` – 实体关系图（ER Diagram, if available）

---

## ✅ 小结 | Summary

本项目展示了 SQL 清洗与数据建模的完整流程，具备良好的团队协作与文档表达，是数据基础设施学习的优秀实践案例。

This project showcases a complete SQL-driven data modeling workflow, highlighting teamwork and documentation — a solid practice of data infrastructure skills.

