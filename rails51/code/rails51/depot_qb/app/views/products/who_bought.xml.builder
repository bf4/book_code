xml.order_list(:for_product => @product.title) do
  for o in @product.orders
    xml.order do
      xml.name(o.name)
      xml.email(o.email)
    end
  end
end
