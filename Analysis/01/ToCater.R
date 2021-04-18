####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
hash <- read.table('c_a_one.txt', header = F, stringsAsFactors=F, sep='\t')

cats <- unique(hash[,2])

write.table(as.data.frame(cats), 'cats.txt', quote=F, row.names=T, col.names=F, sep='\t')

files <- system('ls *tsv', intern=T)
for (i in 1:length(cats)){

	cat <- cats[i]
	aut_filt <- hash[hash[,2] == cat, 1]	

	for (filename_in in files){

		print(paste(cat, filename_in))
		x <- read.table(filename_in, header = F, stringsAsFactors=F)
		names(x) <- c('Aut', 'hf')

		xx <- x[intersect(x[,1], aut_filt),]

		filename_out <- paste('cat_', as.character(i), '_', filename_in, sep='')
		write.table(xx, filename_out, quote=F, row.names=F, col.names=F, sep='\t')

		png(paste(strsplit(filename_out, '.tsv')[[1]][1] , '.png', sep = ''))
		hist(xx$hf)
		dev.off()
	}
}


