mov500<-dbGetQuery(con, paste(
           "
           select count(*)
           from " ,p500, "
           where tipo_end <> '         ' AND tipo_end <> '      AT '
           
           "))

mov501<-dbGetQuery(con, paste(
  "
  select count(*)
  from " ,p501, "
  where tipo_end <> '         ' AND tipo_end <> '      AT '
  
  "))


mov.desempleo<-mov500+mov501
mov.desempleo<-c('mov.desempleo','mov.desempleo',mov.desempleo)
mov.desempleo<-as.data.frame(mov.desempleo)
names(mov.desempleo)<-c('a','b','c')
