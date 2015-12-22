class AddDefaultProductViewToPages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :default_product_view, :boolean
  end
end
