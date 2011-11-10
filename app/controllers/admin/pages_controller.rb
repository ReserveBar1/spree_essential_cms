class ::Admin::PagesController < ::Admin::ResourceController
  
  before_filter :load_resource
  
  def index
    @pages = collection
  end
  
  def location_after_save
    case params[:action]
      when "create"
        edit_admin_page_content_path(@page, @page.contents.first)
      else
        admin_page_path(@page)
    end        
  end

  def update_positions
    params[:positions].each do |id, index|
      Page.update_all(['position=?', index], ['id=?', id])
    end
    respond_to do |format|
      format.html { redirect_to admin_pages_path }
      format.js  { render :text => 'Ok' }
    end
  end

  private
  
  def find_resource
    @page ||= Page.find_by_path(params[:id])
  end
    
	def collection
    return @collection if @collection.present?

    unless request.xhr?
      @search = Page.metasearch(params[:search])
      @collection = @search.relation.page(params[:page]).per(Spree::Config[:orders_per_page])
    else
      @collection = Page.where("pages.title #{LIKE} :search", {:search => "#{params[:q].strip}%"}).limit(params[:limit] || 100)
    end
  end

end
