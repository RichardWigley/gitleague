require 'json'
require 'open-uri'

module Github
  class Client
    def self.fetch username
      new.fetch username
    end

    def fetch username
      JSON.parse get username
    end

  private
    # Returns user feed as JSON
    def get username
      open("https://github.com/#{username}.json").read
    end
  end
end