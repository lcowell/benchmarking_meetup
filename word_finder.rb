require 'rubygems'
require 'ruby-prof'
require 'strscan'

class WordFinder
  def self.search_and_profile(method)
    terms = %w(apple zebra zaphod manatee)
    result = RubyProf.profile do
      f = new
      puts "===starting #{method}==="
      terms.each do |term|
        puts "#{term}: #{f.send(method, term)}"
      end
    end

    printer = RubyProf::GraphPrinter.new(result)
    printer.print(File.new("profiles/#{method}.txt", "w+"))
  end
  

































  # def search1(term)
  #   result = nil
  #   File.read(filename).split("\n").each do |line|
  #     if line =~ %r(^#{term}$)
  #       result = line
  #     end
  #   end
  #   !!result
  # end
  # 







































  # def search2(term)
  #   !File.read(filename).scan(/^#{term}$/).empty?
  # end
  # 













































  # def search3(term)
  #   @data ||= File.read(filename)
  #   !@data.scan(/^#{term}$/).empty?
  # end
  # 












































  # def search4(term)
  #   @data ||= File.read(filename)
  #   s = StringScanner.new(@data)
  #   !!s.scan_until(/^#{term}$/)
  # end
  
  private
  
  def filename
    "data.dat"
  end
end