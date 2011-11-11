require 'rubygems'
require 'ruby-prof'
require 'strscan'

class WordFinder
  def self.search_and_profile(method, term_count = 5)
    if class_variable_defined?(:@@terms)
      if @@terms.length != term_count
        puts "regenerating terms" if $DEBUG
        @@terms = random_terms(term_count)
      end
    else
      puts "generating terms" if $DEBUG
      @@terms = random_terms(term_count)
    end
    
    result = RubyProf.profile do
      f = new
      puts "===starting #{method}===" if $DEBUG
      @@terms.each do |term|
        result = f.send(method, term)
        puts "#{term}: #{result}" if $DEBUG
      end
    end

    Dir.mkdir("profiles") unless File.directory?("profiles")
    
    printer = RubyProf::GraphPrinter.new(result)
    printer.print(File.new("profiles/#{method}.txt", "w+"))
  end
  
  def search1(term)
    result = nil
    load_data.split("\n").each do |line|
      if line =~ %r(^#{term}$)
        result = line
      end
    end
    !!result
  end
  
  def search2(term)
    !load_data.scan(/^#{term}$/).empty?
  end
  
  def search3(term)
    @data ||= load_data
    !@data.scan(/^#{term}$/).empty?
  end
  
  def search4(term)
    @data ||= load_data
    s = StringScanner.new(@data)
    !!s.scan_until(/^#{term}$/)
  end
  
  def search5(term)
    unless @data_hash
      puts "generating hash" if $DEBUG
      @data_hash = load_data.split("\n").inject({}) {|acc,word| acc[word.to_s] = true; acc  }
    end
    !!@data_hash[term]
  end
  
  private
  
  def self.load_data
    File.read("data.dat")
  end
  
  def load_data
    self.class.load_data
  end
  
  def self.random_terms(term_count)
    data = load_data.split("\n")
    begin
      data.sample(term_count)
    rescue NoMethodError => e
      puts "no sample method #{e}" if $DEBUG
      term_count.times.map { data.choice }
    end
  end
end