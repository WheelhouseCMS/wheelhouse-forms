module Forms
  class AkismetFilter
    include Rakismet::Model
    
    def self.check(submission)
      filter = new(submission)
      submission.spam = true if filter.spam?
    end
    
    def initialize(submission)
      @submission = submission
    end
    
    def user_ip
      @submission.ip_address
    end
    
    def content
      responses.join("\n")
    end
  
  private
    def responses
      fields.map { |field| @submission.value_for(field) }
    end
    
    def fields
      @submission.form.fields.flatten
    end
  end
end
