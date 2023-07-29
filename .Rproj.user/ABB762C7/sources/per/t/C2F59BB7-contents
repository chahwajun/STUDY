library(shiny)
library(tidyverse)
library(rxode2)
library(ggplot2)
library(nonmem2rx)


# ui ----
ui <- navbarPage(
  "Zolpidem Simulator",
  
  #단일 투여군의 경우
  
   tabPanel("Single",
            sidebarLayout(
              sidebarPanel(
                sliderInput("Dose", "복용량(알)", min = 0, max = 140, value = 20, step = 1),
                sliderInput("Time", "복용 후 시간", min= 0, max = 24,  value= 4, step = 0.1206030),
                textOutput("Time"),
                
              sliderInput("Simulation", "시뮬레이션 횟수", min = 10, max = 2000, value = 100, step = 10)
              
              ),
              mainPanel(
                "Plasma concentration-time profiles of zolpidem",
                  plotOutput("plot"),
                "PK parameters",
                tableOutput("parametertable"),
                "Individual PK Parameters",
                  tableOutput("iparametertable")
                  
              )
            
            
   )
   ),
  
  # 여러번 투여할 경우 
  
  tabPanel("Multiple"
  ),
  
   tabPanel("CMAX"),
   tabPanel("Help")
  )



server <- function(input, output, session){

#sidepanel의 시간 표시 ---- 
  
  
  output$Time <- renderText({
    paste(input$Time%/%1, "시간", (input$Time%%1 *60)%/%1, "분"
          )
   
    
  })
  
# mainpanel의 농도그래프 ----
  
  
  output$plot <- renderPlot({
    
    zolpidem_labs <- list(
      x = "Time (h)",
      y = "Plasma concentration of zolpidem (ug/L)"
    )
    
    
    zolpidem_rxode2 <- nonmem2rx(
      'ZPD_101101E01_ED.OUT',
      save=FALSE, validate=FALSE, compress=FALSE
    )
    
    zolpidem_dosing <- eventTable(
      amount.units="mg", 
      time.units="hr"
    ) |> 
      add.dosing(dose=as.double(input$Dose)*10, nbr.doses=1)
    
      
    rxSolve(zolpidem_rxode2, zolpidem_dosing, nSub = as.double(input$Simulation)) |> 
      select(sim.id, time, ipred) |> 
      ggplot(aes(x = time, y = ipred, group = sim.id, color = sim.id)) + geom_line() + 
      labs(x = zolpidem_labs$x,
           y = zolpidem_labs$y
      )
    
  })
  
# mainpanel의 parameter 평균값 ----  
  output$parametertable <- renderTable({
    
    
    
    
    
  })
  
# mainpanel의 individual parameter ----  
  output$iparametertable <- renderTable({
    
    zolpidem_labs <- list(
      x = "Time (h)",
      y = "Plasma concentration of zolpidem (ug/L)"
    )
    
    
    zolpidem_rxode2 <- nonmem2rx(
      'ZPD_101101E01_ED.OUT',
      save=FALSE, validate=FALSE, compress=FALSE
    )
    
    zolpidem_dosing <- eventTable(
      amount.units="mg", 
      time.units="hr"
    ) |> 
      add.dosing(dose=as.double(input$Dose)*10, nbr.doses=1)
    
    
    rxSolve(zolpidem_rxode2, zolpidem_dosing, nSub = as.double(input$Simulation)) |> 
      select(sim.id, ka, vc, cl, rxalag.rxddta1., k ,scale2) |> 
      distinct(sim.id, ka, vc, cl, rxalag.rxddta1., k ,scale2)

  

  }, options = list(pageLength = 10))
}
  
shinyApp(ui, server)
