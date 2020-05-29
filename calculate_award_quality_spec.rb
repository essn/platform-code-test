require 'rspec'
require 'calculate_award_quality'

describe 'CalculateAwardQuality' do

  context 'initialization' do
    let(:initial_expires_in) { 'initial_expires_in' }
    let(:initial_quality) { 'initial_quality' }

    subject do
      CalculateAwardQuality.new(
        initial_expires_in: initial_expires_in,
        initial_quality: initial_quality,
      )
    end

    specify { expect(subject.new_expires_in).to eq(initial_expires_in) }
    specify { expect(subject.new_quality).to eq(initial_quality) }
  end

  context '.run' do
    let(:name) { 'Method Name' }
    let(:symbolized_name) { :method_name }
    let(:initial_expires_in) { 'initial_expires_in' }
    let(:initial_quality) { 'initial_quality' }
    let(:calculator_spy) do
      CalculateAwardQuality.new(
        initial_expires_in: initial_expires_in,
        initial_quality: initial_quality,
      )
    end

    def do_call
      CalculateAwardQuality.run(
        name: name,
        initial_expires_in: initial_expires_in,
        initial_quality: initial_quality,
      )
    end

    before do
      allow(CalculateAwardQuality).to receive(:new).and_return(calculator_spy)
      allow(calculator_spy).to receive(:default).and_return true
      allow(calculator_spy).to receive(symbolized_name).and_return true
    end

    it 'returns an instance of CalculateAwardQuality' do
      expect(do_call).to eq(calculator_spy)
    end

    context 'method exists' do
      before do
        allow(calculator_spy).to receive(:respond_to?)
          .with(symbolized_name)
          .and_return(true)
      end

      it 'calls method' do
        calculator_spy.should_receive(:send).with(symbolized_name)

        do_call
      end
    end

    context 'method does not exist' do
      before do
        allow(calculator_spy).to receive(:respond_to?)
          .with(symbolized_name)
          .and_return(false)
      end

      it 'calls default' do
        calculator_spy.should_receive(:default)

        do_call
      end
    end
  end
end
