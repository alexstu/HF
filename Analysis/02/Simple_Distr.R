####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################

#files <- system('ls *tsv', intern=T)
files <- system('ls Catwise/*tsv', intern=T)

info = file.info(files)
empty = rownames(info[info$size == 0, ])
files

for (filename_in in files){
	print(filename_in)
	x <- read.table(filename_in, header = F, stringsAsFactors=F)
	#x <- x[x$hf != 0,]
	names(x) <- c('Aut', 'hf')
	png(paste(strsplit(filename_in, '.tsv')[[1]][1] , '.png', sep = ''))
#	ggplot(data=x, aes(x$hf)) + geom_histogram(color="black", fill="white", bins=(max(x$hf - min(x$hf))))
	hist(x$hf)
	dev.off()
}


