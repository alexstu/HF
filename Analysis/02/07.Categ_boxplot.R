####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
library('ggplot2')


metrics <- c('1','2','3','4','5','6','7','8','9','10')


#for (metric in c('5','7','8','9')){


cats <- read.table('data/cats.txt', sep='\t')
for (year in c('2005', '2010', '2015')){
	for (method in c('from', 'to')){
		for (m in 1:length(metrics)){

			metric <- metrics[m]
			print(paste(metric, method, year))
			df <- matrix('-1', ncol = 2, nrow = 0)

			for (cat in 1:27){

				filename_metric <- paste('data/Catwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
				x <- read.table(filename_metric, header = F, stringsAsFactors=F)
				x[,1] <- as.character(cats[cat,2])
				df <- rbind(df, x)
			
			}
			df <- as.data.frame(df)
			colnames(df) <- c('Categ', 'HF')	
			df$HF <- as.numeric(df$HF)

			g <- ggplot(df, aes(x=Categ, y=HF,  color=Categ)) +  geom_boxplot(notch=F)  + theme(, axis.text.x = element_blank()) + labs(title=paste('Method=\"', method, '\"; Year=\"',year, '\"; Metric=\"', metric, '\"', sep=''))
			ggsave(paste('hf_authors_', method, '_',year, '_', metric, '.jpg', sep=''), g, width = 15, height = 6, units = c("in"))
		}
	}
}


