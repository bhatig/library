class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
     :recoverable, :rememberable, :trackable, :validatable
  has_many :addresses
  accepts_nested_attributes_for :addresses, allow_destroy: true
  after_create :assign_default_role

    def assign_default_role
      self.add_role(:member) if self.roles.blank?
    end

end
