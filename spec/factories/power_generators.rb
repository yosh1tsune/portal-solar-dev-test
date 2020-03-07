FactoryBot.define do
  factory :power_generator do
    name { 'POLI HALF CELL PRIMO' }
    description do
      'Eficiência média da célula de 17%  }
                  PID Free
                  Garantia de 10 anos para o produto e
                  Garantia linear de 25 anos
                  Sistemas comerciais ou residenciais on-grid e off-grid'
    end
    image_url do
      "https://marketplace-img-production.s3.amazonaws.com/' \
                'products/106221/large/20190806-1-1pmgplo.?1565112360"
    end
    manufacturer { 'BYD' }
    price { 20_565.70 }
    kwp { 5.36 }
    height { 0.8 }
    width { 0.25 }
    lenght { 2.2 }
    weight { 118 }
    structure_type { :trapezoidal }
  end
end
