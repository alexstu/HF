####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################

metrics <- c('1','2','3','4','5','6','7','8','9')
cats = c(2, 7, 18, 19, 26)

#method <- 'from'
method <- 'to'

for (year in c('2005', '2010', '2015')){
	corr_metric_mat <- matrix(rep(-1, 9*5), nrow = 5, ncol = 9)
	for (m in 1:length(metrics)){
		metric <- metrics[m]

		print(paste(metric, method, year))

		dist_list <- list()
		dist_1 <- vector()
		dist_2 <- vector()
		dist_3 <- vector()
		dist_4 <- vector()
		dist_5 <- vector()

		if_dist_list <- list()
		if_dist_1 <- vector()
		if_dist_2 <- vector()
		if_dist_3 <- vector()
		if_dist_4 <- vector()
		if_dist_5 <- vector()


		for (cat in cats){
			filename_metric <- paste('data/Subcatwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
			x <- read.table(filename_metric, header = F, stringsAsFactors=F)
			rownames(x) <- x[,1]

			filename_if <- paste('data/Subcatwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', '10', '.tsv', sep='')
			y <- read.table(filename_if, header = F, stringsAsFactors=F)
			rownames(y) <- y[,1]


			if ((cat == 2) == T){
				dist_1 <- c(dist_1, x[,2])
				if_dist_1 <- c(if_dist_1, y[,2])
			}
			if ((cat == 7) == T){
				dist_2 <- c(dist_2, x[,2])
				if_dist_2 <- c(if_dist_2, y[,2])
			}
			if ((cat == 18) == T){
				dist_3 <- c(dist_3, x[,2])
				if_dist_3 <- c(if_dist_3, y[,2])
			}
			if ((cat == 19) == T){
				dist_4 <- c(dist_4, x[,2])
				if_dist_4 <- c(if_dist_4, y[,2])
			}
			if ((cat == 26) == T){
				dist_5 <- c(dist_5, x[,2])
				if_dist_5 <- c(if_dist_5, y[,2])
			}

		}
		dist_list[[1]] <- dist_1
		dist_list[[2]] <- dist_2
		dist_list[[3]] <- dist_3
		dist_list[[4]] <- dist_4
		dist_list[[5]] <- dist_5

		if_dist_list[[1]] <- if_dist_1
		if_dist_list[[2]] <- if_dist_2
		if_dist_list[[3]] <- if_dist_3
		if_dist_list[[4]] <- if_dist_4
		if_dist_list[[5]] <- if_dist_5

		for (i in 1:5){
			corr_metric_mat[i,m] <- cor(dist_list[[i]],if_dist_list[[i]], method = 'spearman')
			colnames(corr_metric_mat) <- metrics
			rownames(corr_metric_mat) <- c('Arts and Humanities','Computer Science','Mathematics','Medicine','Social Sciences')
		}
	}
	filename_out <- paste('data/subcatIFCorr/hf_authors_', method, '_',year, '.txt', sep='')
	write.table(corr_metric_mat, filename_out, quote=F, row.names=T, col.names=T, sep='\t')

}

