module Price
  class Calculate
    def initialize(order, packs)
      @order = order
      @packs = packs
      @sets = []
    end

    def results
      order.items.each do |item|
        find_numbers(item[0], packs.find_c(itemounts[1]))
      end
    end

    def find_numbers(count, counts)
      counts.map{ |price| f = count/price; count %= price; Array.new(f){price} }.flatten
    end
  end
end