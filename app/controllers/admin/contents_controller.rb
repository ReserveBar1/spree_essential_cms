class ::Admin::ContentsController < ::Admin::ResourceController

  before_filter :load_resource
  before_filter :parent, :only => :index

  belongs_to :page

  def update_positions
    @page = parent
    params[:positions].each do |id, index|
      @page.contents.update_all(['position=?', index], ['id=?', id])
    end
    respond_to do |format|
      format.html { redirect_to admin_page_contents_url(@oage) }
      format.js  { render :text => 'Ok' }
    end
  end
  
  private
    
  def parent
    @page ||= Page.find_by_path(params[:page_id])
  end
    
	def collection
    return @collection if @collection.present?

    unless request.xhr?
      @search = parent.contents.metasearch(params[:search])
      @collection = @search.relation.page(params[:page]).per(Spree::Config[:orders_per_page])
    else
      @collection = Content.where("contents.title #{LIKE} :search", {:search => "#{params[:q].strip}%"}).limit(params[:limit] || 100)
    end
  end

end
