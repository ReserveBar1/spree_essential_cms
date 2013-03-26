class Spree::PageProduct < ActiveRecord::Base
  
  belongs_to :product
  belongs_to :page
  
  
end