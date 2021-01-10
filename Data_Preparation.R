#######################################################################
##  Made by: Dr. Keungoui Kim
##  Title: Visualization of Science Evolution
##  goal: 
##  Data set: Web of Science
##  Time Span: 
##  Variables
##      Input: 
##      Output:  
##  Methodology: 
##  Time-stamp: :  
##  Notice :

library('rsconnect')

rsconnect::setAccountInfo(name='awekim',
                          token='AB3E9918B80D87D980AFFECC873B25A4',
                          secret='KGyg7iQgNj+IoO/Hv3D38Iw8VUNHpvTnraL/wbTE')
deployApp()

load(file="../../[KIM_research]/12_WoS_NLP/WoS_NLP_R/R file/interd.set.RData")

interd.set.shiny <- interd.set %>% dplyr::select(pubid, pubyear, source, Science, subheading) %>% unique
save(interd.set.shiny, file="interd.set.shiny.RData")
rm(interd.set, interd.set.shiny)
