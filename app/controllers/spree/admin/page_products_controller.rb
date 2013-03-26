class Spree::Admin::PageProductsController < Spree::Admin::ResourceController
  
  before_filter :load_data

  create.before :set_page
  update.before :set_page

  def update_positions
    params[:positions].each do |id, index|
      Spree::PageProduct.update_all(['position=?', index], ['id=?', id])
    end
    respond_to do |format|
      format.js  { render :text => 'Ok' }
    end
  end
  
  private
  
  def location_after_save
    admin_page_products_url(@page)
  end

  def load_data
    @page = Spree::Page.find_by_path(params[:page_id])
  end

  def set_page
    @page_product.page = @page
  end


end
