# frozen_string_literal: true

RSpec.describe Price::Calculate do
  let(:packs) { Price::Packs.new './spec/fixtures/packs.txt' }
  let(:order) { Price::Order.new './spec/fixtures/order.txt' }
  let(:calculate) { described_class.new(order, packs) }

  it '' do
    ap calculate.results
  end

end
