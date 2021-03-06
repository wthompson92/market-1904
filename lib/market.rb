class Market
attr_reader :name, :vendors

  def initialize(name)
    @name  = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
     @vendors.find do |vendor|
       if vendor.inventory.include?(item)
      return vendor.name
      end
    end
  end

  def sorted_item_list
    all_items = []
    @vendors.each { |vendor|
    vendor.inventory.each { |key, value|
      all_items << key}}
    all_items.uniq.sort
  end

  def total_inventory
    hash = Hash.new(0)
    vendors.each {|vendor|
    vendor.inventory.each {|item, count|
    hash[item] += count}}
    hash
  end


  # def def_subrtact_quant(item, count)
  #   wanted = Hash.new
  #   until count == 0 do
  #     @vendors.each do |vendor|
  #       count -= vendor.inventory[item]
  #       break if vendor.inventory[item] == 0
  #     end
  #   end
  # end


  def sell(item, count)
    wanted = Hash.new
    wanted[item] = count
    if total_inventory[item] >= wanted[item]
    return true
    elsif  total_inventory[item] < wanted[item]
      then false
    else
      "Error"
    end
  end
end
