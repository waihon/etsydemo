class Order < ActiveRecord::Base
	# Add validations for our Order data
	validates :address, :city, :state, presence: true

	# Link the Order database to the Listing database
	belongs_to :listing

	# Link the Order database to the User database
	belongs_to :buyer, class_name: "User"
	belongs_to :seller, class_name: "User"
end
