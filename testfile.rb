require 'minitest/autorun'
require './parser.rb'
require './retriever.rb'


class TestParser < Minitest::Test

  def setup
    @parser = Parser.new('companies.json')
  end
  
  def test_one
    assert true
  end
  
  def test_to_parse_file
    text_sample = 'AAPL'
    assert !@parser.parse_json.nil?
    assert @parser.parse_json.class == Hash
    assert !@parser.parse_json['companies'].nil?
    assert @parser.parse_json['companies'].any? {|company| company['symbol'] == text_sample}
    assert !@parser.parse_json['companies'].any? {|company| company['symbol'].match " " }
  end
  
  def test_to_create_array
    testhash = {"companies"=>[{"name"=>"AppleInc.", "symbol"=>"AAPL"}, {"name"=>"AlphabetInc.", "symbol"=>"GOOG"}]}
    assert @parser.create_array(testhash).class == Array
    assert @parser.create_array(testhash).include?("AAPL")
    assert @parser.create_array(testhash).include?("GOOG")
  end    
end

class TestRetriever < Minitest::Test

  def setup
   @retriever = Retriever.new
  end
  
  def test_to_launch_csv
    CSV.open("stock_prices.csv") {|csv| csv.first.include? 'Time_Now'}
    CSV.open("stock_prices.csv") {|csv| csv.first.include? 'Ask'}    
  end
  
  def test_to_download_prices
    symbol_array = ['AAPL','GOOG']
    output = @retriever.download_symbol_and_price(symbol_array)
    assert output.class == Array
    output.each do |stock_price|
      assert !stock_price.nil?
    end
  end
  
  def test_to_add_time
    outputs = [['AAPL',22.50],['GOOG',17.85]]
    @retriever.add_time(outputs)
    testtime = Time.now
    outputs.each do |output|
      assert output[0].class == Time
    end
  end
  
  def test_to_print_csv
    output = ["Time.now",'AAPL',"22.50"]
    @retriever.print_csv(output)
    array = CSV.read("stock_prices.csv")[1]
    assert_equal array, output    
  end
end
  