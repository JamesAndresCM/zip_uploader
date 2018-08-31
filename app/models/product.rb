class Product < ApplicationRecord
  belongs_to :file_resource, inverse_of: :products
end
