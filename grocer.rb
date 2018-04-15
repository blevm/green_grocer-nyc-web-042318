require "pry"

def consolidate_cart(cart)
  cart.each_with_object({}) do |cart_list, final_list|
    cart_list.each do |item_key, item_details_hash|
      if final_list[item_key]
        item_details_hash[:count] += 1
      else
        item_details_hash[:count] = 1
        final_list[item_key] = item_details_hash
      end
    end
  end
end

def apply_coupons(cart, coupons)

  coupons.each do |coupon_list|
    item = coupon_list[:item]

      if cart[item] && cart[item][:count] >= coupon_list[:num]
        if cart["#{item} W/COUPON"]
          cart["#{item} W/COUPON"][:count] += 1
        else
          cart["#{item} W/COUPON"] = {:price => coupon_list[:cost], cart["#{name} W/COUPON"][:clearance] => cart[name][:clearance], :count => 1}
        end
        cart[item][:count] -= coupon_list[:num]
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
