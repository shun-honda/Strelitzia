require "./src/expression_visitor"
module Strelitzia
  class GrammarOptimizer < ExpressionVisitor
    def optimize(g)
      @prod_list = g.getProductionList
      prod_list.each { |prod|
        prod.expr.accept(self)
      }
    end

    def getProduction(name)
      @prod_list.each { |prod|
        if prod.name === name
          return prod
        end
      }
    end

    def visitOr(p)
      first = []

    end

    def visitSeq(p)
    end

    def visitStr(p)
      return p.str
    end

    def visitNonterminal(p)
      prod = getProduction(p.name)
    end
  end

end
