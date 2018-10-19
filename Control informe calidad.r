source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION LocalHost.R')

# parametros informe de calidad

####################################
####################################
vi   <- "vi201807"                ##
vgr  <- "vgr201807"               ##
pr   <- "pr201807"                ##
tc   <- "tc201807"                ##
p500 <- "p500201807"              ##
p501 <- "p501201807"              ##
                                  ##
mes <- "07"                       ##
año <- "2018"                     ##
año.mes <- "201807"               ##
mes.año <- "072018"               ##
desem.inf <- "01-07-2018"         ##
desem.sup <- "01-08-2018"         ##
vig.desde <- "01-08-2017"         ##-calculo vig desempleo, un mes adelante
vig.hasta <- "01-09-2018"         ##-calculo vig desempleo, un mes adelante
####################################
####################################

source('C:/Users/Public/Documents/INFORME DE CALIDAD/R/generacion datos calidad.R')
source('C:/Users/Public/Documents/INFORME DE CALIDAD/R/control siniestros.R')
source('C:/Users/Public/Documents/INFORME DE CALIDAD/R/movimientos desempleo.R')
source('C:/Users/Public/Documents/INFORME DE CALIDAD/R/vigentes desempleo.R')
   
    cartera.siniestros.mov<-rbind(a1,a2,datos.calidad,nn.vgr,siniestros,mov.desempleo,vig.desem)
  
write.csv(cartera.siniestros.mov,paste("C:/Users/Public/Documents/INFORME DE CALIDAD/SALIDAS/CARTERA.SINIESTROS.MOV",año.mes,".csv"))
write.csv(causas.obj,paste("C:/Users/Public/Documents/INFORME DE CALIDAD/SALIDAS/CAUSAS.OBJ",año.mes,".csv"))
    