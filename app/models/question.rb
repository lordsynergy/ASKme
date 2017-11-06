# Модель вопроса.
class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :user, presence: true
  validates :text, length: { maximum: 255 }, presence: true

end
