require 'rails_helper'

RSpec.describe 'as a visitor or a registered user', type: :feature do
  before :each do
    @user_1 = create(:user, role: "user")
    @merchant = create(:merchant)
    @i1, @i2, @i3, @i4, @i5 = create_list(:item, 5, user: @merchant)
    @o1 = create(:order)
    @io1 = create(:order_item, item: @i1, order: @o1)
    @io2 = create(:order_item, item: @i2, order: @o1)
    @io3 = create(:order_item, item: @i3, order: @o1)
    @io4 = create(:order_item, item: @i4, order: @o1)
    @io5 = create(:order_item, item: @i5, order: @o1)
  end
  describe 'I visit my cart and see a link to empty my cart' do
    it 'shows item name, small image of item, merchant, price, desired quantity and sub total' do

      visit item_path(@i1)
      click_button "Add Item"

      visit item_path(@i1)
      click_button "Add Item"

      visit item_path(@i2)
      click_button "Add Item"

      visit cart_path

      [@i1,@i2].each do |item|
        within('.cart') do
          expect(page).to have_content(item.name)
          expect(find("#image-#{item.id}")[:src]).to eq(item.image)
          expect(page).to have_content(item.user.name)
          expect(page).to have_content(item.price)
          expect(page).to have_content(2)
          expect(page).to have_content(1)
          expect(page).to have_content("Subtotal: $6.00")
          expect(page).to have_content("Subtotal: $4.50")
        end
        expect(page).to have_content("Grand total: $10.50")
        expect(page).to have_link("Empty My Cart")
        save_and_open_page
      end
    end
  end
end
