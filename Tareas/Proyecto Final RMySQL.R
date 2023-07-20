#https://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf

#Instalar librería
install.packages("RMySQL")

#Usar librería
library("RMySQL")

#Crear conexión
con <- dbConnect(MySQL(), user = "root", host = "localhost", port = 3306, password = "root",
          dbname="prueba")

#Manejo de caracteres especiales
tmp <- sprintf("SELECT * FROM emp WHERE lname = %s", "O'Reilly")
dbEscapeStrings(con, tmp)

#Inserta un dataframe como tabla
dbWriteTable(con, "arrests", datasets::USArrests, overwrite = TRUE)

# Ejecuta el query mandado en un dataframe
dbGetQuery(con, "SELECT * FROM arrests limit 3")

# Guarda el query en un batch y luego le puedes dar fetch con condiciones
res <- dbSendQuery(con, "SELECT * FROM arrests")
data <- dbFetch(res)
data
res <- dbSendQuery(con, "SELECT * FROM arrests")
data <- dbFetch(res, n = 2)
data

#Limpia el batch
dbClearResult(res)

#Borra la tabla
dbRemoveTable(con, "arrests")

#Escritura de tablas
dbWriteTable(con, "mtcars", mtcars, overwrite = TRUE)
dbWriteTable(con, "mtcars", mtcars[1:5, ], overwrite = TRUE)
dbWriteTable(con, "mtcars", mtcars[1:5, ], append = TRUE)
dbWriteTable(con, "mtcars", mtcars[1:5, 1:3], append = TRUE)
dbRemoveTable(con, "mtcars")
dbWriteTable(con, "mtcars", mtcars[1:5, 1:2], append = TRUE)
#Lectura de tablas
dbReadTable(con, "mtcars")
cars <- dbReadTable(con, "mtcars", row.names = NULL)
cars

#Transactions
df <- data.frame(id = 1:5)
df
dbWriteTable(con, "df", df)
dbWriteTable(con, "df", df)
dbWriteTable(con, "df", df, overwrite = TRUE)
dbBegin(con) #Iniciar transacción
dbGetQuery(con, "UPDATE df SET id = id * 10")
dbGetQuery(con, "SELECT id FROM df")
dbRollback(con) #Se echa para atrás
dbGetQuery(con, "SELECT id FROM df")

dbBegin(con) #Iniciar transacción
dbGetQuery(con, "UPDATE df SET id = id * 10")
dbGetQuery(con, "SELECT id FROM df")
dbCommit(con) #Realiza el update
dbGetQuery(con, "SELECT id FROM df")
dbRemoveTable(con, "df")

#Ejecución de funciones
num <- 4
sql <- sprintf("SELECT esPar(%s)", num)
dbGetQuery(con, sql)

#Crear conexión
con <- dbConnect(MySQL(), user = "root", host = "localhost", port = 3306, password = "root",
                 dbname="servicio_clientes")

#Llamada a vista
dbGetQuery(con, "SELECT * FROM DatosQueja;")

#Se desconecta
dbDisconnect(con)

