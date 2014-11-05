#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe VCR::InternetConnection do
  describe '.available?' do
    before(:each) do
      described_class.send(:remove_instance_variable, :@available) if described_class.instance_variable_defined?(:@available)
    end

    def stub_pingecho_with(value)
      VCR::Ping.stub(:pingecho).with("example.com", anything, anything).and_return(value)
    end

    context 'when pinging example.com succeeds' do
      it 'returns true' do
        stub_pingecho_with(true)
        expect(described_class).to be_available
      end

      it 'memoizes the value so no extra pings are made' do
        VCR::Ping.should_receive(:pingecho).once.and_return(true)
        3.times { described_class.available? }
      end
    end

    context 'when pinging example.com fails' do
      it 'returns false' do
        stub_pingecho_with(false)
        expect(described_class).not_to be_available
      end

      it 'memoizes the value so no extra pings are made' do
        VCR::Ping.should_receive(:pingecho).once.and_return(false)
        3.times { described_class.available? }
      end
    end
  end
end
