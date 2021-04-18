####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
args = commandArgs(trailingOnly=TRUE)
#all_files <- c('hf_authors_from.tsv', 'hf_authors_symmetric.tsv', 'hf_authors_to.tsv', 'hf_categs_from.tsv', 'hf_categs_symmetric.tsv', 'hf_categs_to.tsv')
filename_in <- args[1]
print(args)

x <- read.table(paste('all/trajectories/', filename_in, sep=''), stringsAsFactors = F, sep='\t', header=T)
print(dim(x))

for (year in 9:11){
	filt_x <- x[x[,year] != '', c(1,year)]
	print(dim(filt_x))
	#print(head(filt_x))
	for (i in 1:10){
		filename_out <- paste('data/', strsplit(filename_in, '.tsv')[[1]][1], '_', colnames(filt_x)[2], '_', as.character(i), '.tsv', sep='')
		metric <- unlist(lapply(filt_x[,2], qqq <- function(ppp){strsplit(ppp, ',')[[1]][i]}))
		metric <- gsub("[^0-9\\.]", "", metric) 
		metric <- as.data.frame(metric)
		metric <- cbind((filt_x[,1]), metric)
		write.table(metric, filename_out, quote=F, row.names=F, col.names=F, sep='\t')

		png(paste(strsplit(filename_out, '.tsv')[[1]][1] , '.png', sep = ''))
		hist(xx$hf)
		dev.off()

	}
}



