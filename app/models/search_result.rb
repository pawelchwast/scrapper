class SearchResult < ApplicationRecord
  belongs_to :phrase
  has_many :ips
end
