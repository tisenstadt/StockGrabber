require 'json'

class CompanyStocks #Initialize takes a JSON file, array of stock symbols is returned.   
  attr_accessor :file, :symbols
  def initialize(file)
    @file = file
  end
  
  def get_symbols
    stocks_hash = parse_json
    symbols(stocks_hash)
  end
  
  def parse_json
    JSON.parse(File.read(file).gsub(/\s+/, ""))
  end

  def symbols(stocks_hash)
    stocks_hash['companies'].map do |company|
      company['symbol']
    end
  end
end




