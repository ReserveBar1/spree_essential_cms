Spree::BaseController.class_eval do

  before_filter :get_pages

  def get_pages
    admin = request.path =~ /^\/admin/
    ##@page = Spree::Page.find_by_path(request.path) rescue nil unless admin
    @page = Spree::Page.find_by_path(request.path.split('?').first) rescue nil unless admin
    scope = admin ? Spree::Page.scoped : Spree::Page.visible
    @pages = scope.order(:position).all
  end

end
