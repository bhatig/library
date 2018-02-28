class Author < ActiveRecord::Base
	searchkick
	has_many :books, dependent: :destroy
	has_many :addresses
	accepts_nested_attributes_for :addresses, allow_destroy: true
end
