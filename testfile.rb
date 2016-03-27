require 'minitest/autorun'
require_relative 'companystocks.rb'
require_relative 'stockpriceretriever.rb'


class TestCompanyStocks < Minitest::Test

  def setup
    @companystocks = CompanyStocks.new('companies.json')
  end
  
  def test_one
    assert true
  end
  
  def test_to_parse_file
    text_sample = 'AAPL'
    assert !@companystocks.parse_json.nil?
    assert @companystocks.parse_json.class == Hash
    assert !@companystocks.parse_json['companies'].nil?
    assert @companystocks.parse_json['companies'].any? {|company| company['symbol'] == text_sample}
    assert !@companystocks.parse_json['companies'].any? {|company| company['symbol'].match " " }
  end
  
  def test_to_create_array
    testhash = {"companies"=>[{"name"=>"AppleInc.", "symbol"=>"AAPL"}, {"name"=>"AlphabetInc.", "symbol"=>"GOOG"}]}
    assert @companystocks.symbols(testhash).class == Array
    assert @companystocks.symbols(testhash).include?("AAPL")
    assert @companystocks.symbols(testhash).include?("GOOG")
    assert !@companystocks.symbols(testhash).include?("FOOBAR")
  end    
end

class TestStockPriceRetriever < Minitest::Test
  def setup
   @stockpriceretriever = StockPriceRetriever.new
   
  end
  
  
  def test_to_download_prices
    symbol_array = ['AAPL','GOOG']
    output = @stockpriceretriever.download_symbol_and_price(symbol_array)
    assert output.class == Array
    output.each do |stock_price|
      assert !stock_price.nil?
    end
  end
  
  def test_to_add_time
    outputs = [['AAPL',22.50],['GOOG',17.85]]
    @stockpriceretriever.add_time(outputs)
    testtime = Time.now
    outputs.each do |output|
      assert output[0].class == Time
    end
  end
  
  def test_to_print_csv
    output = [[Time.now,'AAPL',"22.50"]]
    @stockpriceretriever.print_csv(output)
    array = CSV.read("stock_prices.csv")[1]
    assert_equal array, ["#{Time.now}",'AAPL',"22.50"]   
  end
end
  