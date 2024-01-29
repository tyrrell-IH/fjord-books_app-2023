# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :zip_code, format: { with: /\A\d{3}-\d{4}\z/,
                                 message: :invalid_zip_code }, allow_blank: true
end
