# encoding: utf-8
RSpec.describe Applyrics do
  describe "languagefile" do
    after do
      if File.exist?("./examples/files/written.json")
        File.delete("./examples/files/written.json")
      end
    end
    context "on a ios project" do
      it "parse a language file" do
        strings = Applyrics::LanguageFile.new("./examples/files/translations.json")
        expect(strings.to_hash["sv"]["Main.strings"]["ntk-4x-Uds.normalTitle"]).to eq "Tryck här!"
      end
      it "writes language files" do
        strings = Applyrics::LanguageFile.new("./examples/files/written.json", {"sv" => {"my.strings" => {"string" => "my data"}}})
        strings.write
        expect(File.exist?("./examples/files/written.json")).to be true
      end
    end
  end
end
