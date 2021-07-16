class TimingResultsController < ApplicationController
  def index
    redirect_to "/"
  end
  def create
    p = timing_result_params
    browser_timings = p.delete(:browser_timings)

    p[:browser_timings] = JSON.parse(browser_timings)
    p[:edge_region] = request.headers['Fly-Region'] || 'local'
    p[:user_agent] = request.headers['User-Agent']

    result = TimingResult.create!(p)

    flash[:notice] = "Last write: ##{result.id}"

    redirect_to "/"
  end

  def timing_result_params
    params.require(:timing_result).permit(
      :vm_region,
      :method,
      :url,
      :is_replay,
      :request_start_at,
      :request_dispatch_at,
      :browser_timings
    )
  end
end