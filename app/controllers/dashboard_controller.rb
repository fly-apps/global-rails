class DashboardController < ApplicationController
  skip_forgery_protection
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

  def echo
    primary = ENV['PRIMARY_REGION'] || "local"
    current = ENV['FLY_REGION']

    if primary != current || request.headers['Fly-Region'] == 'remote'
      response.headers["fly-replay"] = "region=#{primary}"
      Rails.logger.info "retry in region #{primary}"
      render plain: "retry in region #{primary}", status: 409
    else
      render json: {
        wat: "yes",
        body_length: request.raw_post&.length.to_i
      }
    end
  end
end
