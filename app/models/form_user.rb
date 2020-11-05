# Form user model for Rails
class FormUser < ApplicationRecord
  belongs_to :form
  belongs_to :user
  validates :form, :user, presence: true
end
