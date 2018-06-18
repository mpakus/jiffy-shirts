# frozen_string_literal: true

require_relative 'input'

module Price
  # Packs from file
  # format:
  # CODE COUNT  PRICE
  class Packs < Input
    # Search Packs by code
    # @param code [String]
    # @return [Array<Price::PackItem>]
    def find_by_code(code)
      @prices ||= {}
      @prices[code] = @items.select { |item| item.code == code }
    end

    # Find Packs by code and returns all counts there
    # @return [Array<Price::PackItem>]
    def find_counts(code)
      find_by_code(code).map { |row| row[1] }.sort.reverse
    end

    private

    # Read and parse Packs file
    # @param file [String]
    def read(file)
      i = 1
      File.foreach(file) do |line|
        row = line.strip.split(/\s+/)
        raise Price::Error::InvalidLine, "Line #{i} is invalid '#{line}'" if row[0].nil? || row[1].nil? || row[2].nil?
        @items << PackItem.new(row[0], row[1].to_i, row[2].to_f.round(2))
        i += 1
      end
    end
  end
end
