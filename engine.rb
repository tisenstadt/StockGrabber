require_relative 'companystocks.rb'
require_relative 'stockpriceretriever.rb'

class Engine
  attr_accessor :companystocks, :stockprices
  def initialize(companystocks, stockpriceretriever)
    @companystocks = companystocks
    @stockprices = stockpriceretriever
  end
  
  def run_program
    symbols = companystocks.get_symbols
    stockprices.find_and_save_prices(symbols)
  end
end


