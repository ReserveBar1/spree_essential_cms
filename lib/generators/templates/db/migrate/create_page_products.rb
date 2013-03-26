class CreatePageProducts < ActiveRecord::Migration
  def self.up
    create_table :spree_page_products do |t|
      t.references :page, :null => false, :default => 0
      t.references :product, :null => false, :default => 0
      t.integer    :position,   :default => 999
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :spree_page_products
  end
end
