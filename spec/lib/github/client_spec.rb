require 'spec_helper'
require 'digest/md5'
require_relative '../../../lib/github/client'

# Puts in module to avoid having to namespace the tested module
module Github
  attr_reader :sample_json

  describe Github::Client do

    let(:sample_json) { File.read 'spec/support/tenderlove.json' }

    it 'Tenderlove' do
      # sample = File.read 'spec/support/tenderlove.json'

      tc = self
      klass = Class.new(Client) do
        define_method(:get) do |username|
          tc.expect(username).to tc.eq 'tenderlove'
          tc.sample_json
        end
      end
      events = klass.fetch 'tenderlove'
      expect(events).to have_at_least(1).items
    end

    it "has checksum" do
      tc = self
      klass = Class.new(Client) do
        define_method(:get) do |username|
          tc.sample_json
        end
      end
      events = klass.fetch 'tenderlove'
      expect(events.first).to have_key('checksum')
      checksums = events.map { |e| e['checksum'] }
      expect(events.length).to eq checksums.uniq.length
    end

  end
end
