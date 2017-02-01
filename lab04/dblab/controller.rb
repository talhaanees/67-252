require 'sinatra'
require_relative './database.rb'

get '/movies/new' do
    erb :application do
        erb :new
    end
end

post '/movies' do
    db = DBHandler.new
    @movies = db.create(params[:name])
    redirect to '/movies'
end

get '/' do
    redirect to '/movies'
end

get '/movies' do
    db = DBHandler.new
    @movies = db.all
    erb :application do
        erb :index
    end
end

get '/movies/:id' do
    id = params[:id].to_i
    db = DBHandler.new
    @movie = db.get(id)
    erb :application do
        erb :show
    end
end

get '/movies/:id/edit' do
    id = params[:id].to_i
    db = DBHandler.new
    @movie = db.get(id)
    erb :application do
        erb :edit
    end
end

post '/movies/:id' do
    id = params[:id].to_i
    db = DBHandler.new
    db.update(id, params[:name])
    redirect to '/movies'
end

get '/movies/:id/delete' do
    id = params[:id].to_i
    db = DBHandler.new
    db.destroy(id)
    redirect to '/movies'
end