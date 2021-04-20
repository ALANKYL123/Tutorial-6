library(shiny)

ui <- fluidPage(
  titlePanel('Cats or Dogs?'),
  
  sidebarLayout(
    sidebarPanel(
      helpText('Choose cats or dogs.'),
      br(),
    selectInput('select', 'Cats or Dogs?', choices = list('Cat', 'Dog'),
                selected = 'Cat'),
    br(),
    textInput('name', 'Key in your name.', placeholder = 'Enter name...'),
    actionButton('submit', 'Submit')
    ),
    
    mainPanel(textOutput('statement'),
              br(),
              imageOutput('image'))
    
  )
)

server <- function(input,output){
  
  pet <- eventReactive(input$submit, {
    input$select
  })
  
  person <- eventReactive(input$submit, {
    input$name
  })
  
  output$statement <- renderText({
    paste(person(),'likes', tolower(pet()), '.')
  })
  
  image <- eventReactive(input$submit,{
    filename <- normalizePath(file.path('./image',
                                        paste(input$select, '.jpg', sep='')))
    list(src=filename)
  })
  output$image <- renderImage({
    image()
  }, deleteFile = FALSE)
  
}

shinyApp(ui=ui, server=server)