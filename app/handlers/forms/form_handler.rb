class Forms::FormHandler < Wheelhouse::ResourceHandler
  skip_before_filter :verify_authenticity_token
  
  before_filter :set_form_context
  
  get do
  end
  
  post do
    @form.submit(params[:submission], request)
  end

private
  def set_form_context
    @form.view_context = view_context
  end
end
