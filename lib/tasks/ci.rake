require 'ci/reporter/rake/rspec'

namespace :hudson do
  task :spec => ["hudson:setup:rspec", "rake:spec"]

  namespace :setup do
    task :pre_ci do
      ENV["CI_REPORTS"] = 'tmp/reports/spec'
    end
    task :rspec => [:pre_ci, "ci:setup:rspec"]
  end
end
