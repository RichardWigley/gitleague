require 'spec_helper'

describe Event do

  it "imports" do
    records = Github::Client.fetch 'tenderlove'

    records.each do |record|
      actor = Actor.find_or_create_by(name: 'tenderlove')
      Event.create_from_record actor, record
    end
  end

end
