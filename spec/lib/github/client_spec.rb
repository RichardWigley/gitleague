require 'spec_helper'
require_relative '../../../lib/github/client'

# Puts in module to avoid having to namespace the tested module
module Github

  describe Github::Client do

    it 'Tenderlove' do
      sample = File.read 'spec/support/tenderlove.json'

      tc = self
      klass = Class.new(Client) do
        define_method(:get) do |username|
          tc.expect(username).to tc.eq 'tenderlove'
          sample
        end
      end
      events = klass.fetch 'tenderlove'
      expect(events).to have_at_least(1).items
      p events
    end

  end
end
