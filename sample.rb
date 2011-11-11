require 'ruby-prof'

count = 100

@data = count.times.inject([]) {|acc| acc << rand(10) }

def b
  @data.sort
end

def a
  b
end

result = RubyProf.profile do
  a
  a
  b
end

printer = RubyProf::GraphPrinter.new(result)
printer.print(STDOUT)