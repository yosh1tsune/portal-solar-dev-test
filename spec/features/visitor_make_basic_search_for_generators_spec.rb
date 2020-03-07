require 'rails_helper'

xfeature 'Visitor make basic search for solar panels' do
  scenario 'successfully' do
    puts "Salve #{PowerGenerator.last}"

    expect(page).to have_content 'LUL'
  end
end
