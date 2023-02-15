I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

I18n.available_locales = %i[de en]
I18n.default_locale = :en
