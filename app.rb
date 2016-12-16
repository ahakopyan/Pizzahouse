require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
# подключение базы данных
set :database, "sqlite3:pizzahouse.db"
# создаем модель: то есть миграцию
class Product < ActiveRecord::Base
end

get '/' do
	@products = Product.all
	erb :index
end

get '/about' do
	erb :about	
end

post '/cart' do
	orders_input = params[:orders]
	@orders = parse_orders_input orders_input
	erb "Hello! #{@orders.inspect}"
end
# функция, которая я разделяет строку продуктов в карзине на  три чассти в массивы:
def parse_orders_input orders_input
	
	s1 = orders_input.split(/,/)

	arr = []

	s1.each do |x|
		s2 = x.split(/=/)

		s3 = s2[0].split(/_/)

		id = s3[1]
		cnt = s2[1]

		arr2 = [id, cnt]

		arr.push arr2
	end

	return arr
end
