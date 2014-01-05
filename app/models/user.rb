class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :posts
  validates_confirmation_of :password, message: "Ambos campos deben coincidoir", if: :password
end
