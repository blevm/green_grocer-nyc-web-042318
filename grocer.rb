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
          cart["#{item} W/COUPON"] = {:price => coupon_list[:cost], :count => 1}
          cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
        end
        cart[item][:count] -= coupon_list[:num]
      end
    end
  cart
end

def apply_clearance(cart)

  cart.each do |item, item_hash|
    if item_hash[:clearance] == true
      item_hash[:price] *= 0.8
      item_hash[:price].round(2)
    end
  end


end

def checkout(cart, coupons)

end
