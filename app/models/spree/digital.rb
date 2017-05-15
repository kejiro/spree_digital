module Spree
  class Digital < ActiveRecord::Base
    belongs_to :variant
    has_many :digital_links, dependent: :destroy

    has_attached_file :attachment, path: ":rails_root/private/digitals/:id/:basename.:extension"
    do_not_validate_attachment_file_type :attachment
    validates_attachment_presence :attachment

    if attachment_definitions[:attachment][:storage] == :s3
      attachment_definitions[:attachment][:s3_permissions] = :private
      attachment_definitions[:attachment][:s3_headers] = { :content_disposition => 'attachment' }
    end
  end
end
