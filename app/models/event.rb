require 'github/client'

class Event < ActiveRecord::Base
  belongs_to :actor

   SCORES = {
      'CommitCommentEvent' => 2,
      'IssueCommentEvent'  => 2,
      'IssuesEvent'        => 3,
      'WatchEvent'         => 3,
      'PullRequestEvent'   => 5,
      'PushEvent'          => 7,
      'FollowEvent'        => 1,
      'CreateEvent'        => 3,
    }

  def self.create_from_record actor, record
    record['checksum'].force_encoding 'UTF-8'
    create_params = {
      github_type: record['type'],
      actor: actor,
      data: [Marshal.dump(record)].pack('m'),
      github_created_at: record['created_at'],
      checksum: record['checksum']
    }
    create create_params
  end

  def score
    SCORES.fetch(github_type) { 0 }
  end
end
