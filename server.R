server <-function(input,output){
  
  # Reactive expression to create data frame of all input values ---
  sliderValues <- reactive({
    data.frame(
      Name = c("K",
               "alpha",
               "power",
               "rho12",
               "rho13",
               "rho23",
               "delta1",
               "delta2",
               "delta3",
               "r"
      ),
      Value = as.character(c(input$K,
                             input$alpha,
                             input$power,
                             input$rho12,
                             input$rho13,
                             input$rho23,
                             input$delta1,
                             input$delta2,
                             input$delta3,
                             input$r)),
      stringsAsFactors = FALSE)
  })
  CKsolution <- function(alpha,power,rho,gamma,K){
    if(det(rho) <= 0){print("no positive definite");break}
    library(mvtnorm)
    a<-rep(1,K)
    
    z_a = qnorm(1-alpha); ndel = 0.001; rn = round(runif(1)*1000);
    
    CK = qmvnorm(power, corr=rho, tail="lower.tail")$quantile
    
    for(j in 1:1000){
      set.seed(rn)
      C1k = CK*gamma + z_a*(a[K]*gamma - a[1:(K-1)])
      pow1 = pmvnorm(lower=rep(-Inf,K), upper=c(C1k,CK), corr=rho)[1]
      G = power - pow1
      if(abs(G) < 0.00001 & G <= 0){break}
      F1k = rep(0,K-1)
      for(l in 1:(K-1)){
        vndel = rep(0,K-1); vndel[l] = ndel
        F1k[l] = pmvnorm(lower=c(rep(-Inf,l-1),C1k[l],rep(-Inf,K-l)),
                         upper=c(C1k+vndel,CK), corr=rho)[1]/ndel }
      FK = pmvnorm(lower=c(rep(-Inf,K-1),CK),upper=c(C1k,CK+ndel),corr=rho)[1]/ndel
      dG = -t(F1k)%*%gamma - FK
      CK = CK - G/dG }
    
    return(c(CK))}
  
  Nsolution<-function(alpha,r,Delta_K,CK){
    z_a = qnorm(1-alpha);
    kappa=r/(1+r)
    N=(z_a+CK)^2/(kappa*Delta_K^2)
    return(N)
  }
  
  
  output$N <- renderText({
    k=input$K
    gamma=c(input$delta1/input$delta2,input$delta2/input$delta3)
    rho<-matrix(c(1,input$rho12,input$rho13,input$rho12,1,input$rho23,input$rho13,input$rho23,1),ncol=k)
    ck<-CKsolution(input$alpha,input$power,rho,gamma,k)
    paste("The sample size of your clinical trail is:",Nsolution(input$alpha,input$r,input$delta3,ck))
  })
  
  # Show the parameter in an HTML table ----
  output$caption <- renderText({
    "Show the parameter of your clinical trail in an HTML table "
  })
  
  output$values <- renderTable({
    sliderValues()
  })
  
  
}