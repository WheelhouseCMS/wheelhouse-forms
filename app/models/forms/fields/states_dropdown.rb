module Forms::Fields
  class StatesDropdown < Field
    property :label, String, :default => "State", :required => true
    property :country, String, :required => true
    property :required, Boolean, :default => false

    self.renderer = Forms::SelectFieldRenderer

    def options
      STATES[country]
    end

    STATES = Forms::Plugin.load_yaml("states.yml").tap { |hash| hash.each { |k, v| hash[k] = v.invert } }
  end
end
