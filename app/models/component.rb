class Component < ActiveRecord::Base
  has_and_belongs_to_many :customers
  has_many :historys, -> { order(id: :desc) }, dependent: :destroy
  has_many :attachments, -> {order(upload_at: :desc, id: :desc)}, dependent: :destroy
  has_many :projects

  filterrific(
  available_filters: [
    :sorted_by,
    :search_query
  ]
  )

  scope :search_query, lambda { |params|
    # Filters components whose name or id or sap_id matches the query
    return nil  if params.query.blank?
     # condition query, parse into individual keywords
    terms = params.query.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 0
    where(
      terms.map { |term|
        "(LOWER(components.name) LIKE ? OR LOWER(components.id) LIKE ? OR LOWER(components.component_id_sap) LIKE ?)"
      },
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { order('created_at ASC') }


end
