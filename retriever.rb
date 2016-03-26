require 'open-uri'
require 'csv'

class Retriever
  
  def initialize
    @csv = launch_csv
  end
  
  def launch_csv 
		CSV.open("stock_prices.csv", "wb") do |csv|
			csv << ['Time_Now','Symbol','Ask']
		end
	end
  
  def controller(symbol_array)
    outputs = download_symbol_and_price(symbol_array)
    printout = add_time(outputs)
    printout.each do |stock|
      print_csv(stock)
    end
  end
  
  def download_symbol_and_price(symbol_array)
    #Where s represents symbol and a represents ask price.
    symbols = symbol_array.join(',')
    values = 'sa'
    output_array = CSV.new(open("http://finance.yahoo.com/d/quotes.csv?s=#{symbols}&f=#{values}")).read 
  end
  
  def add_time(array)
    array.each do |array|
      array.unshift(Time.now)
    end
  end
  
  def print_csv(printout)	
		CSV.open("stock_prices.csv", "a+") do |csv|
      csv << [printout[0], printout[1],printout[2]]
		end
	end 
end




