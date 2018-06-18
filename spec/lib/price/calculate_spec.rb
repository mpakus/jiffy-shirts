# frozen_string_literal: true

RSpec.describe Price::Calculate do
  let(:packs) { Price::Packs.new './spec/fixtures/packs.txt' }
  let(:order) { Price::Order.new './spec/fixtures/order.txt' }
  let(:calculate) { described_class.new(order, packs) }
  subject { calculate.results }

  describe '.results' do
    it { expect(subject).to be_kind_of(Array) }
    it { subject.each { |row| expect(row).to be_kind_of(Price::ResultItem) } }
    it 'calculates total Count right' do
      subject.each do |row|
        expect(row.count).to eq row.packs.map(&:count).reduce(0, :+).round(2)
      end
    end
    it 'calculates total Price right' do
      subject.each do |row|
        expect(row.price).to eq row.packs.map(&:price).reduce(0, :+).round(2)
      end
    end
  end
end
