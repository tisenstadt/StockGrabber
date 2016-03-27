require 'open-uri'
require 'csv'

class StockPriceRetriever
  STOCKS_API = 'http://finance.yahoo.com/d/quotes.csv?s='
  TIME = Time.now  
  
  attr_accessor :file_name
  def initialize(args={}) 
    @file_name = args[:file_name] || "stock_prices.csv"
  end
  
  def find_and_save_prices(symbol_array)
    outputs = download_symbol_and_price(symbol_array)
    printout = add_time(outputs)  
    print_csv(printout) 
  end
  
  def download_symbol_and_price(symbol_array)
    #Where s represents symbol and a represents ask price.
    symbols = symbol_array.join(',')
    values = 'sa'
    output_array = CSV.new(open("#{STOCKS_API}#{symbols}&f=#{values}")).read 
  end
  
  def add_time(array)       
    array.map {|company| company.unshift(TIME)}  
  end
  
  def print_csv(printout)	 
    CSV.open(file_name, "wb") do |csv|
      csv << ["Time_now","Symbol","Ask_price"]   
      printout.each do |company|
        csv << company
      end
    end    
  end 
end




