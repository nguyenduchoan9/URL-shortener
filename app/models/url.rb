class Url < ApplicationRecord
  validates :original_url, uniqueness: { scope: :short_url, message: "must be unique" }
end