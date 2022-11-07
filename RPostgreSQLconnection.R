library(RPostgreSQL)
library(dplyr)
## api.elephantsql.com
con <- dbConnect(
  PostgreSQL(),
  host = "arjuna.db.elephantsql.com",
  dbname = "rgwpystu",
  port = 5432,                                   ## postgresql port
  user = "rgwpy***",
  password = "***Q5VZ9HTwuzkL**D7fGp7xj0nXsVx7",
 )

dbListTables(con)  ## see if there are any database in the server

#### lets put some dataframe in the database server

students <- data.frame(
  id = 1:10,
  student_name = c("John", "David", "Marry", "Adam", "Jin", "Christina", "Young", "Sam", "Tony", "Jane"),
  gender = c("M","M","F","M","F","F","M","M","M","F"),
  age = c(34,31,42,46,32,16,21,26,18,23)
  )

students

dbWriteTable(con, "students_postgre", students)

dbListTables(con)

## get data from student
df_postgre <- dbGetQuery(con, "SELECT * FROM students_postgre")

df_update_student <-df_postgre %>% select(id,student_name,age,gender ) %>% 
  mutate(city = c("BKK","SDY","AKL","WLT","BKK","MEL","TAS","TAS","SDY","BKK"))

dbWriteTable(con, "update_db_st",df_update_student )
dbListTables(con)

#### now that we update the col in to new df on sqlserver 

### after done with all task we have to disconnection to the server
dbDisconnect(con)
