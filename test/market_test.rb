require './lib/vendor'
require './lib/market'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_3 = Vendor.new("Palisade Peach Shack")
   end

   def test_market_exists
     expected = Market
     actual = @market
     assert_instance_of expected, actual
   end

   def test_it_has_attributes
     expected = "South Pearl Street Farmers Market"
     actual = @market.name
     assert_equal expected, actual

     expected = []
     actual = @market.vendors
     assert_equal expected, actual

   end

  def test_it_can_add_vendors
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

   expected = [@vendor_1, @vendor_2, @vendor_3]
   actual =  @market.vendors
   assert_equal expected, actual
 end

 def market_has_vendor_names
   @vendor_1.stock("Peaches", 35)
   @vendor_1.stock("Tomatoes", 7)
   @vendor_2.stock("Banana Nice Cream", 50)
   @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
   @vendor_3.stock("Peaches", 65)
   @market.add_vendor(@vendor_1)
   @market.add_vendor(@vendor_2)
   @market.add_vendor(@vendor_3)
   expected =
    ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
   actual = @market.vendor_names
   assert_equal expected, actual
 end

  def test_find_vendors_by_item_they_sell
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected =  "Rocky Mountain Fresh"
    actual = @market.vendors_that_sell("Peaches")
    assert_equal expected, actual

    expected = "Ba-Nom-a-Nom"
    actual = @market.vendors_that_sell("Banana Nice Cream")
    assert_equal expected, actual
  end

  def test_sorted_item_list
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected =["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    actual = @market.sorted_item_list
    assert_equal expected, actual
  end

  def test_total_item_list
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    expected = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}
    actual = @market.total_inventory
    assert_equal expected, actual
  end

  def test_market_sell_method
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3.stock("Peaches", 65)
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    actual = @market.sell("Peaches", 200)
    refute actual

    actual = @market.sell("Onions", 1)
    refute actual

    actual = @market.sell("Banana Nice Cream", 5)
    assert actual

    expected = 45
    actual = @vendor_2.check_stock("Banana Nice Cream")
    assert_equal expected, actual

    actual = @market.sell("Peaches", 40)
    assert actual

    expected = 0
    actual = @vendor_1.check_stock("Peaches")
    assert_equal expected, actual

    expected = 60
    actual = vendor_3.check_stock("Peaches")
    assert_equal expected, actual
  end
end
