class Project < ActiveRecord::Base
  self.inheritance_column = nil
  has_many :tasks, dependent: :destroy
  has_many :historys, dependent: :destroy
  has_many :attachments, dependent: :destroy
  belongs_to :user
  belongs_to :component
  belongs_to :customer
  enum type: [:Sonstige, :Reklamation, :Einführung, :Entwicklung]

end
