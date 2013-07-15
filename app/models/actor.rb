require 'github/client'

class Actor < ActiveRecord::Base
  has_many :events

  def self.import name, klass = ::Github::Client
    records = klass.fetch name

    records.each do |record|
      actor = Actor.find_or_create_by(name: name)
      begin
        Event.create_from_record actor, record
      rescue
        next
      end
    end
  end
end
