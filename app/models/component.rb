class Component < ActiveRecord::Base
  has_many :customers, dependent: :destroy
end
