class HoursReporter < SimpleDelegator

  def initialize(project)
    super(project)
    @project = project
  end

  def project_estimate_hours
    Issue.where(:project => @project).reduce(0) { |sum, milestone| coerce(milestone.estimated_hours, 0) + sum }
  end

  def project_client_estimate_hours
    Milestone.where(:project => @project).reduce(0) { |sum, milestone| coerce(milestone.client_estimated_hours, 0) + sum }
  end

  def project_worked_hours
    Issue.where(:project => @project).reduce(0) { |sum, issue| coerce(issue.worked_hours, 0) + sum }
  end

  def project_current_milestone_estimate_hours
    coerce(@project.current_milestone.estimated_hours, 0)
  end

  def project_current_milestone_client_estimate_hours
    coerce(@project.current_milestone.client_estimated_hours, 0)
  end

  def project_current_milestone_worked_hours
    @project.current_milestone.issues.reduce(0) { |sum, issue| coerce(issue.worked_hours, 0) + sum }
  end

  private

    def coerce(first, second)
      return second if first.nil?
      first
    end

end