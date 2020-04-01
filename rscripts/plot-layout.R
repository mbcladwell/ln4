rm(list=ls(all=TRUE))
library(ggplot2)
## https://benfradet.github.io/blog/2014/04/30/Display-legend-outside-plot-R
## Rscript --vanilla plot-layout.R in.txt out.png 96

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) %in% c(0,1,2)) {
  stop("Error: args required: input, output files and format", call.=FALSE)
}

##getwd()
##infile <- "../mydata.txt"
##outfile <- "./out.png"

infile <- args[1]
outfile <- args[2]
format <- args[3]


d <- read.table(file=args[1], sep="\t", header=TRUE)
## d <- read.table( file = infile,   sep = "\t", header=TRUE)
 png(outfile,width=450, height=275)

palette(c("white", "green", "red", "grey", "lightblue"))
par(xpd = T, mar = par()$mar + c(0,0,0,6))

if(format==96){
plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=3, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
legend(13, 3,  c("unknown","positive","negative","blank"), fill=c("white", "green", "red", "grey", "lightblue"))
axis(2, at=1:8, labels=LETTERS[1:8], las=2)
axis(3, at=1:12, labels=1:12, xlab="Column")
mtext("Column", side=3, line=3)
}

if(format==384){
plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=2, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
legend(26, 5,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
axis(2, at=1:16, labels=LETTERS[1:16], las=2)
axis(3, at=1:24, labels=1:24, xlab="Column")
mtext("Column", side=3, line=3)
}
if(format==1536){
plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=1, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
legend(52, 8,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
axis(2, at=1:32, labels=LETTERS[1:32], las=2)
axis(3, at=1:48, labels=1:48, xlab="Column")
mtext("Column", side=3, line=3)
}


par(mar=c(5, 4, 4, 2) + 0.1)
 dev.off()

