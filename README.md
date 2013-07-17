GITLEAGUE


An application that scores users on github activity.

This applicaiton was made by following Tenderlove's PlayByPlay Peepcode video. I changed the tests from Unit tests to RSpec but the code should otherwise remain the same.
He calls the application omglol which I've renamed to gitleague.


Task:
==========

Build a webapp where I can search for a GitHub user and see a score based on their activity.

- The app should be able to update itself regularly with their recent event.
- I want to see their score for spearate weeks.
- Some kind of caching might be useful (weekly score total for each user?)

Resources:

- User data feeds
- https://github.com/ry.json
- https://github.com/tenderlove.json
- https://github.com/gitster.json

- Important fields: repository.url, created_at, actor, type

- Event types & points:

- CommitCommentEvent 2
- IssueCommentEvent  2
- IssuesEvent        3
- WatchEvent         3
- PullRequestEvent   5
- PushEvent          7
- FollowEvent        1
- CreateEvent        3
