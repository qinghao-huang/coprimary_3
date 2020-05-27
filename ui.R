# Define UI for dataset viewer app ----
library(mvtnorm)
ui <- fluidPage(
  # App title ----
  titlePanel("sample size determination in superiority clinical trail for K=3"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Selector for choosing number of co-primary endpoints----
      numericInput(inputId="K",
                   label="choose number of co-primary endpoinits",
                   value=3,
                   min=2,
                   max=5,
                   step=1),
      
      # Input: Numeric entry for K ---
      numericInput(inputId = "alpha",
                   label = "alpha of the trail",
                   value=0.05,
                   min=0,
                   max=1,
                   step=0.01
      ),
      
      # Input: Numeric entry for power ---
      numericInput(inputId = "power",
                   label = "power of the trail",
                   value=0.2,
                   min=0,
                   max=1,
                   step=0.01
      ),
      
      # Input: Numeric entry for rho ---
      numericInput(inputId = "rho12",
                   label = "The correlation coefficient between index 1 and index 2",
                   value=0.2,
                   min=0,
                   max=1,
                   step=0.001
      ),
      
      # Input: Numeric entry for rho ---
      numericInput(inputId = "rho13",
                   label = "The correlation coefficient between index 1 and index 3",
                   value=0.2,
                   min=0,
                   max=1,
                   step=0.001
      ),
      
      # Input: Numeric entry for rho ---
      numericInput(inputId = "rho23",
                   label = "The correlation coefficient between index 1 and index 2",
                   value=0.2,
                   min=0,
                   max=1,
                   step=0.001
      ),
      # Input: Numeric entry for delta1 ---
      numericInput(inputId = "delta1",
                   label = "delta1",
                   value=0.4,
                   min=0,
                   max=1,
                   step=0.001
      ),
      # Input: Numeric entry for delta2 ---
      numericInput(inputId = "delta2",
                   label = "delta2",
                   value=0.4,
                   min=0,
                   max=1,
                   step=0.001
      ),
      # Input: Numeric entry for delta3 ---
      numericInput(inputId = "delta3",
                   label = "delta3",
                   value=0.4,
                   min=0,
                   max=1,
                   step=0.001
      ),
      
      # Input: Numeric entry for r ---
      numericInput(inputId = "r",
                   label = "n1:n2",
                   value=1,
                   min=0,
                   max=4,
                   step=0.01
      )
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Table summarizing the values entered ----
      h3(textOutput("caption")),
      tableOutput("values"),
      # Output: Verbatim text for sample size N ----
      h3(textOutput("outcom")),
      verbatimTextOutput("N")
    )
  )
)
