class Book < ApplicationRecord
  belongs_to :library
  validates_presence_of :title
end
