class Forms::FieldCollectionRenderer
  include ActionView::Helpers::OutputSafetyHelper
  
  def initialize(collection)
    @collection = collection
  end
  
  def render(options={})
    safe_join(@collection.map { |field| field.renderer.render(options) }, "\n")
  end
end
