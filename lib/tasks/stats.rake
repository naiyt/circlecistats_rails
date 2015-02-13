namespace :stats do
  desc 'Runs stats for the past 30 builds'
  task :run => :environment do
    CircleCIStats.run_stats
    count = 0
    CircleCIStats.builds.each do |build|

      # Just a temporary hack to not dupe builds until we get it working w/webhooks
      unless Build.exists?(:build_num => build.build_num) || build.outcome != 'success' || build.outcome != 'failed'
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
        count += 1
      end
    end
    puts "Added #{count} new builds"
  end
end
