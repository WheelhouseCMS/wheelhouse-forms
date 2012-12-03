module Forms::Fields
  class CountriesDropdown < Field
    property :label, String, :default => "Country", :required => true
    property :required, Boolean, :default => false
    
    self.renderer = Forms::SelectFieldRenderer

    def options
      COUNTRIES
    end
    
    COUNTRIES = Forms::Plugin.load_yaml("countries.yml")
  end
end
