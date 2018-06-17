# frozen_string_literal: true

RSpec.describe Price::Packs do
  let(:file) { './spec/fixtures/packs.txt' }
  let(:file_not_exist) { './spec/fixtures/NOTEXIST.txt' }
  let(:file_invalid) { './spec/fixtures/packs_invalid.txt' }

  context 'with non-existed input file' do
    it 'is raise error when file not exists' do
      expect { described_class.new(file_not_exist) }.to raise_error Price::Error::FileNotFound
    end
  end

  context 'with wrong line in file' do
    it 'is raise error when line format is incorrect' do
      expect { described_class.new(file_invalid) }.to raise_error Price::Error::InvalidLine
    end
  end

  context 'with correct input file' do
    subject { described_class.new(file) }

    describe '.new' do
      it 'is create object when file exists' do
        expect(subject.class).to eq described_class
      end
    end

    describe '#items' do
      it { subject.items { |row| expect(row).to is_a? Array } }
      it { subject.items { |row| expect(row[0]).to is_a? String } }
      it { subject.items { |row| expect(row[1]).to is_a? Integer } }
      it { subject.items { |row| expect(row[2]).to is_a? Float } }
    end

    describe '.find_packs' do
      it { expect(subject.find_by_code('MB11').count).to eq 3 }
    end

    describe '.find_counts' do
      it { expect(subject.find_counts('MB11').count).to eq 3 }
      it { expect(subject.find_counts('MB11')).to match_array [8, 5, 2] }
    end
  end
end
