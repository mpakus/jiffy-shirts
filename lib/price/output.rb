# frozen_string_literal: true

module Price
  # Human readable output
  class Output
    # Display to STDOUT our results
    # @param [Price::ResultItem]
    def <<(result)
      displayed = {}

      puts %(#{result.count} #{result.code} #{result.price})

      result.packs.each do |pack|
        count_pack = "#{result.packs.count(pack)} x #{pack.count}"
        key = "#{pack.code}#{count_pack}"
        next if displayed.fetch(key, nil)
        puts %(\t#{count_pack} $#{pack.price})
        displayed[key] = true
      end
    end
  end
end
