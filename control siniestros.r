#-- cuenta de siniestros avisados

avisos<-dbGetQuery(con,paste(
           "
           SELECT FECHA_ESTADISTICA, RAMO1, RAMO1_CALIDAD, SUM(CONTEO_AVISO)
           FROM SINIESTROS
           WHERE FECHA_ESTADISTICA=",año.mes,"
           GROUP BY FECHA_ESTADISTICA, RAMO1, RAMO1_CALIDAD
           ORDER BY RAMO1, RAMO1_CALIDAD,FECHA_ESTADISTICA
           "))


#-- cuenta de los siniestros pagados


pagados<-dbGetQuery(con,paste(           "

with a as (
           select RAMO1_CALIDAD, no_siniestro, fecha_estadistica, sum(vr_liquidado)
           from siniestros
           group by RAMO1_CALIDAD, no_siniestro, fecha_estadistica
           having sum(vr_liquidado)>0
),
           
           b as(
           select RAMO1_CALIDAD, no_siniestro, min(fecha_estadistica) as primer_pago, sum(sum) as LIQ
           from  a
           group by RAMO1_CALIDAD,no_siniestro
           )
           
           
           select RAMO1_CALIDAD, primer_pago, count(primer_pago)
           from b
           where primer_pago=",año.mes,"
           group by RAMO1_CALIDAD, primer_pago
           order by RAMO1_CALIDAD, primer_pago
           "))



#-- cuenta siniestros objetados


objetados<-dbGetQuery(con,paste(
           "
           SELECT FECHA_ESTADISTICA, RAMO1_CALIDAD ,SUM(CONTEO_OBJETADOS)
           FROM SINIESTROS
           WHERE FECHA_ESTADISTICA=",año.mes,"
           GROUP BY FECHA_ESTADISTICA, RAMO1_CALIDAD
           ORDER BY RAMO1_CALIDAD,FECHA_ESTADISTICA
           "
           ))



#-- CUENTA SINIESTROS PENDIENTES


pendientes<-dbGetQuery(con,paste(
           "
           SELECT FECHA_ESTADISTICA, RAMO1_CALIDAD, ESTADO_SINIES, COUNT(ESTADO_SINIES)
           FROM SINIESTROS
           WHERE ESTADO_SINIES = 'P' AND FECHA_ESTADISTICA=",año.mes,"
           GROUP BY FECHA_ESTADISTICA, RAMO1_CALIDAD,ESTADO_SINIES
           "))


#-- CAUSALES DE OBJECION 

causas.obj<-dbGetQuery(con,paste(
           "
           SELECT FECHA_ESTADISTICA, RAMO1_CALIDAD, COD_OBJECION,NOMBRE_OBJECION, SUM(CONTEO_OBJETADOS)
           FROM SINIESTROS
           WHERE COD_OBJECION <> 'N/D' AND FECHA_ESTADISTICA=",año.mes,"
           GROUP BY FECHA_ESTADISTICA, RAMO1_CALIDAD, COD_OBJECION,NOMBRE_OBJECION
           ORDER BY RAMO1_CALIDAD, FECHA_ESTADISTICA,NOMBRE_OBJECION
           "))


avisos<-merge('avisos',avisos[,3:4])
names(avisos)<-c('a','b','c')

objetados<-merge('obj',objetados[,2:3])
names(objetados)<-c('a','b','c')

pagados<-merge('pagados',pagados[,c(1,3)])
names(pagados)<-c('a','b','c')

pendientes<-merge('pend',pendientes[,c(2,4)])
names(pendientes)<-c('a','b','c')

siniestros<-rbind(avisos,objetados,pagados,pendientes)
