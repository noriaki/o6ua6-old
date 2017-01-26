# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_o6ua6_session'

# Mongoid
Rails.application.config.session_store :mongoid_store
MongoidStore::Session.instance_eval do
  default_scope -> { where(:updated_at.gt => 2.days.ago) }
end
