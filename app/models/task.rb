class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :historys, -> { order(id: :desc) }, dependent: :destroy
  has_many :attachments, dependent: :destroy
end
