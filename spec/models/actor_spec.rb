require 'spec_helper'
require_relative '../../lib/github/client'

describe Actor do

  context "import " do
    it "adds actors" do
      records = Github::Client.fetch 'tenderlove'
      expect{Actor.import 'tenderlove', Github::Client}.to change(Actor, :count).by(1)
    end

    it "adds events" do
      records = Github::Client.fetch 'tenderlove'
      expect{Actor.import 'tenderlove', Github::Client}.to change(Event, :count).by(records.length)
    end
  end
end

