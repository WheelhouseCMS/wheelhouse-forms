require "wheelhouse"
require "invisible_captcha"

begin
  require "rakismet"
rescue LoadError
  # Rakismet not available
end

module Forms
  extend ActiveSupport::Autoload

  autoload :AkismetFilter
  autoload :NullFilter

  class Plugin < Wheelhouse::Plugin
    config.wheelhouse.forms = ActiveSupport::OrderedOptions.new

    # Disable custom fields by default.
    config.wheelhouse.forms.custom_fields = false

    # Show 'view submission' link in notification emails.
    # You may wish to disable this if you plan to reply directly to notification emails.
    config.wheelhouse.forms.show_admin_link_in_notifications = true

    # Set default spam filter.
    config.wheelhouse.forms.spam_filter = defined?(Rakismet) ? AkismetFilter : NullFilter

    isolate_namespace Forms

    resource { Form }

    initializer :add_mailer_template_paths do
      Forms::Mailer.prepend_view_path(paths["app/templates"].existent.to_a)
    end

    initializer :precompile_assets do |app|
      app.config.assets.precompile += %w(wheelhouse-forms/admin.* wheelhouse-forms/designer.js wheelhouse-forms/submissions.js wheelhouse-forms/*.png)
    end

    def self.load_yaml(file)
      YAML.load(IO.read(File.join(paths["config"].first, file)))
    end
  end
end
