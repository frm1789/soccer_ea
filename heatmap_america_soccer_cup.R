library(readr)
library(RColorBrewer)

# get data 
url_soccer <- 'https://raw.githubusercontent.com/frm1789/soccer_ea/master/AmericaCupData.csv'
df_soccer <- read_csv(url(url_soccer))

# Order data for titles
df_soccer <- df_soccer[order(df_soccer$Titles, decreasing = FALSE),]
df_soccer <- data.frame(df_soccer)

# heatmap requieres a numerical matrix, for that reason we will move the names of the team as row.names 
# and after that, we will delete the column "Team"
row.names(df_soccer) <- df_soccer$Team
df_soccer <- df_soccer[,-1]

# transformation to numeric for column "Points_1"
options(digits=2)
df_soccer$Points_1 <- sub(',', '.', df_soccer$Points_1)
df_soccer$Points_1 <- as.double(df_soccer$Points_1)

# transformation to numeric for column "Performance"
df_soccer$Performance = substr(df_soccer$Performance,1,nchar(df_soccer$Performance)-1)
df_soccer$Performance <- sub(',', '.', df_soccer$Performance)
df_soccer$Performance <- as.double(df_soccer$Performance)
df_soccer$Performance <- log(df_soccer$Performance)

# Dataframe to matrix
america_matrix <- data.matrix(df_soccer)

# Creation of heatmap
america_heatmap <- heatmap(america_matrix, Rowv=NA, 
                           Colv=NA, col = brewer.pal(9, "Blues"), scale="column", 
                           margins=c(2,6))
 