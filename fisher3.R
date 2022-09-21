#!/usr/bin/env Rscript

##Author: German Matias Traglia, Ph.D
##Address: Departamento de Desarrollo Biotecnológico, Instituto de Higiene, Facultad de Medicina, Universidad de La República, Montevideo, Uruguay 
##Description: Performs the Fisher test from an MxN matrix with the following columns: “Type Functional Term [for example: GO]”; "term number"; "cond1_Presence"; “cond2_Presence_Term”; "cond1_Absence_Term"; “cond2_Absense_Term".
##Usage: Rscript fisher3.R [matrix file]

args = commandArgs(trailingOnly=TRUE)  ## Matrix file. For example "matrix_pa_fisher_clin1_v_clin2.txt"

if(!require(psych)){install.packages("psych")}

multiFisher = function(file= args, saveit=TRUE, 
                       outfile="table_fisher.csv", progress=T,
                       verbose=FALSE, digits=3, ... )
  
{

require(psych)

Data = read.table(file, skip=1, header=F,
                  col.names=c("G", "Gene", "MC", "WTC", "MD", "WTD"), ...)

if(verbose){print(str(Data))}

Data$Fisher.p   = NA
Data$phi        = NA
Data$OR1        = format(0.123, nsmall=3)
Data$OR2        = NA

if(progress){cat("\n")}

for(i in 1:length(Data$Gene)){
  
  Matrix = matrix(c(Data$WTC[i],Data$MC[i],Data$WTD[i],Data$MD[i]), nrow=2)
  
  Fisher = fisher.test(Matrix)

  Data$Fisher.p[i] = signif(Fisher$p.value, digits=digits) 

  Data$phi[i] = phi(Matrix, digits=digits)
  
  OR1 = (Data$WTC[i]*Data$MD[i])/(Data$MC[i]*Data$WTD[i])
  OR2 = 1 / OR1
  
  Data$OR1[i] = format(signif(OR1, digits=digits), nsmall=3)
  
  Data$OR2[i] = signif(OR2, digits=digits)
  
  if(progress) {cat(".")}

}  

if(progress){cat("\n"); cat("\n")}

if(saveit){write.csv(Data, outfile)}

return(Data)

}

multiFisher()
