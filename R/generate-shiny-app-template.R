source('R/rxode2-conversion.R')
#rxShiny(zolpidem_rxode2)


zolpidem_ode <- "cmt(Depot1);
cmt(Central);
ka=t.KA*exp(e.KA);
vc=t.VC*exp(e.VC);
cl=t.CL*exp(e.CL);
rxalag.rxddta1.=ALAG1;
alag(Depot1)=rxalag.rxddta1.;
k=cl/vc;
scale2=vc/1000;
d/dt(Depot1)=-ka*Depot1;
d/dt(Central)=ka*Depot1-k*Central;
f=Central/scale2;
ipred=f"

zolpidem_list <- list(
  ode = zolpidem_ode,
  params = c(zolpidem_rxode2$theta, diag(zolpidem_rxode2$omega)), 
  inits = c(eff = 1), 
  method = "lsoda", 
  atol = 1e-08, 
  rtol = 1e-06
)

genShinyApp.template(
  appDir = "shinyzolpidem",
  verbose = TRUE,
  ODE.config = zolpidem_list
)

library(shiny)
runApp("shinyzolpidem")
