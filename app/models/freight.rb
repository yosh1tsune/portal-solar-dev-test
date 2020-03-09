class Freight < ApplicationRecord
  validates :state, :weight_min, :weight_max, :cost, presence: true

  def freight_cost(address, power_generator)
    if power_generator.weight < power_generator.cubed_weight
      @freight = Freight.find_by('state = ? AND '\
                                 '(weight_min <= ? AND weight_max >= ?)',
                                 address[:uf], power_generator.weight,
                                 power_generator.weight)
    else
      @freight = Freight.find_by('state = ? AND '\
                                 'weight_min <= ? AND weight_max >= ?',
                                 address[:uf], power_generator.cubed_weight,
                                 power_generator.cubed_weight)
    end
  end
end
