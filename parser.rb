require 'json'

class Parser
  attr_accessor :file, :symbols
  def initialize(file)
    @file = file
  end
  
  def retrieve_array_of_symbols
    stocks_hash = parse_json
    create_array(stocks_hash)
  end
  
  def parse_json
    JSON.parse(File.read("#{file}").gsub(/\s+/, ""))
  end

  def create_array(hash)
    symbols = Array.new
    hash['companies'].each do |company_hash|
      symbols << company_hash['symbol']
    end
    return symbols
  end
end




