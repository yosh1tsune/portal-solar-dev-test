FactoryBot.define do
  factory :freight do
    state { 'SP' }
    weight_min { 101 }
    weight_max { 110 }
    cost { 555 }
  end
end
