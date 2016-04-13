RSpec.describe Applyrics do
  describe 'rebuild' do
    context 'on a ios project' do
      it 'rebuilds language files' do
        Applyrics::GenStrings.run('./examples/ios/iOS Example')
        expect(File.exist?('./examples/ios/iOS Example/Localizable.strings')).to be true
      end
    end
  end
end
