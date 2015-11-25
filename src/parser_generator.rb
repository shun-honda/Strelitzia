require "./src/expression_visitor"
module Strelitzia
  class ParserGenerator < ExpressionVisitor

    def generate(g)
      prod_list = g.getProductionList
      prod_list.each { |prod|
        prod.expr.accept(self)
      }
    end

    def visitOr(p)
    end

    def visitSeq(p)
    end

    def visitStr(p)
    end

    def visitNonterminal(p)
    end
  end
end
