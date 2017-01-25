class FunnelsController < ApplicationController
  def index
    weeks = weeks_from_range('2014-12-02', '2014-12-27')
    @funnel = {}
    weeks.each do |week|
      applicants = Applicant.where(created_at:
        week[:start_date]..week[:end_date]).group(:workflow_state).count
      @funnel[range_to_string(week)] = applicants
    end
    respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
    end
  end

  private

  def weeks_from_range(start_date, end_date)
    date_ranges = []
    parsed_start_date = Date.parse(start_date)
    parsed_end_date = Date.parse(end_date)

    current_monday = parsed_start_date.beginning_of_week
    while current_monday < parsed_end_date
      date_ranges << { start_date: current_monday,
                       end_date: current_monday + 6 }
      current_monday += 7
    end
    date_ranges
  end

  def range_to_string(date_range)
    date_range[:start_date].strftime('%Y-%m-%d') + '-' + \
      date_range[:end_date].strftime('%Y-%m-%d')
  end

  # generates a formatted version of the funnel for display in d3
  def formatted_funnel
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << { label: date, value: count }
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end
end
