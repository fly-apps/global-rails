class AddUaToTimingResults < ActiveRecord::Migration[6.1]
  def change
    change_table :timing_results do |t|
      t.string :user_agent
    end
  end
end
