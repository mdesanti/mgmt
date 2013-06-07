require 'spec_helper'

describe HoursReporter do
  let!(:user)                                 { create(:user) }
  let!(:project)                              { create(:project) }
  let!(:milestone)                            { create(:milestone, number: 1, start_date: Date.today-2, due_date: Date.today+2, project: project) }
  let!(:current_milestone_issues)             { create_list(:issue, 2, project: project, milestone_number: milestone.number, status: 'not_started')}
  let!(:no_milestone_issues)                  { create_list(:issue, 2, project: project, milestone_number: nil, status: 'not_started')}
  let!(:worked_hours_entry_0)                 { create(:worked_hours_entry, amount: 3, user: user, date: Date.today-1, issue: current_milestone_issues[0])}
  let!(:worked_hours_entry_1)                 { create(:worked_hours_entry, amount: 4, user: user, date: Date.today-1, issue: current_milestone_issues[1])}
  let!(:worked_hours_entry_2)                 { create(:worked_hours_entry, amount: 1, user: user, date: Date.today-1, issue: no_milestone_issues[0])}
  subject(:reporter)                          { HoursReporter.new(project) }

  describe "#project_estimate_hours" do

    it "shows the correct amount of estimate hours for the project" do
      expect(reporter.project_estimate_hours).to eq(20)
    end

  end

  describe "#project_client_estimate_hours" do

    it "shows the correct amount of client estimated hours" do
      expect(reporter.project_client_estimate_hours).to eq(9.99)
    end

  end

  describe "#project_worked_hours" do

    it "shows the correct amount of worked hours for the entire project" do
      expect(reporter.project_worked_hours).to eq(8)
    end

  end

  describe "#project_current_milestone_estimate_hours" do

    it "shows the correct amount of estimated hours for the current milestone" do
      expect(reporter.project_current_milestone_estimate_hours).to eq(10)
    end

  end

  describe "#project_current_milestone_client_estimate_hours" do

    it "shows the correct amount of client estimated hours for the current milestone" do
      expect(reporter.project_current_milestone_client_estimate_hours).to eq(9.99)
    end

  end

  describe "#project_current_milestone_worked_hours" do

    it "shows the correct amount of worked hours for the current milestone" do
      expect(reporter.project_current_milestone_worked_hours).to eq(7)
    end

  end

end