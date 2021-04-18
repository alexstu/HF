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



#for (metric in c('5','7','8','9')){
method <- 'from'
for (year in c('2005', '2010', '2015')){
	corr_metric_mat <- matrix(rep(-1, 9*6), nrow = 6, ncol = 9)
	for (m in 1:length(metrics)){
		metric <- metrics[m]

		print(paste(metric, method, year))

		dist_list <- list()
		f_dist <- vector()
		p_dist <- vector()
		l_dist <- vector()
		s_dist <- vector()
		a_dist <- vector()
		i_dist <- vector()

		if_dist_list <- list()
		if_f_dist <- vector()
		if_p_dist <- vector()
		if_l_dist <- vector()
		if_s_dist <- vector()
		if_a_dist <- vector()
		if_i_dist <- vector()


		for (cat in 1:27){
			filename_metric <- paste('data/Catwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
			x <- read.table(filename_metric, header = F, stringsAsFactors=F)
			rownames(x) <- x[,1]

			filename_if <- paste('data/Catwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', '10', '.tsv', sep='')
			y <- read.table(filename_if, header = F, stringsAsFactors=F)
			rownames(y) <- y[,1]

			int <- intersect(x[,1], y[,1])
			x <- x[int,]
			y <- y[int,]

			if ((cat %in% f_codes) == T){
				f_dist <- c(f_dist, x[,2])
				if_f_dist <- c(if_f_dist, y[,2])
			}
			if ((cat %in% p_codes) == T){
				p_dist <- c(p_dist, x[,2])
				if_p_dist <- c(if_p_dist, y[,2])
			}
			if ((cat %in% l_codes) == T){
				l_dist <- c(l_dist, x[,2])
				if_l_dist <- c(if_l_dist, y[,2])
			}
			if ((cat %in% s_codes) == T){
				s_dist <- c(s_dist, x[,2])
				if_s_dist <- c(if_s_dist, y[,2])
			}
			if ((cat %in% a_codes) == T){
				a_dist <- c(a_dist, x[,2])
				if_a_dist <- c(if_a_dist, y[,2])
			}
			if ((cat %in% i_codes) == T){
				i_dist <- c(i_dist, x[,2])
				if_i_dist <- c(if_i_dist, y[,2])
			}
		}
		dist_list[[1]] <- f_dist
		dist_list[[2]] <- p_dist
		dist_list[[3]] <- l_dist
		dist_list[[4]] <- s_dist
		dist_list[[5]] <- a_dist
		dist_list[[6]] <- i_dist

		if_dist_list[[1]] <- if_f_dist
		if_dist_list[[2]] <- if_p_dist
		if_dist_list[[3]] <- if_l_dist
		if_dist_list[[4]] <- if_s_dist
		if_dist_list[[5]] <- if_a_dist
		if_dist_list[[6]] <- if_i_dist

		for (i in 1:6){
			corr_metric_mat[i,m] <- cor(dist_list[[i]],if_dist_list[[i]], method = 'spearman')
			colnames(corr_metric_mat) <- metrics
			rownames(corr_metric_mat) <- c('Formal','Physical','Life','Social','Applied','Interdisciplinary')
		}
	}
	filename_out <- paste('data/domIFCorr/hf_authors_', method, '_',year, '.txt', sep='')
	write.table(corr_metric_mat, filename_out, quote=F, row.names=T, col.names=T, sep='\t')

}

