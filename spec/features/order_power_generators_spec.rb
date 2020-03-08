require 'rails_helper'

feature 'Order power generators' do
  scenario 'by price descendant' do
    create(:power_generator, price: 6000)
    create(:power_generator, price: 40_000)
    create(:power_generator, price: 5000)
    create(:power_generator, price: 50_000)

    visit root_path
    click_on 'Preço: maior para o menor'

    expect(page).to have_css('#price0', text: 'R$ 50.000,00')
    expect(page).to have_css('#price1', text: 'R$ 40.000,00')
    expect(page).to have_css('#price2', text: 'R$ 6.000,00')
    expect(page).to have_css('#price3', text: 'R$ 5.000,00')
  end

  scenario 'by price ascendant' do
    create(:power_generator, price: 6000)
    create(:power_generator, price: 40_000)
    create(:power_generator, price: 5000)
    create(:power_generator, price: 50_000)

    visit root_path
    click_on 'Preço: menor para o maior'

    expect(page).to have_css('#price0', text: 'R$ 5.000,00')
    expect(page).to have_css('#price1', text: 'R$ 6.000,00')
    expect(page).to have_css('#price2', text: 'R$ 40.000,00')
    expect(page).to have_css('#price3', text: 'R$ 50.000,00')
  end

  scenario 'by power descendant' do
    create(:power_generator, kwp: 10)
    create(:power_generator, kwp: 35)
    create(:power_generator, kwp: 5)
    create(:power_generator, kwp: 7)

    visit root_path
    click_on 'Potencia: maior para o menor'

    expect(page).to have_css('#power0', text: 35)
    expect(page).to have_css('#power1', text: 10)
    expect(page).to have_css('#power2', text: 7)
    expect(page).to have_css('#power3', text: 5)
  end

  scenario 'by power ascendant' do
    create(:power_generator, kwp: 10)
    create(:power_generator, kwp: 35)
    create(:power_generator, kwp: 5)
    create(:power_generator, kwp: 7)

    visit root_path
    click_on 'Potencia: menor para o maior'

    expect(page).to have_css('#power0', text: 5)
    expect(page).to have_css('#power1', text: 7)
    expect(page).to have_css('#power2', text: 10)
    expect(page).to have_css('#power3', text: 35)
  end
end
