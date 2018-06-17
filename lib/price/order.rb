# frozen_string_literal: true
require_relative 'input'

module Price
  # Order model
  # format:
  # COUNT   CODE
  class Order < Input
    private

    def read(file)
      i = 1
      File.foreach(file) do |line|
        row = line.strip.split(/\s+/)
        raise Price::Error::InvalidLine, "Line #{i} is invalid '#{line}'" if row[0].nil? || row[1].nil?
        @items << [row[0].to_i, row[1]]
        i += 1
      end
    end
  end
end
