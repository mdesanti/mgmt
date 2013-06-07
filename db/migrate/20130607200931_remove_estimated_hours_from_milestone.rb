class RemoveEstimatedHoursFromMilestone < ActiveRecord::Migration
  def change
    remove_column :milestones, :estimated_hours, :decimal
  end
end
