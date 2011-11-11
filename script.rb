require './word_finder'
require 'benchmark'

WordFinder.search_and_profile(:search1)
WordFinder.search_and_profile(:search3)
WordFinder.search_and_profile(:search2)
WordFinder.search_and_profile(:search4)
WordFinder.search_and_profile(:search5)

debug = false

Benchmark.bmbm do |x|
  [5,10,100].each do |count|
    %w(search2 search3 search4 search5).each do |search_method|
      x.report("#{search_method} @ #{count}") { WordFinder.search_and_profile("#{search_method}", count, debug) }
    end
  end
end