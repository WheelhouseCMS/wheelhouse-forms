class Forms::FieldCollectionRenderer
  include ActionView::Helpers::OutputSafetyHelper
  
  attr_reader :collection, :submission, :template
  
  def initialize(collection, submission, template)
    @collection, @submission, @template = collection, submission, template
  end
  
  def render
    safe_join(collection.map { |field| field.render(submission, template) }, "\n")
  end
end
