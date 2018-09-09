class FileResource < ApplicationRecord
  include UploadFile
  before_destroy -> { delete_file(name) }
  has_one :pet, dependent: :destroy
  has_many :products, dependent: :destroy, inverse_of: :file_resource
  validates_presence_of :name
end
