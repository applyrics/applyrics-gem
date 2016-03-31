RSpec.describe Applyrics do
  describe "project" do
    context "on a ios project" do
      it "locates two languages" do
        Dir.chdir("./examples/ios") do
          project = Applyrics::Project.new(:ios)
          expect(project.detected_languages().length).to be 2
        end
      end
    end
  end
end
