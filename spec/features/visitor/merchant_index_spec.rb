require 'rails_helper'


RSpec.describe "As a visitor on the merchants index page" do
  before :each do
    @user = create(:user)

    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @merch3 = create(:merchant)
    @merch4 = create(:merchant)

    @buyer1 = create(:user, city: "Denver", state: "Colorado")
    @buyer2 = create(:user, city: "Truth and Consequences", state: "Arizona")
    @buyer3 = create(:user, city: "God Knows Where", state: "Alaska")
    @buyer4 = create(:user, city: "God Knows Where", state: "Texas")

    @o1 = create(:order, created_at: 40.days.ago, updated_at: 3.hours.ago, status: "shipped", user: @buyer1)
    @o2 = create(:order, created_at: 35.days.ago, updated_at: 1.days.ago, status: "cancelled", user: @buyer2)
    @o3 = create(:order, created_at: 30.days.ago, updated_at: 3.hours.ago, status: "shipped", user: @buyer3)
    @o4 = create(:order, created_at: 15.days.ago, updated_at: 2.hours.ago, status: "shipped", user: @buyer4)
    @o5 = create(:order, created_at: 14.days.ago, updated_at: 4.days.ago, status: "cancelled", user: @buyer1)
    @o6 = create(:order, created_at: 13.days.ago, updated_at: 2.hours.ago, status: "shipped", user: @buyer1)
    @o7 = create(:order, created_at: 3.days.ago, updated_at: 2.hours.ago, status: "shipped", user: @buyer1)
    @o8 = create(:order, created_at: 2.days.ago, updated_at: 2.hours.ago, status: "pending", user: @buyer2)
    @o9 = create(:order, created_at: 1.days.ago, updated_at: 3.hours.ago, status: "pending", user: @buyer2)

    @i1 = create(:item, price: 100, user: @merch1)
    @i2 = create(:item, price: 50, user: @merch2)
    @i3 = create(:item, price: 20, user: @merch3)

    @oi1 = create(:order_item, price: 100, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 2, order: @o1, fulfilled: true, item: @i1)
    @oi2 = create(:order_item, price: 100, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 1, order: @o2, fulfilled: true, item: @i1)
    @oi3 = create(:order_item, price: 300, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 3, order: @o3, fulfilled: true, item: @i1)
    @oi4 = create(:order_item, price: 400, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 10, order: @o4, fulfilled: true, item: @i2)
    @oi5 = create(:order_item, price: 500, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 2, order: @o5, fulfilled: true, item: @i2)
    @oi6 = create(:order_item, price: 600, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 3, order: @o6, fulfilled: true, item: @i2)
    @oi7 = create(:order_item, price: 700, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 10, order: @o7, fulfilled: true, item: @i3)
    @oi8 = create(:order_item, price: 800, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 1, order: @o8, fulfilled: true, item: @i3)
    @oi9 = create(:order_item, price: 900, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 5, order: @o9, fulfilled: true, item: @i3)
    @oi10 = create(:order_item, price: 100, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 1, order: @o2, fulfilled: false, item: @i1)
    @oi11 = create(:order_item, price: 1900, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 5, order: @o3, fulfilled: false, item: @i1)
    @oi12 = create(:order_item, price: 400, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 4, order: @o4, fulfilled: false, item: @i2)
    @oi13 = create(:order_item, price: 700, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 7, order: @o5, fulfilled: false, item: @i2)
    @oi14 = create(:order_item, price: 800, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 2, order: @o6, fulfilled: false, item: @i3)
    @oi = create(:order_item, price: 100000, created_at: 40.days.ago, updated_at: 3.hours.ago, quantity: 1 , order: @o7, fulfilled: false, item: @i3)

  end

  describe "I see an area with the following statistics" do
    it "top 3 merchants who have sold the most by price and quantity, and their revenue " do
      visit merchants_path
      expect(page).to have_content("Top 3 Merchants to Sell the Most!")
        within("#top3sellers") do
          expect(page).to have_content(@merch3.name)
          expect(page).to have_content(@merch2.name)
          expect(page).to have_content(@merch1.name)
          expect(page).to_not have_content(@merch4.name)
          expect(page).to have_content("$12,300")
          expect(page).to have_content("$6,800")
          expect(page).to have_content("$1,200")
        end
    end

    it "top 3 merchants who were fastest at fulfilling items in an order, and their times" do
      visit merchants_path
      expect(page).to have_content("Top 3 Merchants to fulfill their orders on time!")
        within("#top3times") do
          expect(page).to have_content(@merch3.name)
          expect(page).to have_content(@merch2.name)
          expect(page).to have_content(@merch1.name)
          expect(page).to_not have_content(@merch4.name)
          expect(page).to have_content("7 days")
          expect(page).to have_content("14 days")
          expect(page).to have_content("2 days")
        end

    end

    xit "worst 3 merchants who were slowest at fulfilling items in an order, and their times" do
    end

    xit "top 3 states where any orders were shipped (by number of orders), and count of orders" do
    end

    xit "top 3 cities where any orders were shipped (by number of orders, also Springfield, MI should not be grouped with Springfield, CO), and the count of orders" do
    end

    xit "top 3 biggest orders by quantity of items shipped in an order, plus their quantities" do
    end
  end
end
