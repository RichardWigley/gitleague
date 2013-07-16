require 'spec_helper'

describe Event do

  let(:sample_json) { File.read 'spec/support/tenderlove.json' }

  it "imports" do
    Github::Client.any_instance.stub(:get).and_return(sample_json)
    records = Github::Client.fetch 'tenderlove'

    records.each do |record|
      actor = Actor.find_or_create_by(name: 'tenderlove')
      Event.create_from_record actor, record
    end
    expect(Actor.count).to eq 1
    expect(Event.count).to eq 30
  end

  it "tests score" do
    {
      'CommitCommentEvent' => 2,
      'IssueCommentEvent'  => 2,
      'IssuesEvent'        => 3,
      'WatchEvent'         => 3,
      'PullRequestEvent'   => 5,
      'PushEvent'          => 7,
      'FollowEvent'        => 1,
      'CreateEvent'        => 3,
    }.each do |github_type, score|
      expect((Event.new github_type: github_type).score).to eq score
    end

  end

end
