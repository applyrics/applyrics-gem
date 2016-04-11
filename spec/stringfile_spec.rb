RSpec.describe Applyrics do
  describe "stringfile" do
    after do
      if File.exist?("./examples/files/Written.strings")
        File.delete("./examples/files/Written.strings")
      end
    end
    context "on a ios project" do
      it "parse a strings file" do
        strings = Applyrics::StringsFile.new("./examples/files/Main.strings")
        expect(strings.to_hash["ntk-4x-Uds.normalTitle"]).to eq "Press me"
      end
      it "writes string files" do
        strings = Applyrics::StringsFile.new("./examples/files/Written.strings", {"test" => "my data"})
        strings.write
        expect(File.exist?("./examples/files/Written.strings")).to be true
      end
    end
  end
end
