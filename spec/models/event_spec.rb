require 'spec_helper'

describe Event do

  let(:sample_json) { File.read 'spec/support/tenderlove.json' }

  it "imports" do
    #
    Github::Client.any_instance.stub(:get).and_return(sample_json)
    records = Github::Client.fetch 'tenderlove'

    records.each do |record|
      actor = Actor.find_or_create_by(name: 'tenderlove')
      Event.create_from_record actor, record
    end
  end

end
