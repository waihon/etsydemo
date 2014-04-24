class User < ActiveRecord::Base
 	# Include default devise modules. Others available are:
 	# :confirmable, :lockable, :timeoutable and :omniauthable
 	devise :database_authenticatable, :registerable,
    	   :recoverable, :rememberable, :trackable, :validatable

    # Add a validation to ensure that users cannot sign up with a blank name
    validates :name, presence: true
end
