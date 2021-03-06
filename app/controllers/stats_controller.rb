class StatsController < ApplicationController
  before_action :set_builds
  before_action :set_stats

  def index
  end

  private

  def set_builds
    @builds = Build.all
  end

  def set_stats
    @average = average
    @maximum = Build.success.ordered_by_time.first
    @minimum = Build.success.ordered_by_time.last
    @successes = Build.num_success
    @failures = Build.num_failure
    @cancels = Build.num_canceled
    @stats_by_branch = by_branch
    @master_average = average(Build.with_times.master)
    @average_success = average(Build.with_times.success)
    @average_failure = average(Build.with_times.failure)
  end

  # TODO - Rails generator in CircleCIStats gem to create the model, allow these to be computed inside the gem?
  def average(builds=nil)
    builds = Build.with_times if builds.nil?
    times = builds.map { |build| build.to_seconds }
    (times.inject(:+) / times.length).round(2)
  end

  def by_branch
    all = Build.with_times.group_by(&:branch)
    averages = {}
    all.each do |branch, builds|
      averages[branch] = average(builds)
    end
    averages.sort_by {|_key, value| value}
  end

  def to_seconds(ms)
    ms / 1000 / 60
  end
end
