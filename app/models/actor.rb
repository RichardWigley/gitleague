class Actor < ActiveRecord::Base
  has_many :events

  def self.import name, klass = ::Github::Client
    records = klass.fetch 'tenderlove'

    records.each do |record|
      actor = Actor.find_or_create_by(name: 'tenderlove')
      Event.create_from_record actor, record
    end
  end
end
