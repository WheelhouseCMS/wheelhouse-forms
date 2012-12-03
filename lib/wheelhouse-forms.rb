require "wheelhouse"

module Forms
  class Plugin < Wheelhouse::Plugin
    config.wheelhouse.forms = ActiveSupport::OrderedOptions.new
    
    # Disable custom fields by default
    config.wheelhouse.forms.custom_fields = false
    
    isolate_namespace Forms
    
    resource { Form }
    
    initializer :add_mailer_template_paths do
      Forms::Mailer.prepend_view_path(paths["app/templates"].existent.to_a)
    end
    
    initializer :precompile_assets do |app|
      app.config.assets.precompile += %w(wheelhouse-forms/admin.*)
    end
    
    def self.load_yaml(file)
      YAML.load(IO.read(File.join(paths["config"].first, file)))
    end
  end
end
