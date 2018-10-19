vig.500<-dbGetQuery(con,paste(
           "
           with a as (
           select *, floor(numero_poliza/100) as pol
           from p500vf3),
           
           b as(
           select numero_poliza,linea_cred, count(distinct pol), sum(valor_asegurado) as vas, sum(prima_seguro) as prim
           from a
           where fec_vig_pol >= ' ",vig.desde,"' and fec_vig_pol < ' ",vig.hasta,"'
           group by numero_poliza ,linea_cred
           having sum(valor_asegurado) > 0
           ORDER BY sum(prima_seguro))
           
           select linea_cred, count(*), avg(prim) as prim, avg(vas) as vas
           from b
           group by linea_cred
           order by linea_cred
           
           "))


vig.501<-dbGetQuery(con,paste(
                    "
                    with a as (
                    select *, floor(numero_poliza/100) as pol
                    from p501),
                    
                    b as(
                    select numero_poliza,linea_cred, count(distinct pol), sum(valor_asegurado) as vas, sum(prima_seguro) as prim
                    from a
                    where fec_vig_pol >= ' ",vig.desde,"' and fec_vig_pol < ' ",vig.hasta,"'
                    group by numero_poliza ,linea_cred
                    having sum(valor_asegurado) > 0
                    ORDER BY sum(prima_seguro))
                    
                    select linea_cred, count(*), avg(prim) as prim, avg(vas) as vas
                    from b
                    group by linea_cred
                    order by linea_cred
                    
                    "))

vig.desem<-sum(vig.500$count)+sum(vig.501$count)
vig.desem<-c('vig.des','vig.des',vig.desem)
names(vig.desem)<-c('a','b','c')



vig.desem<-as.data.frame(vig.desem)
vig.desem <- t(vig.desem)
