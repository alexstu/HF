####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################



f_codes = c(8,18)
p_codes = c(6,10,14,17,24)
l_codes = c(3,16,21)
s_codes = c(2,11,25,26)
a_codes = c(1,4,5,7,9,12,13,15,19,22,23,27)
i_codes = c(20)



#for (metric in c('5','7','8','9')){
for (metric in c('1','2','3','4','5','6','7','8','9','10')){
	for (method in c('from', 'to')){
		for (year in c('2005', '2010', '2015')){
			print(paste(metric, method, year))
			pval_mat <- matrix(rep(-1, 6*6), nrow = 6, ncol = 6)
			med_mat <- matrix(rep('-1', 6*6), nrow = 6, ncol = 6)
			dist_list <- list()
			f_dist <- vector()
			p_dist <- vector()
			l_dist <- vector()
			s_dist <- vector()
			a_dist <- vector()
			i_dist <- vector()
			for (cat in 1:27){
				filename <- paste('data/Catwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
				x <- read.table(filename, header = F, stringsAsFactors=F)

				if ((cat %in% f_codes) == T){
					f_dist <- c(f_dist, x[,2])
				}
				if ((cat %in% p_codes) == T){
					p_dist <- c(p_dist, x[,2])
				}
				if ((cat %in% l_codes) == T){
					l_dist <- c(l_dist, x[,2])
				}
				if ((cat %in% s_codes) == T){
					s_dist <- c(s_dist, x[,2])
				}
				if ((cat %in% a_codes) == T){
					a_dist <- c(a_dist, x[,2])
				}
				if ((cat %in% i_codes) == T){
					i_dist <- c(i_dist, x[,2])
				}
			}
			dist_list[[1]] <- f_dist
			dist_list[[2]] <- p_dist
			dist_list[[3]] <- l_dist
			dist_list[[4]] <- s_dist
			dist_list[[5]] <- a_dist
			dist_list[[6]] <- i_dist
			for (i in 1:6){
				for (j in 1:6){
					if (i == j){
						next
					}
					pval_mat[i,j] <- p.adjust(wilcox.test(dist_list[[i]],dist_list[[j]])$p.value, 'BH', n=15)
#					pval_mat[i,j] <- ks.test(dist_list[[i]],dist_list[[j]])$p.value
					colnames(pval_mat) <- c('Formal','Physical','Life','Social','Applied','Interdisciplinary')
					rownames(pval_mat) <- c('Formal','Physical','Life','Social','Applied','Interdisciplinary')
					med_mat[i,j] <- paste(as.character(median(dist_list[[i]])), '/', as.character(median(dist_list[[j]])),   sep='')
					#med_mat[i,j] <- paste(as.character(median(dist_list[[i]])), '/', as.character(mean(dist_list[[j]])),   sep='')
					colnames(med_mat) <- c('Formal','Physical','Life','Social','Applied','Interdisciplinary')
					rownames(med_mat) <- c('Formal','Physical','Life','Social','Applied','Interdisciplinary')
				}
			}
			pval_filename_out <- paste('data/hf_authors_wilx_', method, '_',year, '_', metric, '.txt', sep='')
#			pval_filename_out <- paste('data/hf_authors_ks_', method, '_',year, '_', metric, '.txt', sep='')
			write.table(pval_mat, pval_filename_out, quote=F, row.names=T, col.names=T, sep='\t')
			med_filename_out <- paste('data/hf_authors_mean_', method, '_',year, '_', metric, '.txt', sep='')
			write.table(med_mat, med_filename_out, quote=F, row.names=T, col.names=T, sep='\t')
		}
	}	
}

