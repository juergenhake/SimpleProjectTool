class Attachment < ActiveRecord::Base
  has_attached_file :file
  validates_attachment_content_type :file,
    :content_type => [ 'text/plain', 'application/pdf', 'application/msword',
                      'application/excel', 'text/rtf', 'image/jpeg', 'image/gif', 'image/png', 'image/tiff']

  belongs_to :customer
  belongs_to :component
  belongs_to :project
  belongs_to :projectItems
  belongs_to :user

    self.per_page = 10

end


