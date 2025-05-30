library(shiny)
library(dplyr)
library(ggplot2)

rows1 = 1:23
col1 = 1:27
x <- rep(rows1, each = 27 )
y <- rep(col1, times = 23)

data<- data.frame(x, y)

data<- data %>% mutate(colors = case_when(x == 1 & y %in% c(8, 9)~'black',
                                          x == 2 & y %in% c(6, 7, 10)~'black',
                                          x == 3 & y %in% c(5, 11, 14, 15) ~'black',
                                          x == 4 & y %in% c(4, 12, 13, 16)~'black',
                                          x == 5 & y %in% c(4, 13, 17, 19, 20)~'black',
                                          x == 6 & y %in% c(4, 14, 17, 21)~'black',
                                          x == 7 & y %in% c(4, 18, 22)~'black',
                                          x == 8 & y %in% c(4, 18, 23)~'black',
                                          x == 9 & y %in% c(2, 3, 4, 18, 24)~'black',
                                          x == 10 & y %in% c(1, 4, 17, 25)~'black',
                                          x == 11 & y %in% c(1, 4, 17, 26)~'black',
                                          x == 12 & y %in% c(1, 4, 15, 16, 27)~'black',
                                          x == 13 & y %in% c(1, 4, 14, 26)~'black',
                                          x == 14 & y %in% c(1, 4, 14, 25)~'black',
                                          x == 15 & y %in% c(2, 3, 4, 14, 24)~'black',
                                          x == 16 & y %in% c(4, 13, 19, 23)~'black',
                                          x == 17 & y %in% c(4, 13, 18, 22)~'black',
                                          x == 18 & y %in% c(4, 13, 17, 18, 21)~'black',
                                          x == 19 & y %in% c(4, 13, 16, 19, 20)~'black',
                                          x == 20 & y %in% c(4, 12, 13, 15)~'black',
                                          x == 21 & y %in% c(5, 11, 14, 15)~'black',
                                          x == 22 & y %in% c(6, 7, 10)~'black',
                                          x == 23 & y %in% c(8, 9)~'black',
                                          x %in% c(4,5) & y == 6~'blue',
                                          x == 5 & y == 7~'blue',
                                          x %in% c(8,9) & y == 7~'red',
                                          x == 9 & y == 8~'red',
                                          x %in% c(14,15) & y == 6~'purple',
                                          x == 15 & y == 7~'purple',
                                          x %in% c(18,19) & y == 7~'blue',
                                          x == 19 & y == 8~'blue',
                                          x %in% c(18,19) & y == 11~'red',
                                          x == 19 & y == 12~'red',
                                          x %in% c(7,8) & y == 11~'pink',
                                          x == 8 & y == 12~'pink',
                                          x %in% c(8, 9) & y == 15~'blue',
                                          x == 9 & y == 16~'blue',
                                          x %in% c(15,16) & y == 16~'red',
                                          x ==16 & y == 17~'red',
                                          x %in% c(8,9) & y == 19~'purple',
                                          x == 9 & y == 20~'purple',
                                          x %in% c(13,14) & y == 20~'pink',
                                          x == 14 &  y == 21~'pink',
                                          x %in% c(10,11) & y == 23~'blue',
                                          x == 11 & y ==24~'blue',
                                          #biały
                                          x %in% c(4,14) & y == 7~'white',
                                          x %in% c(8,18) & y == 8~'white',
                                          x %in% c(7,18) & y == 12~'white',
                                          x == 8 & y ==16~'white',
                                          x == 15 & y ==17~'white',
                                          x == 13 & y ==21~'white',
                                          x == 8 & y ==20~'white',
                                          x ==10 & y ==24~'white',
                                          x %in% c(10, 11, 12, 13, 14) & y %in% c(2, 3)~'brown',
                                          x%in% c(1:9, 15:23) & y == 1~'lightblue',
                                          x%in% c(1:8, 16:23) & y%in% c(2, 3)~'lightblue',
                                          x%in%c(1:3, 21:23) & y%in% c(4, 12, 13)~'lightblue',
                                          x%in%c(1, 2, 22, 23) & y %in%c(5,11, 14, 15)~'lightblue',
                                          x%in%c(1, 23)&y%in%c(6,7, 10)~'lightblue',
                                          x%in%c(1:3, 20:23)& y==16~'lightblue',
                                          x%in%c(1:4, 19:23)&y==17~'lightblue',
                                          x%in%c(1:5, 19:23)&y%in%c(18, 21)~'lightblue',
                                          x%in%c(1:4,20:23)&y %in%c(19, 20)~'lightblue',
                                          x%in%c(1:6, 18:23)&y==22~'lightblue',
                                          x%in%c(1:7, 17:23)&y==23~'lightblue',
                                          x%in%c(1:8, 16:23)&y ==24~'lightblue',
                                          x%in%c(1:9, 15:23)&y==25~'lightblue',
                                          x%in%c(1:10, 14:23)&y==26~'lightblue',
                                          x%in%c(1:11, 13:23)&y==27~'lightblue',
                                          TRUE~'green'
                                          
))

ui <- fluidPage(

    titlePanel(shiny::markdown(
      "**Merry Christmas!!**")),
    
    sidebarLayout(
      sidebarPanel(
        checkboxInput('snow',
                        "Let it snow!!", value = FALSE)
      ),
      mainPanel(
        plotOutput("distPlot", width = 690/1.1, height = 810/1.1)
      )
    )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
  
  plot<- ggplot(data) + geom_tile(aes(x = x, y = y, fill = colors)) +
    scale_fill_manual(values = c('black', 'blue','brown', 'green', 'lightblue', 'pink', 'purple','red', 'white')) +
    theme_void() + theme(legend.position = 'none')
  
  if(input$snow){
    snowy <- data.frame(x = sample(1:23, 200, replace = TRUE),
                        y = sample(1:27, 200, replace = TRUE))
    plot<- plot + geom_point(data = snowy, aes(x = x, y = y), size = 3, color = 'white', alpha = 0.8)
  }
  plot
})
    
}

# Run the application 
shinyApp(ui = ui, server = server)
