module Cucumber
  def self.update_language(lang, values)
    Cucumber::LANGUAGES[lang].merge!(values)
    Cucumber.instance_eval("@lang = nil") # force to reload parser
    Cucumber.load_language(lang)
  end
end

# Update language keywords here
keywords = {
  "given" => "Given|Premised",
}
Cucumber.update_language "en", keywords
