require File.expand_path('../spec_helper', __FILE__)

RSpec.describe Applyrics do
  describe 'rebuild' do
    after do
      if File.exist?('./examples/ios/iOS Example/Localizable.strings')
        File.delete('./examples/ios/iOS Example/Localizable.strings')
      end
    end
    context 'on a ios project' do
      it 'rebuilds language files' do
        Applyrics::GenStrings.run('./examples/ios/iOS Example')
        expect(File.exist?('./examples/ios/iOS Example/Localizable.strings')).to be true
      end
    end
  end
end
