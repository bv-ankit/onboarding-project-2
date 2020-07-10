class Article < ApplicationRecord
  belongs_to :user

  validates :title,
    :presence => true,
    :length => { :in => 4..50 }

  validates :text,
    :presence => true,
    :length => { :in => 10..5000 }
end
