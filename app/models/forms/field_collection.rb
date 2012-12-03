class Forms::FieldCollection < MongoModel::Collection[Forms::Fields::Field]
  def map_with_index
    result = []
    each_with_index { |item, index| result[index] = yield(item, index) }
    result
  end
  
  def self.cast(collection)
    case collection
    when Hash
      sorted_attrs = collection.sort { |(a, _), (b, _)| a.to_i <=> b.to_i }.map { |_, attrs| attrs }
      super(sorted_attrs)
    else
      super
    end
  end
  
  def render(submission, template)
    Forms::FieldCollectionRenderer.new(self, submission, template).render
  end
end
