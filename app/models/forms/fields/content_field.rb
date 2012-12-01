module Forms::Fields
  class ContentField < Field
    property :content, Translated[ActionView::OutputBuffer]
    
    self.renderer = Forms::ContentFieldRenderer
  end
end
