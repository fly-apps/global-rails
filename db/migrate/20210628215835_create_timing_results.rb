class CreateTimingResults < ActiveRecord::Migration[6.1]
  def change
    create_table :timing_results do |t|
      t.string :edge_region
      t.string :vm_region
      t.string :method
      t.string :url
      t.boolean :is_replay
      t.float :request_start_at
      t.float :request_dispatch_at
      t.jsonb :browser_timings, null: true
      t.timestamps
    end
  end
end