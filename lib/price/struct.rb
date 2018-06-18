# frozen_string_literal: true

module Price
  OrderItem = Struct.new(:count, :code)
  PackItem = Struct.new(:code, :count, :price)
  ResultItem = Struct.new(:code, :count, :price, :packs)
end
