namespace :stats do
  desc 'Runs stats for the past 30 builds'
  task :run => :environment do
    CircleCIStats.run_stats
    CircleCIStats.builds.each do |build|
      build = Build.create!(
        build_time: build.build_time_millis,
        commit_date: build.committer_date,
        branch: build.branch,
        build_url: build.build_url,
        authored_date: build.author_date,
        build_num: build.build_num,
        status: build.status,
        retries: build.retries,
        failed: build.failed,
        subject: build.subject,
        outcome: build.outcome,
        author_name: build.author_name,
        canceled: build.canceled
      )
    end
  end
end
