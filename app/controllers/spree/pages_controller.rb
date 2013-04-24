class Spree::PagesController < Spree::BaseController
  
  before_filter :get_page, :only => :show

  def show
    if @page.root?
      @posts    = Spree::Post.live.limit(5)    if SpreeEssentials.has?(:blog)
      @articles = Spree::Article.live.limit(5) if SpreeEssentials.has?(:news)
      render :template => 'spree/pages/home'
    elsif @page.has_products?
      render :template => 'spree/pages/product_showcase'
    end
  end

  private

    def get_page
      # The original includes url parameters, which wreaks havoc on google campaigns, but we still want to be able to raise the url with the parameters
      # So we search without url parameters for 
      ##@page = Spree::Page.includes(:images, :contents).active.find_by_path(page_path) rescue nil
      @page = Spree::Page.includes(:images, :contents).active.find_by_path(page_path.split('?').first) rescue nil
      raise ActionController::RoutingError.new(page_path) if @page.nil?
    end


    def page_path
      params[:page_path].blank? ? "/" : params[:page_path]
    end

    def accurate_title
      @page.meta_title
    end

end
