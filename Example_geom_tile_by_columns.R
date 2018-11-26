library(plyr)
library(reshape)
library(ggplot2)
library(scales)

url_soccer <- 'https://raw.githubusercontent.com/frm1789/soccer_ea/master/AmericaCupData_small.csv'
df_soccer <- read_csv(url_soccer)

# Everything to numeric
options(digits=2)
df_soccer$Points_1 <- sub(',', '.', df_soccer$Points_1)
df_soccer$Points_1 <- as.double(df_soccer$Points_1)
df_soccer$Performance = substr(df_soccer$Performance,1,nchar(df_soccer$Performance)-1)
df_soccer$Performance <- sub(',', '.', df_soccer$Performance)
df_soccer$Performance <- as.double(df_soccer$Performance)
df_soccer$Performance <- log(df_soccer$Performance)


# Reshape for geom_tile format
df_soccer <- reshape2:::melt.data.frame(df_soccer) 
tableau.m <- ddply(df_soccer, .(variable), transform, rescale = rescale(value))

# Maintain the order
tableau.m$Team <- factor(tableau.m$Team, c("Brasil", "Argentina", "Uruguay"))
tableau.m$variable <- factor(tableau.m$variable, c("Titles", "Match", "Points", "Points_1", "Performance"))

# Plot the visualization
ggplot(tableau.m, aes(variable, Team, fill = rescale)) + 
  geom_tile(show.legend = FALSE) + 
  scale_fill_gradient(low = "white", high = "steelblue") +
  theme_minimal()
