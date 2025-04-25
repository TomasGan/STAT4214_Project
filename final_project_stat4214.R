# Load data
us_housing <- read.csv("US_HOUSE_PRICE.csv")

plot(us_housing, upper.panel=NULL)

us_housing$DATE <- as.Date(us_housing$DATE, format="%Y-%m-%d")
us_housing$DATE <- as.numeric(format(us_housing$DATE, format="%Y.%m%d"))

full_mdl <- lm(home_price_index ~ ., dat=us_housing)
summary(full_mdl)

#residuals
plot(full_mdl$fitted.values, rstudent(full_mdl), pch=16,
     main="Fitted Values vs Studentized Residuals (Full MDL)", 
     xlab=substitute(paste(bold("Fitted Values"))),
     ylab=substitute(paste(bold("Studentized Residuals"))))
abline(h=0, lty=2, col='red')
library(lmtest)
bptest(full_mdl)

qqnorm(rstudent(full_mdl), pch=16)
abline(0,1,col='red',lwd=2.0)
shapiro.test(rstudent(full_mdl))

#model selection
back_mdl <- step(full_mdl, directon = "backward")
summary(back_mdl)

plot(back_mdl$fitted.values, rstudent(back_mdl), pch=16,
     main="Fitted Values vs Studentized Residuals (Step MDL)",
     xlab=substitute(paste(bold("Fitted Values"))),
     ylab=substitute(paste(bold("Studentized Residuals"))))
abline(h=0, lty=2, col='red')
bptest(back_mdl)

qqnorm(rstudent(back_mdl), pch=16)
abline(0,1,col='red',lwd=2.0)
shapiro.test(rstudent(back_mdl))

#Apply mixed effects model
library(lme4)
library(lubridate)

df <- us_housing
df$Year <- year(ymd(df$DATE))


mx_mdl <- lmer(home_price_index ~ building_permits + const_price_index + delinquency_rate
     + GDP + house_for_sale_or_sold + housing_subsidies + income + interest_rate +
       mortgage_rate + construction_unit + total_houses + total_const_spending +
       unemployment_rate + urban_population + (1 | Year),
     data = df)
summary(mx_mdl)

vcov(mx_mdl)
ranef(mx_mdl)
fixef(mx_mdl)

df$predicted <- predict(mx_mdl)

library(ggplot2)
ggplot(df, aes(x = predicted, y = home_price_index)) +
  geom_point(alpha = 0.5) +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  labs(
    title = "Predicted vs. Actual Home Price Index",
    x = "Predicted",
    y = "Observed"
  ) +
  theme_minimal()

ggplot(df, aes(x = GDP, y = home_price_index, color = as.factor(Year))) +
  geom_point() +
  geom_abline(intercept = -184.4, slope = 0.004488, color = "black",
              linetype = "dashed", size = 1.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Home Price Index vs GDP by Year",
       x = "GDP",
       y = "Home Price Index", 
       color = "Year") +
  theme_minimal()

ggplot(df, aes(x = interest_rate, y = home_price_index, color = as.factor(Year))) +
  geom_point() +
  geom_abline(intercept = -184.4, slope = 3.045, color = "black",
              linetype = "dashed", size = 1.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Home Price Index vs Interest Rate by Year",
       x = "Interest Rate",
       y = "Home Price Index", 
       color = "Year") +
  theme_minimal()

predictor_vars <- c("building_permits", "const_price_index", "delinquency_rate", "GDP",
                    "house_for_sale_or_sold", "housing_subsidies", "income", "interest_rate",
                    "mortgage_rate", "construction_unit", "total_houses",
                    "total_const_spending", "unemployment_rate", "urban_population")


df_scaled <- df
df_scaled[predictor_vars] <- scale(df_scaled[predictor_vars])
mx_mdl_scaled <- lmer(home_price_index ~ building_permits + const_price_index + delinquency_rate
               + GDP + house_for_sale_or_sold + housing_subsidies + income + interest_rate +
                 mortgage_rate + construction_unit + total_houses + total_const_spending +
                 unemployment_rate + urban_population + (1 | Year),
               data = df_scaled)
summary(mx_mdl_scaled)

ggplot(df_scaled, aes(x = GDP, y = home_price_index, color = as.factor(Year))) +
  geom_point() +
  geom_abline(intercept = 180.66, slope = 8.986, color = "black",
              linetype = "dashed", size = 1.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Home Price Index vs GDP by Year",
       x = "GDP",
       y = "Home Price Index", 
       color = "Year") +
  theme_minimal()

ggplot(df_scaled, aes(x = interest_rate, y = home_price_index, color = as.factor(Year))) +
  geom_point() +
  geom_abline(intercept = 180.66, slope = 4.806, color = "black",
              linetype = "dashed", size = 1.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Home Price Index vs Interest Rate by Year",
       x = "Interest Rate",
       y = "Home Price Index", 
       color = "Year") +
  theme_minimal()

ggplot(df_scaled, aes(x = income, y = home_price_index, color = as.factor(Year))) +
  geom_point() +
  geom_abline(intercept = 180.66, slope = -0.044, color = "black",
              linetype = "dashed", size = 1.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Home Price Index vs Income by Year",
       x = "Income",
       y = "Home Price Index", 
       color = "Year") +
  theme_minimal()


ggplot(df_scaled, aes(x = house_for_sale_or_sold, y = home_price_index, color = as.factor(Year))) +
  geom_point() +
  geom_abline(intercept = 180.66, slope = -2.481, color = "black",
              linetype = "dashed", size = 1.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Home Price Index vs Houses for Sale/Sold by Year",
       x = "Houses for Sale/Sold (millions)",
       y = "Home Price Index", 
       color = "Year") +
  theme_minimal()

ggplot(df_scaled, aes(x = housing_subsidies, y = home_price_index, color = as.factor(Year))) +
  geom_point() +
  geom_abline(intercept = 180.66, slope = 16.557, color = "black",
              linetype = "dashed", size = 1.5) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Home Price Index vs Housing Subsidies by Year",
       x = "Housing Subsidies",
       y = "Home Price Index", 
       color = "Year") +
  theme_minimal()
