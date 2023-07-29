

library(shiny)

## Mastering Shiny 연습문제 풀이 ----

# 1.1.8 ----

# 1
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)


server <- function(input, output, session){
  output$greeting <- renderText({
    paste0("Hello ", input$name)
  })
  
}


shinyApp(ui, server)

# 2 

# server 부분에 x 대신에 input$x으로 표현 



# 3 

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "and y is", min = 1, max = 50, value = 5),
  "then x times 5 is", "and y is", 
  textOutput("product")
)

server <- function(input, output, session) {
  output$product <- renderText({ 
    (input$x * 5)*input$y
  })
}

shinyApp(ui, server)


# 4 


ui <- fluidPage( "KING",
  sliderInput("x", "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)




server <- function(input, output, session) {
  
  product <- reactive({
    input$x*input$y
  })
  output$product <- renderText({ 
    input$product
  })
  output$product_plus5 <- renderText({ 
    input$product + 5
  })
  output$product_plus10 <- renderText({ 
    input$product + 10
  })
}

shinyApp(ui, server)



## 2.2.8 ----

library(shiny)

# 1
ui <- fluidPage(
  textInput("names", "What is your names", 
            placeholder = "Your names"),
  textOutput("outcome")
)

server <- function(input,output, session){
  output$outcome <- renderText({
    paste("Hello my friends, my name is", input$names)
  })
  
}
shinyApp(ui, server)


# 2 

library(lubridate)

ui <- fluidPage(
  sliderInput("Time", "When should we deliver", min = as.Date("2020-09-16"),
              max = as.Date("2020-09-23"), value =as.Date("2020-09-17"),
),
  textOutput("Now")
)

server <- function(input, output, session){
  output$Now <- renderText({
    input$Time
  })
}
shinyApp(ui,server)

?as_datetime
?cat



# 2.3.5 ----

# 2 



ui <- fluidPage(
  plotOutput("plot", height = "400px", width = "700px", alt = "scatter plot")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}
shinyApp(ui, server)


# 3 


# 3.3.6 ----

# 1 

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server1 <- function(input, output, server) {
  output$greeting <- renderText({
    paste0("Hello ", input$name)
})
}

server2 <- function(input, output, server) {
  greeting <-reactive(paste0("Hello ", input$name))
  output$greeting <-renderText(greeting())
}

server3 <- function(input, output, server) {
  output$greeting <- renderText({
    paste0("Hello", input$name)
})
}

shinyApp(ui,server3)

# 3

#이름으로 var, range등을 사용하지 않는걸로 




# 6.2.4 ----


# 1

ui <- fluidPage(
  titlePanel("I hate Shiny"),
  sidebarLayout(
    sidebarPanel(
      textInput("name", "Tell me your name")
      ),
      mainPanel(
        textOutput("greeting")
      )
    )
  )
  
server <- function(input, output, session){
  output$greeting <- renderText({
    paste("My",input$name, "is piece of shit")
  })
  
  
}

shinyApp(ui, server)


# 3

ui <- fluidPage(
  titlePanel("My plot is piece of crap"),
  fluidRow(
    column(6,
           plotOutput("A")
    ),
    column(6,
           plotOutput("B")
    )
  ),
  fluidRow(
    column(4,
           sliderInput("N", "What is your number",
                       min = 1, max = 10, value = 5)
    )
  )
  

)

server <- function(input, output, session){
  graph <- reactive({
    
    ggplot(data = rnorm(input$N, mean = 0, sd = 1), aes(x = x)) + geom_bar()
  })
  output$A <- renderPlot(graph)
  output$B <- renderPlot(graph)
  
}
shinyApp(ui,server)


# 6.

ui <- fluidPage(
  titlePanel("Your parents sucks"),
  tabsetPanel(
    tabPanel("Your mama sucks",
             textInput("Your_mama", "I hate your mom"),
             textOutput("MAMA")
             ),
  tabPanel("Your dad sucks",
           textInput("Dad", "I hate your dad"),
           textOutput("DAD")
    
  )
)

)
server <- function(input, output, session){
  
  output$MAMA <- renderText({
    paste("I hate your", input$Your_mama)
  })
  output$DAD <-  renderText({
    paste("I hate your", input$Dad)
  })
  
  
  
}

shinyApp(ui, server)




