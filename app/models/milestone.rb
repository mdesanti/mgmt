class Milestone < ActiveRecord::Base

  # Validations

  validates_presence_of :number
  # validates_presence_of :start_date
  validates_presence_of :due_date
  # validates_presence_of :client_estimated_hours
  # validate :start_must_be_before_due_date
  # validate :estimated_hours_must_be_lower_than_client_estimated_hours
  validate :does_not_overlap

  # Associations

  belongs_to :project

  # Instance Methods

  # def start_must_be_before_due_date
  #   errors.add(:start_date, "must be before due date") unless self.start_date < self.due_date
  # end

  # def estimated_hours_must_be_lower_than_client_estimated_hours
  #   errors.add(:estimated_hours, "must be lower than client estimated hours") unless self.estimated_hours <= self.client_estimated_hours
  # end 

  def issues
    Issue.where(milestone_number: number)
  end

  def estimated_hours
    issues.reduce(0) { |sum, issue| coerce(issue.estimated_hours, 0) + sum }
  end

  def does_not_overlap
    project.milestones.where("start_date IS NOT NULL AND due_date IS NOT NULL").each do |milestone|
      unless self.due_date < milestone.start_date || self.start_date > milestone.due_date
        errors.add(:start_date, 'models.milestone.overlap')
      end
    end
  end

  private

    def coerce(first, second)
      return second if first.nil?
      first
    end
  
end
