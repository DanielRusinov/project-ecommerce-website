class Listing < ApplicationRecord
  	belongs_to :user
  	belongs_to :category, optional: true

  	validates :title, :image, :category_id, presence: true
  	validates :price, presence: true,
  		numericality: { :message => ": Only positive number without spaces are allowed" }
  	validates :description, presence: true,
  		length: { :minimum => 20 }

  	has_attached_file :image, styles: { medium: "300x300>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
