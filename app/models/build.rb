class Build < ActiveRecord::Base

  scope :with_times, lambda { where("build_time IS NOT NULL") }
  scope :ordered_by_time, lambda { order("build_time DESC") }
  scope :success, lambda { where(:outcome => "success") }
  scope :failure, lambda { where(:outcome => "failed") }
  scope :canceled, lambda { where(:outcome => "canceled") }

  def self.num_success
    success.count
  end

  def self.num_failure
    failure.count
  end

  def self.num_canceled
    canceled.count
  end

  def to_seconds
    (build_time / 1000.0 / 60).round(2)
  end
end
