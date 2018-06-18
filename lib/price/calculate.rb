# frozen_string_literal: true

module Price
  # Main calculations class splits order into the packs
  class Calculate
    attr_reader :order, :packs

    def initialize(order, packs)
      @order = order
      @packs = packs
      @sets = []
    end

    # @return [Array<Price::ResultItem>]
    def results
      order.items.map do |item|
        total_packs = find_packs item.code, find_counts(item.count, packs.find_counts(item.code))
        price = total_packs.map(&:price).reduce(0, :+).round(2)
        Price::ResultItem.new(item.code, item.count, price, total_packs)
      end
    end

    private

    # Find pack by his code and number of parts in it
    # @param code [string]
    # @param counts [Array<Integer>]
    # @return [Array<Price::PackItem>]
    def find_packs(code, counts)
      packs_list = []
      counts.each do |count|
        packs_list << packs.find_by_code(code).select { |pack| pack.count == count }
      end
      packs_list.flatten
    end

    # Find what kind of packs we can have in it
    # coins change quiz - http://rubyquiz.com/quiz154.html
    # @param count [Integer]
    # @param counts [Array<Integer>]
    def find_counts(count, counts)
      counts.sort! { |a, b| b <=> a }

      # memoize solutions
      optimal_change = Hash.new do |hash, key|
        hash[key] = if key < counts.min
                      []
                    elsif counts.include?(key)
                      [key]
                    else
                      counts.
                        # prune unhelpful counts
                        reject { |coin| coin > key }.

                        # prune counts that are factors of larger counts
                        inject([]) { |mem, var| mem.any? { |c| (c % var).zero? } ? mem : mem + [var] }.

                        # recurse
                        map { |coin| [coin] + hash[key - coin] }.

                        # prune unhelpful solutions
                        select { |change| change.sum == key }.

                        # pick the smallest, empty if none
                        min_by(&:size) || []
                    end
      end
      optimal_change[count]
    end
  end
end
