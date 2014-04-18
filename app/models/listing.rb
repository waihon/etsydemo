class Listing < ActiveRecord::Base
	# Please note no > after 200x, and > after 100x100 
	has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
		:storage => :dropbox,
		:dropbox_credentials => Rails.root.join("config/dropbox.yml")
	# To resolve Paperclip::Errors::MissingRequiredValidatorError 
	validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)
end
