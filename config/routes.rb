class Spree::PossiblePage
  def self.matches?(request)
    ##path = request.fullpath
    path = request.fullpath.split('?').first
    return if path =~ /(^\/(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user)+)/
    count = Spree::Page.active.where(:path => path.gsub("//","/")).count
    0 < count
  end
end

Spree::Core::Engine.routes.draw do

  resources :pages do
    collection do
      post :hennessy_email_subscription
    end
  end

  namespace :admin do

    resources :pages do
      collection do
        post :update_positions
      end

      resources :contents do
        collection do
          post :update_positions
        end
      end

      resources :images, :controller => "page_images" do
        collection do
          post :update_positions
        end
      end
      
      resources :products, :controller => "page_products" do
        collection do
          post :update_positions
        end
      end
      
    end

  end

  constraints(Spree::PossiblePage) do
    get '(:page_path)', :to => 'pages#show', :page_path => /.*/, :as => :page
  end
  
end
