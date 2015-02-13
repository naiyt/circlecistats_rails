class Build < ActiveRecord::Base

  scope :with_times, lambda { where("build_time IS NOT NULL") }
  scope :ordered_by_time, lambda { order("build_time DESC") }

  def to_seconds
    (build_time / 1000.0 / 60).round(2)
  end
end
