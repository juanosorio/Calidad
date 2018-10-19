    #-- VIGENTES VI

vig.vi<-dbGetQuery(con,
paste(
    "
    select count (poliza)
    from ",vi,"
    where ramo <> 759"))

vig.vi.asistencia<-dbGetQuery(con,
                   paste(
                     "
                     select count (poliza)
                     from ",vi,"
                     where ramo = 940 or ramo=942 or ramo=946"))
    
    #-- NUEVOS NEGOCIOS VI
nn.vi<-dbGetQuery(con,
             paste(    
    "SELECT count(*)
    FROM ",vi,"
    -- LIMIT 10
    WHERE NUMANU=1 AND substring(fecini from 5 for 2)='",mes,"' and ramo <> 759",sep=""))
    
    
    
    #-- RENOVACIONES VI
    r.vi<-dbGetQuery(con,
                 paste(    
    "SELECT count(*)
    FROM ",vi,"
    -- LIMIT 10
    WHERE NUMANU<>1 AND substring(fecini from 5 for 2)='",mes,"' and ramo <> 759",sep=""))
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    #-- VIGENTES VP
       vig.vp <- dbGetQuery(con,paste(    
    "select count (*)
    from ",vi,"
    where ramo = 759"),sep="")
    
    #-- NUEVOS NEGOCIOS VP
    
   nn.vp <-dbGetQuery(con,
                 paste(
    "SELECT COUNT(*)
    FROM ",vi,"
    -- LIMIT 10
    WHERE NUMANU=1 AND substring(fecini from 1 for 6)='",año.mes,"' and ramo = 759",sep=""))
    
    #-- RENOVACIONES VP
    
   r.vp <-dbGetQuery(con,
                 paste(
    "SELECT COUNT(*)
    FROM ",vi,"
    WHERE NUMANU<>1 AND substring(fecini from 1 for 6)='",año.mes,"' and ramo = 759",sep=""))

    
    
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    #-- VIGENTES VGR
    vig.vgr<-dbGetQuery(con,
                 paste(
    "select LINEANEG, count(*)
    from ",vgr,"
    GROUP BY LINEANEG",sep=""))
    
    
    #-- NUEVOS NEGOCIOS VGR
    
    nn.vgr<-dbGetQuery(con,
                 paste(
    "SELECT LINEANEG, COUNT(*)
    FROM ",vgr,"
    WHERE ALTURA=1 AND substring(FECVIGDE from 3 for 2)='",mes,"'
    GROUP BY LINEANEG",sep=""))
    
    #-- RENOVACIONES VGR
    
    r.vgr<-dbGetQuery(con,
                 paste(
    "SELECT LINEANEG, COUNT(*)
    FROM ",vgr,"
    WHERE ALTURA<>1 AND substring(FECVIGDE from 3 for 2)='",mes,"' 
    GROUP BY LINEANEG",sep=""))
    
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    #-- VIGENTES DEUDORES
    
    vig.pr<-dbGetQuery(con,
                 paste("
    select count(NUMERO_CREDITO)
    from ",pr))
    

    vig.tc<-dbGetQuery(con,
             paste(
    "SELECT COUNT(NUMERO_CREDITO)
    FROM ",tc))
    
    vig.deu<-vig.pr+vig.tc
    
    #--#
    #--# SUMAR
    #--#
    
    #-- NUEVOS NEGOCIOS DEUDORES
       nn.pr <-dbGetQuery(con,
                     paste(
    "SELECT count(NUMERO_CREDITO)
    FROM ",pr,"
    WHERE SUBSTRING(FECHA_INGRESO FROM 3 FOR 6)='",mes.año,"'",sep=""))

nn.tc<-dbGetQuery(con,
             paste(
    "SELECT COUNT(NUMERO_CREDITO)
    FROM ",tc,"
    WHERE SUBSTRING(FECHA_INGRESO FROM 3 FOR 6)='",mes.año,"'",sep=""))
    
    #--#
    #--# SUMAR
    #--#
nn.deu<-nn.pr+nn.tc

    
    #-- RENOVACIONES DEUDORES
       r.pr <-dbGetQuery(con,
                     paste(
    "SELECT count(NUMERO_CREDITO)
    FROM ",pr,"
    WHERE SUBSTRING(FECHA_INGRESO FROM 3 FOR 2)='",mes,"' AND SUBSTRING(FECHA_INGRESO FROM 5 FOR 4)<>'",año,"'",sep=""))
    
   
r.tc<-dbGetQuery(con,
             paste(
    "SELECT COUNT(NUMERO_CREDITO)
    FROM ",tc,"
    WHERE SUBSTRING(FECHA_INGRESO FROM 3 FOR 2)='",mes,"' AND SUBSTRING(FECHA_INGRESO FROM 5 FOR 4)<>'",año,"'",sep=""))
    
    #--#
    #--# SUMAR
    #--#
r.deu<-r.pr+r.tc

    
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    #-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    #-- VIGENTES DESEMPLEO
    
    
    
    
    #-- NUEVOS NEGOCIOS DESEMPLEO
    nn.500<-dbGetQuery(con,
                 paste(
    "SELECT COUNT(*)
    FROM ",p500,"
    WHERE 
    SUBSTRING(TIPO_END FROM 7 FOR 2) = '  ' AND
    (NUMERO_POLIZA-FLOOR(NUMERO_POLIZA/100)*100)=1 AND
    (FECHA_EQUIPO < '",desem.sup,"' AND FECHA_EQUIPO >= '",desem.inf,"')",sep=""))
    
    nn.501<-dbGetQuery(con,
                 paste(
    "SELECT COUNT(*)
    FROM ",p501,"
    WHERE 
    SUBSTRING(TIPO_END FROM 7 FOR 2) = '  ' AND
    (NUMERO_POLIZA-FLOOR(NUMERO_POLIZA/100)*100)=1 AND
    (FECHA_EQUIPO < '",desem.sup,"' AND FECHA_EQUIPO >= '",desem.inf,"')",sep=""))
 
    nn.des<-nn.500+nn.501
    
    
    #-- RENOVACIONES DESEMPLEO
    
    r.500<-dbGetQuery(con,
                 paste(
    "SELECT COUNT(*)
    FROM ",p500,"
    WHERE 
    SUBSTRING(TIPO_END FROM 7 FOR 2) = '  ' AND
    (NUMERO_POLIZA-FLOOR(NUMERO_POLIZA/100)*100)>1 AND
    (FECHA_EQUIPO < '",desem.sup,"' AND FECHA_EQUIPO >= '",desem.inf,"') ",sep="" ))
    
    r.501<-dbGetQuery(con,
                 paste(
    "SELECT COUNT(*)
    FROM ",p501,"
    WHERE 
    SUBSTRING(TIPO_END FROM 7 FOR 2) = '  ' AND
    (NUMERO_POLIZA-FLOOR(NUMERO_POLIZA/100)*100)>1 AND
    (FECHA_EQUIPO < '",desem.sup,"' AND FECHA_EQUIPO >= '",desem.inf,"')",sep=""))
    
    r.des<-r.500+r.501
    
    
    #############################################################################################
    #############################################################################################
    #############################################################################################
    
    
    
    names(vig.vi)<-"vig.vi"
    names(vig.vi.asistencia)<-"vig.vi.asistencias"
    names(vig.vp)<-"vig.vp"
    names(vig.vgr)<-"vig.vgr"
    names(vig.pr)<-"vig.pr"
    names(vig.tc)<-"vig.tc"
    names(vig.deu)<-"vig.deu"
    names(nn.vi)<-"nn.vi"
    names(nn.vp)<-"nn.vp"
    names(nn.vgr)<-"nn.vgr"
    names(nn.pr)<-"nn.pr"
    names(nn.tc)<-"nn.tc"
    names(nn.deu)<-"nn.deu"
    names(nn.500)<-"nn.500"
    names(nn.501)<-"nn.501"
    names(nn.des)<-"nn.des"
    names(r.vi)<-"r.vi"
    names(r.vp)<-"r.vp"
    names(r.vgr)<-"r.vgr"
    names(r.pr)<-"r.pr"
    names(r.tc)<-"r.tc"
    names(r.deu)<-"nn.deu"
    names(r.500)<-"r.500"
    names(r.501)<-"r.501"
    names(r.des)<-"r.des"
    
    datos.calidad<-cbind(
      vig.vi,
      vig.vi.asistencia,
      vig.vp,
      vig.pr,
      vig.tc,
      vig.deu,
      nn.vi,
      nn.vp,
      nn.pr,
      nn.tc,
      nn.deu,
      nn.500,
      nn.501,
      nn.des,
      r.vi,
      r.vp,
      r.pr,
      r.tc,
      r.deu,
      r.500,
      r.501,
      r.des)
    
    datos.calidad<-as.data.frame(datos.calidad)
    datos.calidad<-t(datos.calidad)

    
    datos.calidad<-cbind(c(
      'vig.vi',
      'vig.vi.asistencia',
      'vig.vp',
      'vig.pr',
      'vig.tc',
      'vig.deu',
      'nn.vi',
      'nn.vp',
      'nn.pr',
      'nn.tc',
      'nn.deu',
      'nn.500',
      'nn.501',
      'nn.des',
      'r.vi',
      'r.vp',
      'r.pr',
      'r.tc',
      'r.deu',
      'r.500',
      'r.501',
      'r.des'),datos.calidad)
    
    datos.calidad<-as.data.frame(datos.calidad)
    datos.calidad<-cbind(datos.calidad[,1],datos.calidad)
    names(datos.calidad)<-c('a','b','c')
    
    
    calidad.vgr<-cbind(vig.vgr,r.vgr)
    a1<-calidad.vgr[,1:2]
    a1<-merge('vig.vgr',a1)
    names(a1)<-c('a','b','c')
    a2<-calidad.vgr[,3:4]
    a2<-merge('r.vgr',a2)
    names(a2)<-c('a','b','c')
    
    nn.vgr<-merge('nn.vgr',nn.vgr)
    names(nn.vgr)<-c('a','b','c')
    
    
    
    
    