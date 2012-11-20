require 'csv'

class Forms::CsvExporter
  def initialize(form)
    @form = form
  end
  
  def to_csv
    CSV.generate do |csv|
      csv << headers
      
      @form.submissions.each do |submission|
        csv << values(submission)
      end
    end
  end
  
private
  def headers
    ["Submitted at"] + fields.map(&:label)
  end
  
  def values(submission)
    [submission.created_at] + fields.map { |field|
      value = submission.value_for(field)
      
      case value
      when Array
        value.join(", ")
      when Hash
        value.map { |k, v| "#{k}: #{v}" }.join(", ")
      else
        value
      end
    }
  end

  def fields
    @fields ||= @form.fields.flatten.select { |f| f.respond_to?(:label) }
  end
end
