class Forms::FormHandler < Wheelhouse::ResourceHandler
  skip_before_action :verify_authenticity_token, raise: false

  before_action :set_form_context

  get do
  end

  post do
    if verify_recaptcha(action: 'submit', minimum_score: 0.5)
      @form.submit(submission_params, request)
    end
  end

private
  def set_form_context
    @form.view_context = view_context
  end

  def submission_params
    if params.respond_to?(:permit!)
      params.require(:submission).permit!
    else
      params[:submission]
    end
  end
end
