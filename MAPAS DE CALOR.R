#install.packages('ggplot2')
#install.packages('dplyr')
#install.packages('wesanderson')

library(wesanderson)

source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION LocalHost.R')

calor.VGR<-dbGetQuery(con,
                      "
                      select fecha_estadistica,ramo1_calidad, tipo_exped, sum(conteo_aviso)as avisos,sum(conteo_objetados) as obj
                      from siniestros
                      where ramo1='VGR'
                      group by fecha_estadistica,ramo1_calidad, tipo_exped
                      order by fecha_estadistica,ramo1_calidad, tipo_exped
                      "
)
calor.VGR<-calor.VGR[calor.VGR[,"fecha_estadistica"]>=201701,]
calor.VGR<-calor.VGR[calor.VGR[,"fecha_estadistica"]< 201707,]
calor.VGR<-calor.VGR[calor.VGR[,"tipo_exped"]!='GSJ',]
calor.VGR<-calor.VGR[calor.VGR[,"tipo_exped"]!='GSO',]
calor.VGR<-calor.VGR[calor.VGR[,"tipo_exped"]!='PJS',]
calor.VGR<-calor.VGR[calor.VGR[,"tipo_exped"]!='PID',]
calor.VGR<-calor.VGR[calor.VGR[,"tipo_exped"]!='VUG',]

calor.VGR[calor.VGR[,"tipo_exped"]=='DHH',"tipo_exped"]<-'RENTAS'
calor.VGR[calor.VGR[,"tipo_exped"]=='DIH',"tipo_exped"]<-'RENTAS'
calor.VGR[calor.VGR[,"tipo_exped"]=='DHP',"tipo_exped"]<-'RENTAS'



calor.VGR <- summarise(group_by(calor.VGR,
                                ramo1_calidad,tipo_exped),
                       sum(avisos),sum(obj))

calor.VGR$Porcentaje_Objecion<-((calor.VGR$`sum(obj)`)/(calor.VGR$`sum(avisos)`))*100

calor.VGR$tipo_exped<-factor(calor.VGR$tipo_exped, 
                             levels=c('VGR','ITP','EGR','VMA','RENTAS'))


calor.VGR[calor.VGR[,"Porcentaje_Objecion"]>100,"Porcentaje_Objecion"]<-100
ss


#levels=c('VGR','ITP','EGR','VMA','DIH','DHH','DHP')

aa<-ggplot(calor.VGR, aes(tipo_exped, ramo1_calidad, fill = Porcentaje_Objecion)) + geom_raster()
aa+scale_fill_gradient(low='#ffff00', high = '#Ff0000')
aa<-ggplot(calor.VGR, aes(ramo1_calidad, Porcentaje_Objecion,fill=Porcentaje_Objecion)) + geom_bar(stat = "identity", position = "dodge")
aa + facet_grid(tipo_exped~.)+scale_fill_gradient(low='#ffff00', high = '#Ff0000')
aa +opts()  

aa + labs(x='Linea de producto')

