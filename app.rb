require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'better_errors'
require 'pg'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

set :conn, PG.connect(dbname: 'skumar225')

before do
  @conn = settings.conn
end

#GET INDEX
get '/' do
  redirect '/squads'
end

#Show all squads page
get '/squads' do
  squads = []
  @conn.exec("SELECT * FROM squadtable") do |result|  ##Clarify
    result.each do |squad|
      squads << squad
    end
  end
  @squads = squads
  erb :index
end

#form that allows them to create a new squad
get '/squads/new' do 
  erb :newsquad
end

#Info about a single squad
get '/squads/:id' do
  id = params[:id].to_i
  squad = @conn.exec("SELECT * FROM squadtable WHERE id=$1", [id])
  @squad = squad[0]


  erb :showsquad

end

#Form that allows user to edit an existing squad
get '/squads/:id/edit' do
  id = params[:id].to_i
  squad=@conn.exec("SELECT * FROM squadtable WHERE id=$1", [id])
  @squad = squad[0]

  erb :editsquad
end

#Shows all of the students for an individual squad
get '/squads/:squad_id/students' do
id = params[:squad_id].to_i
 students = []
  @conn.exec("SELECT * FROM studenttable WHERE squad_id = $1", [id]) do |result|
    result.each do |student|
      students << student
    end
  end
  @students = students
  
  erb :squadstudentsindex
end 

# Take user to a page to create a new student 
get '/squads/:squad_id/students/new' do
  id = params[:squad_id].to_i
  squad = @conn.exec("SELECT * FROM squadtable WHERE id = $1", [id])
  @squad = squad[0]
  binding.pry
  erb :newsquadstudent
end

#Take the user to a page that shows information about an individual student in a squad
get '/squads/:squad_id/students/:id' do 
  id = params[:id].to_i
  student = @conn.exec("SELECT * FROM studenttable WHERE squad_=id = $1", [id])
  @student = student[0]
  erb :showsquadstudent

end 


#Take the user to a page that shows EDIT all of the squads
get '/squads/:squad _id/students/:id/edit' do
  id = params[:id].to_i
  student = @conn.exec("SELECT * FROM studenttable WHERE squad_id = $1", [id])
  @student = student[0]
  erb :editsquadstudent

end

#Create a new squad
post '/squads' do
  squad_name = params[:name]
  squad_mascot = params[:mascot]
  @conn.exec("INSERT INTO squadtable (name, mascot) VALUES ($1, $2)", [squad_name, squad_mascot])
  redirect '/squads'
end

#Creating a new student in an existing squad
post '/squads/:squad_id/students' do

# id = params[:id].to_i
# squad = @conn.exec("SELECT * FROM squadtable WHERE id=$1", [id])

  
 name = params[:name]
 age = params[:age].to_i
 spiritanimal = params[:spirit_animal]

 @conn.exec("INSERT INTO studenttable (name, age, spirit_animal) VALUES ($1, $2, $3)", [name, age, spiritanimal])

 redirect '/squads/'<<params[:squad_id]<<'/students'
end

#Edit an existing squad
put '/squads/:id' do
  id= params[:id].to_i

  squad_name = params[:name]
  squad_mascot = params[:mascot]

  @conn.exec("UPDATE squadtable SET name = $1 WHERE id = $2", [squad_name, id])
  @conn.exec("UPDATE squadtable SET mascot = $1 WHERE id = $2", [squad_mascot, id])

  redirect '/squads'

end

#Edit an existing student in a squad
put '/squads/:squad_id/students/:id' do 
  id = params[:id].to_i

  name = params[:name]
  age = params[:age].to_i
  
  spiritanimal = params[:spirit_animal]
  
  @conn.exec("UPDATE studenttable SET name = $1 WHERE id = $2", [name, id])
  @conn.exec("UPDATE studenttable SET age = $1 WHERE id = $2", [age, id])
  @conn.exec("UPDATE studenttable SET spirit_animal = $1 WHERE id = $2",[spiritanimal, id])
  redirect '/squads/'<<params[:squad_id]<<'/students'
end


#Delete an existing squad

delete '/squads/:id' do
  id= params[:id].to_i
  @conn.exec("DELETE FROM squadtable WHERE id=$1", [id])
  redirect '/squads'
end

#Delete exisiting students in a squad

delete '/squads/:squad_id/students/:id' do
  id = params[:id].to_i
  @conn.exec("DELETE FROM studenttable WHERE squad_id=$1", [id])
  redirect '/squads/'<<params[:squad_id]<<'/students'
end 