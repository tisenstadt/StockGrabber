require_relative 'companystocks.rb'
require_relative 'stockpriceretriever.rb'
require_relative 'engine.rb'

companystocks = CompanyStocks.new('companies.json')
stockpriceretriever = StockPriceRetriever.new(:filename => 'stock_prices.csv')
stocks = Engine.new(companystocks, stockpriceretriever).run_program