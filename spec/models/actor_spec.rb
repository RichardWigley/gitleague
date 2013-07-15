require 'spec_helper'
require_relative '../../lib/github/client'

describe Actor do

  context "import " do
    let(:sample_json) { File.read 'spec/support/tenderlove.json' }
    before(:each) do
      Github::Client.any_instance.stub(:get).and_return(sample_json)
    end

    it "adds actors" do
      expect{Actor.import 'tenderlove', Github::Client}.to change(Actor, :count).by(1)
    end

    it "adds events" do
      expect{Actor.import 'tenderlove', Github::Client}.to change(Event, :count).by(30)
    end

    context "has idempodence" do
      before(:each) do
        records = Github::Client.fetch 'tenderlove'

        records.each do |record|
          actor = Actor.find_or_create_by(name: 'tenderlove')
          Event.create_from_record actor, record
        end
      end

      it "actors unchanged" do
        Github::Client.fetch 'tenderlove'
        expect{Actor.import 'tenderlove', Github::Client}.not_to change(Actor, :count)
        expect(Actor.count).to eq 1
      end

      it "events unchanged" do
        expect{Actor.import 'tenderlove', Github::Client}.not_to change(Event, :count)
        expect(Event.count).to eq 30
      end

    end
  end
end

