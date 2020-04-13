rm(list=ls(all=TRUE))

## https://benfradet.github.io/blog/2014/04/30/Display-legend-outside-plot-R
## Rscript --vanilla plot-layout.R in.txt out.png 96

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) %in% c(0,1,2,3)) {
  stop("Error: args required: input, three output files and format", call.=FALSE)
}

getwd()
infile <- "../tmp/ar-8222479441190188284525.txt"
infile2 <- "../tmp/ar2-7764507602467792171973.txt"
response <- 1
algorithm <- 3

outfile <- "./out.png"
 d <- read.table( file = infile,   sep = "\t", header=TRUE)
 d2 <- read.table( file = infile2,   sep = "\t", header=TRUE, row.names=NULL)


## infile <- args[1]
## infile2 <- args[2]
## response <- args[3]
## algorithm <- args[4]
## d <- read.table(file=args[1], sep="\t", header=TRUE)
## d2 <- read.table(file=args[2], sep="\t", header=TRUE, row.names=NULL)


## 0 raw
## 1 norm
## 2 norm_pos
## 3 p_enhanced

## Algorithm
## 1  mean-pos
## 2  mean-neg-2-sd
## 3  mean-neg-3-sd


palette(c("white", "green", "red", "grey"))
par(xpd = T, mar = par()$mar + c(0,0,0,6))

if(response==1){

    png(spl.outfile,width=450, height=275)
    par(xpd = T, mar = par()$mar + c(0,0,0,6))

    plot(d$response, d$well,  cex=3, pch=22, col="black", bg=d$plate.order, ylab="Background Subtracted", xlab="Index")
    legend(13, 3,  c("unknown","positive","negative","blank"), fill=c("white", "green", "red", "grey"))

    dev.off()

    palette(c("black","white","blue","lightblue"))
    png(spl.rep.out, width=450, height=275)
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=3, pch=22, col="black", bg=d$replicates, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(13, 3,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:8, labels=LETTERS[1:8], las=2)
    axis(3, at=1:12, labels=1:12, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()

    png(trg.rep.out, width=450, height=275)
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=3, pch=22, col="black", bg=d$targets, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(13, 3,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:8, labels=LETTERS[1:8], las=2)
    axis(3, at=1:12, labels=1:12, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()

}



if(format==384){

    png(spl.outfile, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=2, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(26, 5,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:16, labels=LETTERS[1:16], las=2)
    axis(3, at=1:24, labels=1:24, xlab="Column")
    mtext("Column", side=3, line=3)
       dev.off()

    palette(c("black","white","blue","lightblue"))
    png(spl.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=2, pch=22, col="white", bg=d$replicates, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(26, 5,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:16, labels=LETTERS[1:16], las=2)
    axis(3, at=1:24, labels=1:24, xlab="Column")
    mtext("Column", side=3, line=3)
    dev.off()

    png(trg.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=2, pch=22, col="white", bg=d$targets, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(26, 5,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:16, labels=LETTERS[1:16], las=2)
    axis(3, at=1:24, labels=1:24, xlab="Column")
    mtext("Column", side=3, line=3)
       dev.off()

}




if(format==1536){

    
    png(spl.outfile, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=1, pch=22, col="black", bg=d$type, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(52, 8,  c("unknown","positive","negative","blank","edge"), fill=c("white", "green", "red", "grey", "lightblue"))
    axis(2, at=1:32, labels=LETTERS[1:32], las=2)
    axis(3, at=1:48, labels=1:48, xlab="Column")
    mtext("Column", side=3, line=3)
   dev.off()

    png(spl.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
    palette(c("black","white","blue","lightblue"))
        plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=1, pch=22, col="white", bg=d$replicates, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(52, 8, c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:32, labels=LETTERS[1:32], las=2)
    axis(3, at=1:48, labels=1:48, xlab="Column")
    mtext("Column", side=3, line=3)
   dev.off()

    png(trg.rep.out, width=450, height=275)  
    par(xpd = T, mar = par()$mar + c(0,0,0,6))
        plot(d$col, d$row.num, ylim = rev(range(d$row.num)), cex=1, pch=22, col="white", bg=d$targets, ylab="Row", xaxt='n',yaxt='n', xlab="")
    legend(52, 8,  c("replicate 1","replicate 2","replicate 3","replicate 4"), fill=c("black", "white","blue","lightblue"))
    axis(2, at=1:32, labels=LETTERS[1:32], las=2)
    axis(3, at=1:48, labels=1:48, xlab="Column")
    mtext("Column", side=3, line=3)
   dev.off()


}


par(mar=c(5, 4, 4, 2) + 0.1)
 

