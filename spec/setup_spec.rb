RSpec.describe Applyrics do
  describe "setup" do
    before do
      @pwd = Dir.pwd
      Dir.chdir("./examples/ios")
    end
    after do
      Dir.chdir(@pwd)
    end
    context "on a ios project" do
      it "identifies ios project" do
        setup = Applyrics::Setup.new
        expect(setup.is_ios?).to be true
      end
      it "fails to detect android project" do
        setup = Applyrics::Setup.new
        expect(setup.is_android?).to be false
      end
      it "fails to detect unity project" do
        setup = Applyrics::Setup.new
        expect(setup.is_unity?).to be false
      end
      it "creates a Lyricsfile" do
        Applyrics::Setup.new.run()
        expect(Applyrics::Lyricsfile.exist?).to be true
        File.delete("./Lyricsfile")
      end
    end
  end
end
