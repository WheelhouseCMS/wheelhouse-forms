class Forms::FormHandler < Wheelhouse::ResourceHandler
  skip_before_action :verify_authenticity_token, raise: false

  before_action :set_form_context

  get do
  end

  post do
    detect_spam(honeypot: :referral_code, scope: :submission)
    @form.submit(submission_params, request) unless performed?
  end

private
  def set_form_context
    @form.view_context = view_context
  end

  def submission_params
    if params.respond_to?(:require)
      params.require(:submission).permit!
    else
      params[:submission]
    end
  end
end
