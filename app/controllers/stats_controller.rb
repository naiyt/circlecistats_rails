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
    @maximum = maximum
    p @maximum
  end

  # TODO - Rails generator in CircleCIStats gem to create the model, allow these to be computed inside the gem?
  def average(builds=nil)
    builds = Build.with_times if builds.nil?
    times = builds.map { |build| build.to_seconds }
    (times.inject(:+) / times.length).round(2)
  end

  def maximum
    Build.ordered_by_time.first
  end

  def to_seconds(ms)
    ms / 1000 / 60
  end
end
