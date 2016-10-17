require 'rails_helper'

RSpec.feature 'Submit order', type: :feature do
  let!(:password) { '123456' }
  let!(:email) { 'user@example.com' }
  let!(:user) do
    User.create(
      email: email,
      password: password,
      password_confirmation: password
    ).add_role :admin
  end

  let!(:category) do
    Category.create(
      title: 'test'
    )
  end

  let!(:status) do
    OrderStatus.create(
      name: 'In Progress'
    )
  end

  let!(:product) do
    Product.create(
      title: 'test',
      category: category,
      price: 18
    )
  end

  scenario 'loged user submit order' do
    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_text('Orders')

    visit product_path(product)
    expect(page).to have_text('Add to basket')

    page.set_rack_session(products: Set.new([product.id]))

    visit basket_index_path
    expect(page).to have_text('summary: 18')

    click_button 'Create Order'

    expect(current_path).to eq order_path(Order.last)
    expect(page).to have_text('status: In Progress')
    expect(page).to have_text('Order created successfully')
  end
end
