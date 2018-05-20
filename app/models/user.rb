class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :first_name, :last_name, :country, :city, presence: true
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true,
       numericality: { :message => ": Only positive number without spaces are allowed" },
       uniqueness: true, length: { :minimum => 10, :maximum => 15 }
  validates :email, presence: true, uniqueness: true,
      format: { with: /\A[^@\s]+@([^@.\s]+.)+[^@.\s]+\z/ ,
      :message => ": Please enter a valid email" }
end
