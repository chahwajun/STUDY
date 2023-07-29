# setup ----
# install.packages(c('rxode2', 'nonmem2rx'))
library(rxode2)
library(nonmem2rx)
library(ggplot2)

zolpidem_labs <- list(
  x = "Time (h)",
  y = "Plasma concentration of zolpidem (ug/L)"
)

# main ----

zolpidem_rxode2 <- nonmem2rx(
  'data-raw/ZPD_101101E01_ED_edited.OUT',
  save=FALSE, validate=FALSE, compress=FALSE
)

zolpidem_rxode2

zolpidem_dosing <- eventTable(
  amount.units="mg", 
  time.units="hr"
) |> 
  add.dosing(dose=10, nbr.doses=1)

# rxSolve figures ----

rxSolve(zolpidem_rxode2, zolpidem_dosing) 

rxSolve(zolpidem_rxode2, zolpidem_dosing) |> 
  plot()

rxSolve(zolpidem_rxode2, zolpidem_dosing, nSub = 100) |> 
  plot(ipred) +
  theme_bw() +
  labs(
    title="Plasma concentration-time profiles of zolpidem (N=100)",
    x = zolpidem_labs$x,
    y = zolpidem_labs$y
  )

rxSolve(zolpidem_rxode2, zolpidem_dosing, nSub = 2000) |>
  confint("ipred", level=0.95) %>%
  plot(ylab = zolpidem_labs$labs) +
  theme_bw() +
  labs(
    title="Mean plasma concentration-time profiles of zolpidem (N=2000)",
    x = zolpidem_labs$x,
    y = zolpidem_labs$y
  )