Readme
================
2023-07-07

``` r
#packages ----
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.2     ✔ readr     2.1.4
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.0
    ## ✔ ggplot2   3.4.2     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
    ## ✔ purrr     1.0.1     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(ggplot2)
library(NonCompart)



#raw_data ----
data <-  read_csv("pkpd_dataset.csv", na= "NA")
```

    ## Rows: 20820 Columns: 21
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (4): TIMEUNIT, NAME, EVENTU, TRTACT
    ## dbl (17): ID, TIME, NOMTIME, AMT, LIDV, CMT, CENS, EVID, WEIGHTB, eff0, DOSE...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
# 1 ----

#data
data_cycle_1 <- data |>
  filter(CMT == 2 & CYCLE == 1 & NAME == "PK Concentration") |>
  select(ID, NOMTIME, LIDV, DOSE) |>
  mutate(DOSE = as.factor(DOSE))



#plot: cycle1 cmt2 pk
data_cycle_1 |>
  ggplot(aes(x = NOMTIME, y = LIDV, color = DOSE, group = ID)) + geom_line() +
  geom_point() + facet_wrap(~DOSE) + labs(title = "cycle1_cmt2_pk")
```

![](README_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
ggsave('cycle1_cmt2_pk.png')
```

    ## Saving 7 x 5 in image

``` r
# 2 ----

# data
 data_mean_sd <- data |>
  filter(CYCLE == 1 & NAME == "PK Concentration") |>
  select(ID, NOMTIME, LIDV, NAME, DOSE) |>
  mutate(DOSE = as.numeric(DOSE))




#plot : cycle1 mean, SD pk
data_mean_sd_1 <- data_mean_sd|>
  group_by(DOSE, NOMTIME) |>
   summarize(LIDV_mean = mean(LIDV),
             LIDV_sd = sd(LIDV)
            )
```

    ## `summarise()` has grouped output by 'DOSE'. You can override using the
    ## `.groups` argument.

``` r
data_mean_sd_1 |>
  ggplot(aes(x = NOMTIME, y = LIDV_mean)) + geom_line() + geom_point() +
  geom_errorbar(aes(ymin = LIDV_mean + LIDV_sd, ymax = LIDV_mean - LIDV_sd)) +
  facet_wrap(~DOSE) + labs(title = "cycle1_pk_mean&sd")
```

![](README_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

``` r
ggsave('cycle1_pk_mean&sd.png')
```

    ## Saving 7 x 5 in image

``` r
# 3 ----

# data
data_nca <- data |>
  filter(NAME == "PK Concentration" & !is.na(LIDV)) |>
  select(ID, NOMTIME, LIDV, DOSE, NAME)

#NCA result

nca_result <- tblNCA(data_nca, key=c("ID", "DOSE"), colTime="NOMTIME", colConc="LIDV",timeUnit = "h", doseUnit="mg", concUnit="ng/mL")

#CMAX mean, median, sd, min, max
nca_result |>
  select(ID, DOSE, CMAX) |>
  group_by(DOSE) |>
  summarize(CMAX_mean = mean(CMAX),
            CMAX_median = median(CMAX),
            CMAX_sd = sd(CMAX),
            CMAX_min = min(CMAX),
            CMAX_max = max(CMAX))
```

    ## # A tibble: 5 × 6
    ##    DOSE CMAX_mean CMAX_median CMAX_sd CMAX_min CMAX_max
    ##   <dbl>     <dbl>       <dbl>   <dbl>    <dbl>    <dbl>
    ## 1     3    0.0579      0.0532  0.0104   0.05     0.0872
    ## 2    10    0.138       0.131   0.0455   0.0576   0.256 
    ## 3    30    0.384       0.360   0.157    0.169    0.902 
    ## 4   100    1.42        1.40    0.396    0.709    2.55  
    ## 5   300    3.99        3.92    1.21     2.23     7.00
