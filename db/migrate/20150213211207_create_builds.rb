class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :build_time
      t.datetime :commit_date
      t.string :branch
      t.string :build_url
      t.datetime :authored_date
      t.integer :build_num
      t.string :status
      t.integer :retries
      t.boolean :failed
      t.string :subject
      t.string :outcome
      t.string :author_name
      t.boolean :canceled
      t.timestamps null: false
    end
  end
end
