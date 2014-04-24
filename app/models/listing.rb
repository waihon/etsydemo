class Listing < ActiveRecord::Base
	# Please note no > after 200x, and > after 100x100 
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
	else
		has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
			:storage => :dropbox,
			:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
			:path => ":style/:id_:filename"
	end

	# To resolve Paperclip::Errors::MissingRequiredValidatorError 
	validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

	# Add validations to check the data submitted in the New Listing form
	validates :name, :description, :price, presence: true
	validates :price, numericality: { greater_than: 0 }

	# https://github.com/thoughtbot/paperclip
	# Use Devise helper to validate the Listing image
	#validates_attachment_presence :image
	validates :image, :attachment_presence => true
end
