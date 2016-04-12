RSpec.describe Applyrics do
  describe "project" do
    context "on an ios project" do
      before do
        @pwd = Dir.pwd
        Dir.chdir("./examples/ios")
        @project = Applyrics::Project.new(:ios)
      end
      after do
        Dir.chdir(@pwd)
      end
      it "correctly identifies it as an ios project" do
        platform = Applyrics::Project.detected_platform
        expect(platform).to be :ios
      end
      it "locates two languages" do
        expect(@project.detected_languages().length).to be 2
      end
      it "identify default language" do
        expect(@project.default_language).to eq "en"
      end
      it "can retrieve language files" do
        expect(@project.language_files["sv"].size).to be 2
      end
      it "can rebuild language files" do
        expect(@project.rebuild_files["en"].size).to be 3
      end
#      it "can apply language data" do
#        expect(@project.rebuild_files["en"].size).to be 2
#      end
    end
  end
end
