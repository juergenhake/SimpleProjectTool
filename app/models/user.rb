class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :projectItems, dependent: :destroy
  has_many :historys, dependent: :destroy
  has_many :projects, dependent: :destroy

  def first_and_lastname
    "#{first_name} #{last_name}"
  end
end
