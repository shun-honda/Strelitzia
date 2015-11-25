require "./src/expression"
require "./src/loader"
require "./src/parser_generator"
require "./src/grammar_optimizer"

fileName = ARGV[0]
if fileName == nil
  p "no input file"
  exit(1)
end

s = File.read(ARGV[0], :encoding => Encoding::UTF_8)
begin
  loader = Strelitzia::Loader.new(s)
  loader.lexStrelizia
  g = loader.parseStrelizia
  print g.to_s
  generator = Strelitzia::ParserGenerator.new()
  generator.generate(g)
rescue => e
  p e
end
