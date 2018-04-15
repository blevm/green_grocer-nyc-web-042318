require "pry"

def consolidate_cart(cart)
  final_list = Hash.new(0)

    cart.each do |cart_list|
      cart_list.each do |item_key, item_details_hash|
        final_list[item_key] = {}
        final_list[item_key].merge!(item_details_hash)
        final_list[item_key][:count] = 0
        item = item_key


        cart.each do |cart_list|
          cart_list.each do |item_key, item_details_hash|
            if item_key == item
              final_list[item_key][:count] += 1
            end
          end
        end

      end
    end
    binding.pry
    final_list
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |name, properties|
    if properties[:clearance]
      updated_price = properties[:price] * 0.80
      properties[:price] = updated_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end
