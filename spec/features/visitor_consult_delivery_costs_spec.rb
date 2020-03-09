require 'rails_helper'

feature 'Visitor consult delivery costs' do
  scenario 'successfully by true weight' do
    power_generator = create(:power_generator, price: 30_000, kwp: 50,
                                               height: 1.70, width: 0.2,
                                               lenght: 1.8, weight: 110)
    create(:freight, state: 'SP', weight_min: 100.1,
                     weight_max: 110.0, cost: 500)
    create(:freight, state: 'SP', weight_min: 110.1,
                     weight_max: 120.0, cost: 700)
    create(:freight, state: 'SP', weight_min: 140.1,
                     weight_max: 150.0, cost: 1200)

    visit root_path
    click_on power_generator.name
    fill_in 'CEP', with: '01001-000'
    click_on 'Calcular'

    expect(page).to have_content 'Preço do Produto: R$ 30.000,00'
    expect(page).to have_content 'Custo do Frete: R$ 500,00'
    expect(page).to have_content 'Valor Total: R$ 30.500,00'
  end

  scenario 'successfully by cubed weight' do
    power_generator = create(:power_generator, price: 30_000, kwp: 50,
                                               height: 0.70, width: 0.2,
                                               lenght: 1.8, weight: 110)
    create(:freight, state: 'SP', weight_min: 100.1,
                     weight_max: 110.0, cost: 500)
    create(:freight, state: 'SP', weight_min: 110.1,
                     weight_max: 120.0, cost: 700)
    create(:freight, state: 'SP', weight_min: 70.1,
                     weight_max: 80.0, cost: 300)

    visit root_path
    click_on power_generator.name
    fill_in 'CEP', with: '01001-000'
    click_on 'Calcular'

    expect(page).to have_content 'Preço do Produto: R$ 30.000,00'
    expect(page).to have_content 'Custo do Frete: R$ 300,00'
    expect(page).to have_content 'Valor Total: R$ 30.300,00'
  end

  scenario 'unsuccessfully if cep is invalid' do
    power_generator = create(:power_generator, price: 30_000, kwp: 50,
                                               height: 1.70, width: 0.2,
                                               lenght: 1.8, weight: 110)

    visit root_path
    click_on power_generator.name
    fill_in 'CEP', with: '0101-000'
    click_on 'Calcular'

    expect(page).to have_content "Insira um CEP válido. Ex: '00000000' "\
                                 'ou 00000-000'
  end
end
