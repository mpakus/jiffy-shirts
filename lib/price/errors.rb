# frozen_string_literal: true

module Price
  module Error
    class FileNotFound < StandardError; end
    class InvalidLine < StandardError; end
  end
end
