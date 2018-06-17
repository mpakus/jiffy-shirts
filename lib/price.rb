# frozen_string_literal: true

require_relative 'price/errors'
require_relative 'price/packs'
require_relative 'price/order'
require_relative 'price/calculate'
# require_relative 'price/output'

# Main Searching
module Price
  def self.perform(order_file, packs_file)
    order = Order.new(order_file)
    packs = Packs.new(packs_file)
    Calculate.new(order, packs).results

    # db.each_table do |table|
    #   Query.new(table).find(searching)
    # end
  end
end
