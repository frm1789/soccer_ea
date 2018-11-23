##******************************************************************************************************
## Creation of heatmap using ggplot 
library(ggplot2)
library(readr)

url_soccer <- 'https://raw.githubusercontent.com/frm1789/soccer_ea/master/Example_Data_format_ggplot_geom_tile.csv'
df_exa <- read_csv(url(url_soccer)

ggplot(data = df_exa, aes(x = df_exa$country, y = df_exa$metric)) +
  geom_tile(aes(fill = df_exa$value)) +
  coord_flip() +
  scale_fill_gradient(low = "#C6DBEF", high = "#08306B") +
  theme_minimal()
##******************************************************************************************************
## Creation of heatmap using heatmap 
url <- 'https://raw.githubusercontent.com/frm1789/soccer_ea/master/Example_Data_Matrix_heatmap.csv'
df_matrix <- read_csv(url(url_soccer))

# Order data for titles
df_matrix <- df_matrix[order(df_matrix$Titles, decreasing = FALSE),]
df_matrix <- data.frame(df_matrix)

#removing names of the teams.
row.names(df_matrix) <- df_matrix$Team
df_matrix <- df_matrix[,-1]

options(digits=2)
df_matrix$Points_1 <- sub(',', '.', df_matrix$Points_1)
df_matrix$Points_1 <- as.double(df_matrix$Points_1)

# transformation to numeric for column "Performance"
df_matrix$Performance = substr(df_matrix$Performance,1,nchar(df_matrix$Performance)-1)
df_matrix$Performance <- sub(',', '.', df_matrix$Performance)
df_matrix$Performance <- as.double(df_matrix$Performance)
df_matrix$Performance <- log(df_matrix$Performance)

small_matrix <- data.matrix(df_matrix)

america_heatmap <- heatmap(small_matrix, Rowv=NA, 
                           Colv=NA, col = brewer.pal(9, "Blues"), scale="column", 
                           margins=c(2,6))