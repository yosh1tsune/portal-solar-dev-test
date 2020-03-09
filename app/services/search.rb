class Search
  attr_reader :price, :kwp

  def initialize(price, kwp)
    @price = price.to_f
    @kwp = kwp.to_f
  end

  def main_query
    PowerGenerator.where('(price BETWEEN ? AND ?) AND (kwp BETWEEN ? AND ?)',
                         (@price - (@price * 0.1)), (@price + (@price * 0.1)),
                         (@kwp - (@kwp * 0.1)), (@kwp + (@kwp * 0.1))).page
  end

  def secondary_query
    if @kwp.zero? || @kwp.nil?
      PowerGenerator.where('price <= ?', (@price + (@price * 0.1))).page
    else
      PowerGenerator.where('kwp >= ?', (@kwp - (@kwp * 0.1))).page
    end
  end
end
