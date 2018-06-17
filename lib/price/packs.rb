# frozen_string_literal: true
require_relative 'input'

module Price
  # Packs from file
  # format:
  # COUNT  PRICE   CODE
  class Packs < Input
    def find_prices(code)
      @prices ||= {}
      @prices[code] = @items.select{ |item| item[2] == code }
    end

    def find_counts(code)
      find_prices(code).map{ |row| row[0] }.sort.reverse
    end

    private

    def read(file)
      i = 1
      File.foreach(file) do |line|
        row = line.strip.split(/\s+/)
        raise Price::Error::InvalidLine, "Line #{i} is invalid '#{line}'" if row[0].nil? || row[1].nil? || row[2].nil?
        @items << [row[0].to_i, row[1].to_f.round(2), row[2]]
        i += 1
      end
    end
  end
end
