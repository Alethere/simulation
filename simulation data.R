library(PopGenome)
#first we load data from adjacent folder that contains SNPs
simulation <- readData(path = "simulation/",format="Fasta",SNP.DATA = T)
position1 <- unlist(read.table("sweep_posID11.txt")) #associate data with positions
simulation <- set.ref.positions(simulation,list(position1))
#get the range of our data to define sliding windows for the analysis
str(simulation)
get.sum.data(simulation)
range<-.

#definition of sliding windows
sim_sw<- sliding.window.transform(simulation,width=5000,
                                   jump=5000,start.pos = range[1],
                                   end.pos =range[2], type=2,whole.data=TRUE)


sim_sw <- neutrality.stats(sim_sw)
get.neutrality(sim_sw) #see overall sturcture of the computed slots
lapply(get.neutrality(sim_sw),summary) #What does this command do?
#nucleotide diversity 
summary(sim_sw@theta_Tajima)
str(sim_sw@theta_Tajima)
#Watterson estimator
summary(sim_sw@theta_Watterson)

#From PopGenome vignette, extract the regions' coordinates
xaxis2 <- strsplit(sim_sw@region.names,split=" : ")
xaxis2 <- sapply(xaxis2,function(x){as.numeric(strsplit(x,split=" ")[[c(1,1)]])})
data_range <- range(sim_sw@theta_Tajima,na.rm = TRUE)
plot(xaxis2,sim_sw@theta_Tajima[,1],col=c("blue"),type="l",xlab="Simulated data",
     ylab="nucleotide diversity (in 1kb window)",ylim=data_range)

#looks awful...let's smooth the curves (see again PopGenome vignette)

aux2 <- 1:length(sim_sw@region.names) #needed for smoothening
