require("jsonlite")
require("RCurl")
# Change the USER and PASS below to be your UTEid
df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from titanic where sex is not null and fare>100"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs347_professor', PASS='orcl_professor', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE) ))
df
#summary(df)
#head(df)

ggplot(data = df, mapping = aes(x = as.numeric(as.character(FARE)), fill=SURVIVED)) +
  layer(geom = "histogram",
        stat = "bin",
        stat_params = list(binwidth = 0.1),
        mapping = aes(y = ..count..))

ggplot(data = df, mapping = aes(x = PCLASS)) +
  scale_x_continuous(limit = c(0,3))

require(extrafont)

ggplot(df, aes(SEX, AGE, color=FARE)) +
  geom_boxplot() + geom_jitter()

ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  facet_grid(~SURVIVED, labeller=label_both) +
  labs(title='Titanic') +
  labs(x="Age", y=paste("Fare")) +
  layer(data=df, 
        mapping=aes(x=as.numeric(as.character(AGE)), y=as.numeric(as.character(FARE)), color=SEX), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_continuous() +
  #facet_grid(PCLASS~SURVIVED) +
  labs(title='Titanic') +
  labs(x="SURVIVED", y=paste("FARE")) +
  layer(data=df, 
        mapping=aes(x=SEX, y=as.numeric(as.character(FARE)), color=as.character(SURVIVED)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(), 
        #position=position_identity()
        position=position_jitter(width=0.3, height=0)
  )