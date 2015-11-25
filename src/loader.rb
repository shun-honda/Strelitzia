module Strelitzia
  class Loader
    NAME = 0
    STR = 1
    OR = 2
    EQ = 3

    def initialize(inputs)
      @inputs = inputs
    end

    def lexStrelizia
      @tokens = @inputs.split(/\s+/)
    end

    def parseStrelizia
      # print "inputs: \n" + @inputs
      print "tokens: " + @tokens.to_s + "\n"
      size = @tokens.length
      @g = Grammar.new()
      @pos = 0
      while @pos < size
        token = @tokens[@pos]
        if /^[_a-zA-Z][_a-zA-Z0-9]*$/ =~ token
          name = token
          token = @tokens[@pos+=1]
          if token === '='
            @pos += 1
            expr = pOr
            if expr != nil
              prod = Production.new(name, expr)
              @g.addProduction(prod)
            else
              raise "syntax error"
            end
          else
            raise "syntax error"
          end
        end
      end
      return @g
    end

    def pOr
      list = []
      seq = pSeq
      if seq != nil
        list << seq
      else
        return nil
      end
      while @tokens[@pos] != ';'
        if @tokens[@pos] === '|'
          @pos += 1
        elsif list.length == 1
          return seq
        else
          break
        end
        seq = pSeq
        if seq != nil
          list << seq
        end
      end
      @pos += 1
      return Or.new(list)
    end

    def pSeq
      list = []
      term = pTerm
      if term != nil
        list << term
      else
        return nil
      end
      while true
        term = pTerm
        if term != nil
          list << term
        elsif list.length == 1
          return list[0]
        else
          return Seq.new(list)
        end
      end
    end

    def pTerm
      token = @tokens[@pos]
      if /^'([^'\n\r]*)'$/ =~ token
        @pos += 1
        id = @g.addSymBol($1)
        return Str.new($1, id)
      elsif /^([_a-zA-Z][_a-zA-Z0-9]*)$/ =~ token
        @pos += 1
        return NonTerminal.new($1)
      end
      return nil
    end

    def getTokens
      return @tokens
    end
  end

  class Grammar
    def initialize
      @production_list = []
      @symbol_list = []
    end

    def addProduction(prod)
      @production_list << prod
    end

    def addSymBol(symbol)
      if @symbol_list.include?(symbol)
        return @symbol_list.index(symbol)
      end
      id = @symbol_list.length
      @symbol_list << symbol
      return id
    end

    def getProductionList
      return @production_list
    end

    def to_s
      str = ""
      str += "symbol_list: " + @symbol_list.to_s + "\n"
      @production_list.each { |prod| str += prod.to_s + "\n" }
      return str
    end
  end
end
