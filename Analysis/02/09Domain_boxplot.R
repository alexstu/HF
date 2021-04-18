####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################

metrics <- c('1','2','3','4','5','6','7','8','9')

f_codes = c(8,18)
p_codes = c(6,10,14,17,24)
l_codes = c(3,16,21)
s_codes = c(2,11,25,26)
a_codes = c(1,4,5,7,9,12,13,15,19,22,23,27)
i_codes = c(20)


method <- 'from'
#method <- 'to'
for (year in c('2005', '2010', '2015')){
	for (m in 1:length(metrics)){
		metric <- metrics[m]

		print(paste(metric, method, year))
		df <- matrix('-1', ncol = 2, nrow = 0)

		for (cat in 1:27){
			filename_metric <- paste('data/Catwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
			x <- read.table(filename_metric, header = F, stringsAsFactors=F)
			rownames(x) <- x[,1]

			x <- read.table(filename_metric, header = F, stringsAsFactors=F)
			df <- rbind(df, x)

		}
		df[df[,1] %in% f_codes,] <- 'Formal'
		df[df[,1] %in% p_codes,] <- 'Physical'
		df[df[,1] %in% l_codes,] <- 'Life'
		df[df[,1] %in% s_codes,] <- 'Social'
		df[df[,1] %in% a_codes,] <- 'Applied'
		df[df[,1] %in% i_codes,] <- 'Interdisciplinary'

	filename_out <- paste('data/domIFCorr/hf_authors_', method, '_',year, '.txt', sep='')
	write.table(corr_metric_mat, filename_out, quote=F, row.names=T, col.names=T, sep='\t')

	}
}
