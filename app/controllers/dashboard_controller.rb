class DashboardController < ApplicationController
  helper_method :replay_overhead
  def region
    current = ENV['FLY_REGION']
    r = params[:code].to_s
    if current == r || current.blank?
      render :index
    else
      response.headers["fly-replay"] = "region=#{r}"
      Rails.logger.info "Replaying request in #{r}"
      render plain: "retry in region #{r}", status: 409
    end
  end

  def replay_overhead
    rs = request.headers['X-Request-Start']
    rs = 't=1624898184537138' if rs.blank?
    ds = request.headers['Fly-Dispatch-Start']
    ds = 't=1624898184537364' if ds.blank?

    rs = rs.split("=").last.to_f
    ds = ds.split("=").last.to_f

    return (ds - rs) / 1000
  end
end
