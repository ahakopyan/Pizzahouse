require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
# подключение базы данных
set : database, "sqlite3:pizzahouse.db"
# создаем модель: то есть миграцию
class Product < ActiveRecord::Base
end

get '/' do
	erb :index
end

get '/about' do
	erb :about	
end
