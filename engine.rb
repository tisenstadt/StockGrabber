require './parser.rb'
require './retriever.rb'


class Engine
  attr_accessor :parser, :retriever
  def initialize(parser, retriever)
    @parser = parser
    @retriever = retriever
  end
  
  def run_program
    symbols = parser.retrieve_array_of_symbols
    retriever.controller(symbols)
  end
end


parser = Parser.new('companies.json')
retriever = Retriever.new
stocks = Engine.new(parser, retriever).run_program