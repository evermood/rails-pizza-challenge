# frozen_string_literal: true

# Set PgCrypto to allow use of uuid
class SetPgCrypto < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'
  end
end
