require 'elasticsearch/model'
  class Book < ActiveRecord::Base
    searchkick
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    belongs_to :author

    after_create :assign_default_status

     def assign_default_status
      self.status = 'available' if self.status.blank?
     end
  end
