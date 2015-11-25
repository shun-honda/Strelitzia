module Strelitzia
  class Production
    def initialize(name, expr)
      @name = name
      @expr = expr
    end

    def expr
      return @expr
    end

    def name
      return @name
    end

    def to_s
      return @name + ' = ' + @expr.to_s
    end

  end

  class Expression
    def initialize()
      @list = nil
    end
  end

  class Or < Expression
    def initialize(list)
      @list = list
    end

    def accept(visitor)
      visitor.visitOr(self)
    end

    def to_s
      str = ''
      index = 0
      while true
        str += @list[index].to_s
        if index < @list.length - 1
          str += ' | '
        else
          str += ';'
          return str
        end
        index += 1
      end
    end
  end

  class Seq < Expression
    def initialize(list)
      @list = list
    end

    def accept(visitor)
      visitor.visitSeq(self)
    end

    def to_s
      str = ''
      index = 0
      while true
        str += @list[index].to_s
        if index < @list.length - 1
          str += ' '
        else
          return str
        end
        index += 1
      end
      return str
    end
  end

  class Str < Expression
    def initialize(str, id)
      @str = str
      @id = id
    end

    def str
      return @str
    end

    def id
      return @id
    end

    def accept(visitor)
      visitor.visitStr(self)
    end

    def to_s
      return '\'' + @str + '\''
    end
  end

  class NonTerminal < Expression
    def initialize(name)
      @name = name
    end

    def name
      return @name
    end

    def accept(visitor)
      visitor.visitNonterminal(self)
    end

    def to_s
      return @name
    end
  end
end
