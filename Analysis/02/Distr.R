####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################

all_tests <- list()
for (method in c('from', 'symmetric', 'to')){
	all_m_tests <- list()
	for (metric in c('5','7','8','9')){
		pval_mat <- matrix(rep(2, 27*27), nrow = 27, ncol = 27)
		for (cat1 in 0:26){
			for (cat2 in 0:26){
				if (cat1 == cat2){
					next
				}
				med_x_vector <- vector()
				med_y_vector <- vector()
				for (year in c('2005', '2010', '2015')){

					filename_1 <- paste('Filt/', as.character(cat1), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
					filename_2 <- paste('Filt/', as.character(cat2), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')

					x <- read.table(filename_1, header = F, stringsAsFactors=F)
					y <- read.table(filename_2, header = F, stringsAsFactors=F)

					med_x <- median(x[,2])
					med_y <- median(y[,2])

					med_x_vector <- c(med_x_vector, med_x)
					med_y_vector <- c(med_y_vector, med_y)
				}
				med_mat <- cbind(med_x_vector, med_y_vector)
				test <- friedman.test(med_mat)
				pval_mat[cat1, cat2] <- test$p.value
			}
		}
		all_m_tests[[metric]] <- pval_mat
	}
		all_tests[[method]] <- all_m_tests
}

