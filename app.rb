require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
# подключение базы данных
set :database, "sqlite3:pizzahouse.db"
# создаем модель: то есть миграцию
class Product < ActiveRecord::Base
end

class Order < ActiveRecord::Base
end 

get '/' do
	@products = Product.all
	erb :index
end

get '/about' do
	erb :about	
end

post '/place_order' do
	@order = Order.create params[:order]
	erb :order_placed
end

post '/cart' do

	# получаем список параметров и разбираем (parse) их

	# переменная orders_input для получения из Layout
	@orders_input = params[:orders_input]
	# переменная которая используется во views 
	@items = parse_orders_input @orders_input

# выводим сообщение о том, что корзина пуста пуста
	if @items.length == 0
		return erb :cart_is_empty
	end

	# выводим список продуктов в корзине
	# для каждого элемента делаем запрос
	
	@items.each do |item|
		# item - это у нас массив [id, cnt]
		 item[0] = Product.find(item[0])
	end
	erb :cart
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

	
