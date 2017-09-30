require 'openssl'

class User < ApplicationRecord
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, uniqueness: true, presence: true
  validates_email_format_of :email, :message => 'is not looking good'
  validates :username, uniqueness: true, presence: true, format: { with: /\A[a-zA-Z][a-zA-Z0-9-_]{2,40}$\z/ }


  attr_accessor :password

  validates_presence_of :password, on: :create

  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      # добавляем соль для усложнения пароля
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаем хэш пароля - уникальная строка, из которой невозможно восстановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST
        ))
    end
  end

  # служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  # медот для аутентификации пользователей
  def self.authenticate(email, password)
    user = find_by(email: email) # сначала находим пользователя по email

    # ВНИМАНИЕ: сравнивается только password_hash, а оригинальный пароль никогда
    # нигде не сохраняется!
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
    user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

end
