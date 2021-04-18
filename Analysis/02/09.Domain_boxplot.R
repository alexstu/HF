####################
#Task: to build distributions
#of all 10 Timur-computed metrics
#for: 1 - autors (in bulk and in categories)
#	2 - categories
####################
library('ggplot2')


metrics <- c('1','2','3','4','5','6','7','8','9','10')
methods <- c('from', 'to')

f_codes = c(8,18)
p_codes = c(6,10,14,17,24)
l_codes = c(3,16,21)
s_codes = c(2,11,25,26)
a_codes = c(1,4,5,7,9,12,13,15,19,22,23,27)
i_codes = c(20)


for (method in methods){

	for (year in c('2005', '2010', '2015')){
		for (m in 1:length(metrics)){
			metric <- metrics[m]

			print(paste(metric, method, year))
			df <- matrix(-1, ncol = 2, nrow = 0)

			for (cat in 1:27){
				filename_metric <- paste('data/Catwise/cat_', as.character(cat), '_hf_authors_', method, '_X', year, '_', metric, '.tsv', sep='')
				x <- read.table(filename_metric, header = F, stringsAsFactors=F)
				x[,1] <- cat

				df <- rbind(df, x)

			}

			df <- as.data.frame(df)
			colnames(df) <- c('Domain', 'HF')	
			df$HF <- as.numeric(df$HF)

			df[df[,1] %in% f_codes,1] <- 'Formal'
			df[df[,1] %in% p_codes,1] <- 'Physical'
			df[df[,1] %in% l_codes,1] <- 'Life'
			df[df[,1] %in% s_codes,1] <- 'Social'
			df[df[,1] %in% a_codes,1] <- 'Applied'
			df[df[,1] %in% i_codes,1] <- 'Interdisciplinary'


			g <- ggplot(df, aes(x=Domain, y=HF,  color=Domain)) +  geom_boxplot(notch=F)  + theme(, axis.text.x = element_blank()) + labs(title=paste('Method=\"', method, '\"; Year=\"',year, '\"; Metric=\"', metric, '\"', sep=''))
			ggsave(paste('hf_authors_', method, '_',year, '_', metric, '.jpg', sep=''), g, width = 15, height = 6, units = c("in"))


		}
	}
}

