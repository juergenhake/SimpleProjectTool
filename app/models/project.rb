class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :historys, dependent: :destroy
  has_many :attachments, dependent: :destroy
  belongs_to :user
  belongs_to :component
  belongs_to :customer
  enum type: [:Sonstige]

end
