####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################

cats <- c(1, 7, 18, 19, 26)
cats_names <- c('Arts','Computer','Mathematics','Medicine','Social')

for (metric in c('1','2','3','4','5','6','7','8','9','10')){
	for (method in c('from', 'to')){
		for (year in c('2005', '2010', '2015')){

			print(paste(metric, method, year))
			pval_mat <- matrix(rep(-1, length(cats)*length(cats)), nrow = length(cats), ncol = length(cats))
			med_mat <- matrix(rep('-1', length(cats)*length(cats)), nrow = length(cats), ncol = length(cats))
			dist_list <- list()

			for (i in 1:length(cats)){

				filename <- paste('data/Catwise/cat_', as.character(cats[i]), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
				x <- read.table(filename, header = F, stringsAsFactors=F)
				dist_list[[cats_names[i]]] <- x[,2]

			}

			for (i in 1:length(cats)){
				for (j in 1:length(cats)){

					if (i == j){
						next
					}


					pval_mat[i,j] <- p.adjust(wilcox.test(dist_list[[i]],dist_list[[j]])$p.value, 'BH', n=length(cats)*(length(cats)-1)/2)
#					pval_mat[i,j] <- ks.test(dist_list[[i]],dist_list[[j]])$p.value
					colnames(pval_mat) <- cats_names
					rownames(pval_mat) <- cats_names
					med_mat[i,j] <- paste(as.character(median(dist_list[[i]])), '/', as.character(median(dist_list[[j]])),   sep='')
					#med_mat[i,j] <- paste(as.character(median(dist_list[[i]])), '/', as.character(mean(dist_list[[j]])),   sep='')
					colnames(med_mat) <- cats_names
					rownames(med_mat) <- cats_names
				}
			}
			pval_filename_out <- paste('data/hf_authors_wilx_', method, '_',year, '_', metric, '.txt', sep='')
#			pval_filename_out <- paste('data/hf_authors_ks_', method, '_',year, '_', metric, '.txt', sep='')
			write.table(pval_mat, pval_filename_out, quote=F, row.names=T, col.names=T, sep='\t')
			med_filename_out <- paste('data/hf_authors_med_', method, '_',year, '_', metric, '.txt', sep='')
			write.table(med_mat, med_filename_out, quote=F, row.names=T, col.names=T, sep='\t')
		}
	}	
}

