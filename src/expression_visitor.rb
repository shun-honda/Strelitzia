module Strelitzia
  class ExpressionVisitor
    def visitOr(p)
      raise "Called abstract method: or"
    end

    def visitSeq(p)
      raise "Called abstract method: seq"
    end

    def visitStr(p)
      raise "Called abstract method: or"
    end

    def visitNonterminal(p)
      raise "Called abstract method: seq"
    end
  end
end
