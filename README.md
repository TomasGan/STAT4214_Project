# US Housing Price Analysis

A statistical analysis project using R to study the factors influencing U.S. housing prices through regression modeling, diagnostics, and mixed-effects modeling.

## Overview

This project analyzes U.S. housing data to understand the relationship between economic indicators and the home price index. The analysis includes:

- Multiple linear regression modeling  
- Model diagnostics and validation  
- Feature selection using stepwise regression  
- Mixed-effects modeling to account for temporal variation  
- Data visualization using ggplot2  

## Objectives

- Identify key factors influencing housing prices  
- Evaluate model assumptions and performance  
- Compare different modeling approaches  
- Capture year-based variability using mixed-effects models

## Conclusions
- This project examined how economic conditions, construction activity, and housing supply relate to U.S. housing prices. The results showed that stronger economic indicators were generally associated with higher housing prices, while greater housing availability was associated with lower prices.

- A mixed-effects model was selected as the final model to account for the time-dependent structure of the data. This provided a more reliable way to study the relationship between housing prices and key predictors over time.

- Overall, the analysis suggests that housing prices are driven by multiple interconnected factors, and that increasing housing supply may be one of the most direct ways to reduce upward pressure on prices.
- If a policy maker were looking to tackle housing prices as they are, they should enact policy that would increase the amount of houses available on the market.
    - Policies that improve economic well being, while good for the people, actually tend to lead to an increase in the HPI

## Dataset

The dataset (`US_HOUSE_PRICE.csv`) includes:

- Home Price Index (target variable)  
- Economic indicators such as:
  - GDP  
  - Interest rate  
  - Mortgage rate  
  - Income  
  - Unemployment rate  
  - Housing supply metrics  
- Time variable (`DATE`) used for temporal analysis  

## Methodology

### 1. Data Preprocessing
- Converted `DATE` to numeric format for modeling  
- Extracted year for grouping in mixed-effects models  

### 2. Multiple Linear Regression
- Built a full regression model using all predictors  
- Evaluated model using:
  - Residual plots  
  - Studentized residuals  
  - Normality tests (Shapiro-Wilk)  
  - Heteroscedasticity test (Breusch-Pagan)  

### 3. Model Selection
- Applied backward stepwise regression  
- Compared reduced model with full model  
- Re-evaluated assumptions and diagnostics  

### 4. Mixed-Effects Model
- Used `lme4` to incorporate random effects by year  
- Captured temporal variability in housing prices  
- Extracted:
  - Fixed effects  
  - Random effects  
  - Variance-covariance structure  

### 5. Feature Scaling
- Standardized predictor variables  
- Refit mixed-effects model to interpret relative importance  

### 6. Visualization
- Predicted vs actual values  
- Relationships between key variables and housing prices:
  - GDP vs Home Price Index  
  - Interest Rate vs Home Price Index  
  - Income vs Home Price Index  
  - Housing Supply vs Home Price Index  
  - Housing Subsidies vs Home Price Index  

## Packages Used

- R  
- ggplot2  
- lme4  
- lmtest  
- lubridate
