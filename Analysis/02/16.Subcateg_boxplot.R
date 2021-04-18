####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
library('ggplot2')


metrics <- c('1','2','3','4','5','6','7','8','9','10')


#for (metric in c('5','7','8','9')){


subcats <- read.table('data/subcats.txt', sep='\t')
for (year in c('2005', '2010', '2015')){
	for (method in c('from', 'to')){
		for (m in 1:length(metrics)){

			metric <- metrics[m]
			print(paste(metric, method, year))
			df <- matrix('-1', ncol = 2, nrow = 0)

			for (subcat in 1:296){

				filename_metric <- paste('data/Subcatwise/subcat_', as.character(subcat), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
				if (file.size(filename_metric) == 0){
					next
				}
				x <- read.table(filename_metric, header = F, stringsAsFactors=F)
				#x[,1] <- as.character(subcats[subcat,2])
				x[,1] <- as.character(subcat)
				df <- rbind(df, x)

			}
			df <- as.data.frame(df)
			colnames(df) <- c('Subcateg', 'HF')	
			df$HF <- as.numeric(df$HF)

			#g <- ggplot(df, aes(x=Subcateg, y=HF,  color=Subcateg)) +  geom_boxplot(notch=F)  + theme(, axis.text.x = element_blank()) + labs(title=paste('Method=\"', method, '\"; Year=\"',year, '\"; Metric=\"', metric, '\"', sep=''))
						g <- ggplot(df, aes(x=Subcateg, y=HF,  color=Subcateg)) +  geom_boxplot(notch=F)  + theme(legend.position="none") + labs(title=paste('Method=\"', method, '\"; Year=\"',year, '\"; Metric=\"', metric, '\"', sep=''))
			ggsave(paste('hf_authors_', method, '_',year, '_', metric, '.jpg', sep=''), g, width = 40, height = 10, units = c("in"))
		}
	}
}


