# frozen_string_literal: true

RSpec.describe Price::Order do
  let(:file) { './spec/fixtures/order.txt' }
  let(:file_not_exist) { './spec/fixtures/NOTEXIST.txt' }
  let(:file_invalid) { './spec/fixtures/order_invalid.txt' }

  context 'with non-existed input file' do
    it 'is raise error when file not exists' do
      expect { Price::Order.new(file_not_exist) }.to raise_error Price::Error::FileNotFound
    end
  end

  context 'with wrong line in file' do
    it 'is raise error when line format is incorrect' do
      expect { Price::Order.new(file_invalid) }.to raise_error Price::Error::InvalidLine
    end
  end

  context 'with correct input file' do
    subject { Price::Order.new(file) }

    describe '.new' do
      it 'is create object when file exists' do
        expect(subject.class).to eq Price::Order
      end
    end

    describe '#items' do
      it { subject.items { |row| expect(row).to is_a? Array } }
      it { subject.items { |row| expect(row[0]).to is_a? Integer } }
      it { subject.items { |row| expect(row[1]).to is_a? String } }
    end
  end
end
