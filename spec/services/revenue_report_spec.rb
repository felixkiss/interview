require 'rails_helper'

RSpec.describe RevenueReport do
  it "finds best performing day of a year" do
    Payment.create(issue_date: DateTime.new(2016, 1, 10), amount: 10)
    Payment.create(issue_date: DateTime.new(2016, 1, 10), amount: 5)
    Payment.create(issue_date: DateTime.new(2016, 1, 11), amount: 14)
    Payment.create(issue_date: DateTime.new(2017, 1, 1), amount: 250)

    top_performer = RevenueReport.top_performing_day(2016)
    expect(top_performer.day).to eq Date.new(2016, 1, 10)
    expect(top_performer.total_revenue).to eq 15
  end
end
