####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################

#files <- system('ls *tsv', intern=T)
files <- system('ls Catwise/*tsv', intern=T)

for (filename_in in files){
	print(filename_in)
	x <- read.table(filename_in, header = F, stringsAsFactors=F)
	names(x) <- c('Aut', 'hf')
	xx <- x[x$hf >= 0.05*max(x$hf),]
	filename_out <- gsub( 'Catwise/', 'Filt/', filename_in)
	write.table(xx, filename_out, quote=F, row.names=F, col.names=F, sep='\t')
	png(paste(strsplit(filename_out, '.tsv')[[1]][1] , '.png', sep = ''))
#	ggplot(data=x, aes(x$hf)) + geom_histogram(color="black", fill="white", bins=(max(x$hf - min(x$hf))))
	hist(xx$hf)
	dev.off()
}


