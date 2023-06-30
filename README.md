# 숙제

6.27
--



Packages

```{r}
library(tidyverse)
library(ggplot2)
library(NonCompart)
library (knitr)
```

Raw Data

```{r}
data <-   read_csv("pkpd_dataset.csv", na= "NA")
```


## 1

Data
```{r}
data_cycle_1 <- data |>
  filter(CMT == 2 & CYCLE == 1 & NAME == "PK Concentration") |>
  select(ID, NOMTIME, LIDV, DOSE) |>
  mutate(DOSE = as.factor(DOSE))
```


Plot: cycle1 cmt2 pk
```{r}
data_cycle_1 |>
  ggplot(aes(x = NOMTIME, y = LIDV, color = DOSE, group = ID)) + geom_line() +
  geom_point() + facet_wrap(~DOSE) + labs(title = "cycle1_cmt2_pk")
```

![Result](https://github.com/chahwajun/r4ds/blob/6.27-pk/cycle1_cmt2_pk.png)


## 2

Data
```{r}
 data_mean_sd <- data |>
  filter(CYCLE == 1 & NAME == "PK Concentration") |>
  select(ID, NOMTIME, LIDV, NAME, DOSE) |>
  mutate(DOSE = as.numeric(DOSE))

data_mean_sd_1 <- data_mean_sd|>
  group_by(DOSE, NOMTIME) |>
   summarize(LIDV_mean = mean(LIDV),
             LIDV_sd = sd(LIDV)
            )
```



Plot : cycle1 mean, SD pk

```{r}

data_mean_sd_1 |>
  ggplot(aes(x = NOMTIME, y = LIDV_mean)) + geom_line() + geom_point() +
  geom_errorbar(aes(ymin = LIDV_mean + LIDV_sd, ymax = LIDV_mean - LIDV_sd)) +
  facet_wrap(~DOSE) + labs(title = "cycle1_pk_mean&sd")
```

![Result](https://github.com/chahwajun/r4ds/blob/6.27-pk/cycle1_pk_mean%26sd.png)

## 3

Data

```{r}
data_nca <- data |>
  filter(NAME == "PK Concentration" & !is.na(LIDV)) |>
  select(ID, NOMTIME, LIDV, DOSE, NAME)
```

NCA result


```{r}
nca_result <- tblNCA(data_nca, key=c("ID", "DOSE"), colTime="NOMTIME", colConc="LIDV",timeUnit = "h", doseUnit="mg", concUnit="ng/mL")
```


CMAX mean, median, sd, min, max

```{r}
nca_CMAX <-  nca_result |>
  select(ID, DOSE, CMAX) |>
  group_by(DOSE) |>
  summarize(CMAX_mean = mean(CMAX),
            CMAX_median = median(CMAX),
            CMAX_sd = sd(CMAX),
            CMAX_min = min(CMAX),
            CMAX_max = max(CMAX)
            )

knitr::kable(nca_CMAX)
```
![Result](https://github.com/chahwajun/r4ds/blob/6.27-pk/CMAX.png)
