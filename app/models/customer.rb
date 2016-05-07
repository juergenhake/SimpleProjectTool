class Customer < ActiveRecord::Base
  has_and_belongs_to_many :components
  has_many :projects, dependent: :destroy
  has_many :historys, -> { order(id: :desc) }, dependent: :destroy
  has_many :attachments, -> {order(upload_at: :desc, id: :desc)}, dependent: :destroy

  self.per_page = 10

end
