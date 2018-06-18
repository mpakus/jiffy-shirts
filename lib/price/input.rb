# frozen_string_literal: true

module Price
  # File input class
  class Input
    attr_reader :items

    def initialize(file)
      raise Price::Error::FileNotFound, "File not found #{file}" unless File.exist?(file)
      @items = []
      read(file)
    end
  end
end
