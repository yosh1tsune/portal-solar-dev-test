class Recommend
  attr_reader :price, :kwp, :height, :width, :lenght, :weight

  def initialize(price, kwp, height, width, lenght, weight)
    @price = price.to_f
    @kwp = kwp.to_f
    @height = height.to_f
    @width = width.to_f
    @lenght = lenght.to_f
    @weight = weight.to_f
  end

  def main_query
    PowerGenerator.where("(price BETWEEN ? AND ?) "\
                         "AND (kwp BETWEEN ? AND ?) "\
                         "AND (height BETWEEN ? AND ?) "\
                         "AND (width BETWEEN ? AND ?) "\
                         "AND (lenght BETWEEN ? AND ?) "\
                         "AND (weight BETWEEN ? AND ?)",
                         (@price-(@price*0.1)), (@price+(@price*0.1)),
                         (@kwp-(@kwp*0.1)), (@kwp+(@kwp*0.1)),
                         (@height-(@height*0.1)), (@height+(@height*0.1)),
                         (@width-(@width*0.1)), (@width+(@width*0.1)), 
                         (@lenght-(@lenght*0.1)), (@lenght+(@lenght*0.1)), 
                         (@weight-(@weight*0.1)), (@weight+(@weight*0.1)))
  end

  def secondary_query
    if @kwp != nil
      PowerGenerator.where("price BETWEEN ? AND ?",
                             (@price-(@price*0.1)), (@price+(@price*0.1)))
    else
      PowerGenerator.where("price BETWEEN ? AND ?",
                             (@kwp-(@kwp*0.1)), (@kwp+(@kwp*0.1)))
    end
  end
end