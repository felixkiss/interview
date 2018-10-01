class RevenueReport
  def self.top_performing_day(year)
    return Payment
      .select('DATE(issue_date) AS day, SUM(amount) AS total_revenue')
      .where('YEAR(issue_date) = ?', year)
      .group(:day)
      .order('total_revenue DESC')
      .first
  end
end
