module Forms::RecaptchaHelper
  def recaptcha
    recaptcha_v3(action: 'submit')
  end
end
