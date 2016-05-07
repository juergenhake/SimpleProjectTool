class Component < ActiveRecord::Base
  has_many :customers, dependent: :destroy
  has_many :historys, -> { order(id: :desc) }, dependent: :destroy
  has_many :attachments, -> {order(upload_at: :desc, id: :desc)}, dependent: :destroy
end
