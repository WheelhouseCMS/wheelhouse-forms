class Forms::Submission
  class Parameters < Hash
    def to_mongo
      result = []
      each do |key, value|
        result << [key, value]
      end
      result
    end

    def self.cast(params)
      case params
      when Array
        params.each_with_object({}) { |v, hash| hash[v[0]] = v[1] }
      else
        # Assume params behaves like a hash
        self[params]
      end
    end

    def self.from_mongo(params)
      cast(params)
    end
  end
end
