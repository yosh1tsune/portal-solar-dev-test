require 'rails_helper'

RSpec.describe PowerGenerator do
  describe '.add_cubed_weight' do
    it 'save cubed_weight in database' do
      power_generator = create(:power_generator)

      power_generator.add_cubed_weight

      cubed_weight = power_generator.height * power_generator.width *
                     power_generator.lenght * 300

      expect(power_generator).to be_persisted
      expect(power_generator.cubed_weight).to eq cubed_weight
    end
  end
end
