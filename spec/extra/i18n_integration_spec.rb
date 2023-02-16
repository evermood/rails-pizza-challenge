require "rails_helper"

describe "I18n" do
  context "translations" do
    it "for #{I18n.available_locales.join ', '} are syncronized" do
      expect(TranslationsSync.new(list: I18n.available_locales.join(","), ignore: "web_console").missing).to eq({})
    end
  end
end
