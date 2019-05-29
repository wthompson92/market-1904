require './lib/vendor'
require 'minitest/autorun'
require 'minitest/pride'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
   end

   def test_vendor_exists
     expected = Vendor
     actual = @vendor
     assert_instance_of expected, actual
   end

   def test_it_has_attributes
     expected = "Rocky Mountain Fresh"
     actual = @vendor.name
     assert_equal expected, actual

     expected = {}
     actual = @vendor.inventory
     assert_equal expected, actual

   end

  def test_it can_check_stock
   expected = 0
   actual = @vendor.check_stock("Peaches")
   assert_equal expected, actual
 end

 def test_it_can_stock
   @vendor.stock("Peaches", 30)
   expected = 30
   actual = @vendor.check_stock("Peaches")
   assert_equal expected, actual

   @vendor.stock("Peaches", 25)
   expected = 55
   actual = @vendor.check_stock("Peaches")
   assert_equal expected, actual

   @vendor.stock("Tomatoes", 12)
   expected = {"Peaches"=>55, "Tomatoes"=>12}
   actual = @vendor.inventory
   assert_equal expected, actual
 end
end 
