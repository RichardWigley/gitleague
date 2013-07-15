require 'json'
require 'open-uri'

module Github
  class Client
    def self.fetch username
      new.fetch username
    end

    def fetch username
      records = JSON.parse get username
      records.each do |record|
        checksum_from_hash = Digest::MD5.hexdigest Marshal.dump(record)
        record['checksum'] = checksum_from_hash
      end
      records
    end

  private
    # Returns user feed as JSON
    def get username
      open("https://github.com/#{username}.json").read
    end
  end
end