# RubycriticExtension

RubyCriticExtension is a gem that wraps around [Rubycritic][1] to provide a quality report of your Ruby code by comparing the code in two different branches. It'll tell you the code quality score of both the branches.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubycritic_extension'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubycritic_extension

## Usage

Running `rubycritic_extension -b base_branch, feature_branch` will analyse all the Ruby files in the base_branch and the feature_branch and compare the score between the two branches, before running this commit all your changes in both the branches:

```bash
$ rubycritic_extension -b base_branch,feature_branch
```

Alternatively if you're using GitLab you can pass `pull_request_id` as the third argument which will post a comment to the respective pull_request:

```bash
$ rubycritic_extension -b base_branch,feature_branch,pull_request_id
```

For posting comment on a pull_request in GitLab below are the configuration. Create a file in config directory `rubycritic_app_settings.yml` with following details

```ruby
gitlab_url: 'gitlab_url'
secret: 'access_token'
app_id: 1
```

Access Token for GitLab

```bash
You can create as many personal access tokens as you like from your GitLab profile (/profile/personal_access_tokens).
```

Application id 

```bash
Once you have the access token get the application id by the below get request to GitLab

https://#{gitlab_url}/api/v3/projects?private_token=#{access_token}&search=#{project_name}
```

Pull Request Id

```bash
https://#{gitlab_url}/api/v3/projects/#{project_id}/merge_requests?private_token=#{access_token}

To get all the pull_requests for the project. 
```

```bash
https://#{gitlab_url}/api/v3/projects/#{project_id}/merge_requests?private_token=#{access_token}&state=#{state}

To get the pull_requests based on the state (merged, opened or closed) pass state as an extra parameter.
```

## Integrating with jenkins

Setup a [webhook][2] in GitLab so that corresponding action triggers jenkins build.
In jenkins add the below line in the build which will help you analyse the code and will post a comment in GitLab

```bash
rubycritic_extension -b ${gitlabSourceBranch},${gitlabTargetBranch},${gitlabMergeRequestId}
```
Configuration can be made to make the build as failed if the overall code quality goes below threshold value or if the difference between two branches goes below difference threshold.

Add app_threshold and difference_threshold to `rubycritic_app_settings.yml`

```ruby
gitlab_url: 'gitlab_url'
secret: 'access_token'
app_id: 1
app_threshold: 85
difference_threshold: 5
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cybrilla/rubycritic_extension. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# rubycritic_extension


[1]: https://github.com/whitesmith/rubycritic
[2]: https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/web_hooks/web_hooks.md