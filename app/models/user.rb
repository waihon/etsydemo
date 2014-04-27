class User < ActiveRecord::Base
 	# Include default devise modules. Others available are:
 	# :confirmable, :lockable, :timeoutable and :omniauthable
 	devise :database_authenticatable, :registerable,
    	   :recoverable, :rememberable, :trackable, :validatable

    # Add a validation to ensure that users cannot sign up with a blank name
    validates :name, presence: true

    # New database relationship
    has_many :listings, dependent: :destroy

    # Link the Order database to the User database
	has_many :sales, class_name: "Order", foreign_key: "seller_id"
	has_many :purchases, class_name: "Order", foreign_key: "buyer_id"    
end
