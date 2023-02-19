Rails.application.routes.draw do
  scope '(:locale)',
      locale: Regexp.new(I18n.available_locales.map(&:to_s).join('|')) do
    resources :orders do
      member do
        patch :complete
      end
    end

    # Defines the root path route ("/")
    root "orders#index"
  end
end
