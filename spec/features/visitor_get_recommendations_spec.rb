require 'rails_helper'

feature 'Visitor get recommendations' do
  scenario 'successfully' do
    first_generator = create(:power_generator, name: 'PRIMEIRO GERADOR',
                             description: 'Esse é o primeiro gerador',
                             price: 30000, kwp: 50, height: 1.70,
                             width: 0.2, lenght: 1.8, weight: 110)
    second_generator = create(:power_generator, name: 'SEGUNDO GERADOR',
                              description: 'Esse é o segundo gerador',
                              price: 33000, kwp: 55, height: 1.6,
                              width: 0.19, lenght: 1.7, weight: 121)
    third_generator = create(:power_generator,  name: 'TERCEIRO GERADOR',
                             description: 'Esse é o terceiro gerador',
                             price: 5000, kwp: 8.03, height: 1.1,
                             width: 0.12, lenght: 1.3, weight: 80)
    
    visit root_path
    fill_in 'Preço', with: 30000
    fill_in 'Carga', with: 50
    fill_in 'Altura', with: 1.70
    fill_in 'Largura', with: 0.2
    fill_in 'Comprimento', with: 1.8
    fill_in 'Peso', with: 110
    click_on 'Mostre-me'

    expect(page).to have_content first_generator.name
    expect(page).to have_content first_generator.description
    expect(page).to have_content second_generator.name
    expect(page).to have_content second_generator.description
    expect(page).not_to have_content third_generator.name
    expect(page).not_to have_content third_generator.description
  end

  scenario 'or make secondary query if params dont match with none generator' do
    first_generator = create(:power_generator, name: 'PRIMEIRO GERADOR',
                             description: 'Esse é o primeiro gerador',
                             price: 30000, kwp: 50, height: 1.70,
                             width: 0.2, lenght: 1.8, weight: 110)
    second_generator = create(:power_generator, name: 'SEGUNDO GERADOR',
                              description: 'Esse é o segundo gerador',
                              price: 33000, kwp: 55, height: 1.6,
                              width: 0.19, lenght: 1.7, weight: 121)
    third_generator = create(:power_generator,  name: 'TERCEIRO GERADOR',
                             description: 'Esse é o terceiro gerador',
                             price: 5000, kwp: 8.03, height: 1.1,
                             width: 0.12, lenght: 1.3, weight: 80)
    
    visit root_path
    fill_in 'Preço', with: 4800
    fill_in 'Carga', with: 5
    click_on 'Mostre-me'

    expect(page).not_to have_content first_generator.name
    expect(page).not_to have_content first_generator.description
    expect(page).not_to have_content second_generator.name
    expect(page).not_to have_content second_generator.description
    expect(page).to have_content third_generator.name
    expect(page).to have_content third_generator.description
  end
end