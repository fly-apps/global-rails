class DashboardController < ApplicationController
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
  #rescue
  #  render plain: "We got weird data from your browser, this is an error", status: 200
  end

end
