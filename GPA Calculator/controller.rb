require 'sinatra'
require_relative 'db.rb'

get '/' do
    redirect to '/home'
end

get '/home' do
    db = DBHandler.new
    @CourseCount = db.count
    
    erb :application do
    erb :home
    end
end

get '/add' do
    erb :application do
    erb :add
    end
end

post '/add' do
    db = DBHandler.new
    db.create(params[:name],params[:credit],params[:grade])
    redirect to "/home"
end

get '/calculate' do
    db = DBHandler.new
    @courses = db.all
    @CourseCount = db.count
    @gpa = 0
    @totalCredit = 0
    @totalGrade = 0

    @courses.each do |id, name, credit, grade| 
            
    @totalCredit = @totalCredit +  credit
    
    case grade
    when "A"
    @totalGrade = @totalGrade + 4.0 * credit
    when "A-"
    @totalGrade = @totalGrade + 3.7 * credit
    when "B"
    @totalGrade = @totalGrade + 3.0 * credit
    when "B-"
    @totalGrade = @totalGrade + 2.7 * credit
    when "C"
    @totalGrade = @totalGrade + 2.0 * credit
    when "C-"
    @totalGrade = @totalGrade + 1.7 * credit
    when "D"
    @totalGrade = @totalGrade + 1.0 * credit
    when "D-"
    @totalGrade = @totalGrade + 0.7 * credit
    when "F"
    @totalGrade = @totalGrade + 0.0 * credit
    end
    
    @gpa = @totalGrade/@totalCredit
    
    end

    erb :application do
    erb :result
    end
end

get '/list' do
    db = DBHandler.new
    @courses = db.all
    
    erb :application do
        erb :list
    end
    
end

get '/courses/:id/delete' do
   db = DBHandler.new
   id = params[:id].to_i
   db.remove(id)
   
   erb :application do
        erb :delete
    end
end

get '/courses/:id/edit' do
   db = DBHandler.new
   id = params[:id].to_i
   @course = db.get(id)
   
   erb :application do
        erb :edit
    end
end

post '/courses/:id' do
    db = DBHandler.new
    
    id = params[:id].to_i
    name = params[:name]
    credit = params[:credit]
    grade = params[:grade]
    
    db.update(id, name, credit, grade)
    redirect to '/list'
end