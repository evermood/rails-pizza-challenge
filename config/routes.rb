Rails.application.routes.draw do
  scope '(:locale)',
      locale: Regexp.new(I18n.available_locales.map(&:to_s).join('|')) do
    resources :orders

    # Defines the root path route ("/")
    root "orders#index"
  end
end
