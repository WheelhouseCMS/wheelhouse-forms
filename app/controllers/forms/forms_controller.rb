class Forms::FormsController < Wheelhouse::ResourceController
  self.resource_class = Forms::Form
  manage_site_breadcrumb
  
  helper Forms::SpamHelper
  
  def show
    super do
      @submissions = resource.submissions.not_spam.paginate(:page => params[:p])
    end
  end
  
  def spam
    @form = resource
    @submissions = resource.submissions.spam.paginate(:page => params[:p])
  end
  
  def version
    resource.revert_to(params[:version].to_i)
    render :edit
  end
end
