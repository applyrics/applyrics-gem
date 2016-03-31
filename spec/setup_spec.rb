RSpec.describe Applyrics do
  describe "setup" do
    context "on a ios project" do
      it "identifies ios project" do
        Dir.chdir("./examples/ios") do
          setup = Applyrics::Setup.new
          expect(setup.is_ios?).to be true
        end
      end
      it "fails to detect android project" do
        Dir.chdir("./examples/ios") do
          setup = Applyrics::Setup.new
          expect(setup.is_android?).to be false
        end
      end
      it "fails to detect unity project" do
        Dir.chdir("./examples/ios") do
          setup = Applyrics::Setup.new
          expect(setup.is_unity?).to be false
        end
      end
    end
  end
end
