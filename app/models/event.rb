require 'github/client'

class Event < ActiveRecord::Base
  belongs_to :actor
  def self.create_from_record actor, record
    create_params = {
      github_type: record['type'],
      actor: actor,
      data: [Marshal.dump(record)].pack('m'),
      github_created_at: record['created_at'],
      checksum: record['checksum']
    }
    create create_params
  end
end
