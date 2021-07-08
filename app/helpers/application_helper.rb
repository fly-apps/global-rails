module ApplicationHelper
  def request_start_at
    rs = request.headers['X-Request-Start']
    rs = 't=1625758614844899' if rs.blank?
    rs = rs.split("=").last.to_f / 1000
    rs.round(3)
  end

  def request_dispatch_at
    ds = request.headers['Fly-Dispatch-Start']
    ds = 't=1625758614845143;instance=f128b7e0' if ds.blank?
    d = Hash[ds.split(";").map(&:strip).map{|f| f.split("=", 2) }]
    ds = d['t'].to_f / 1000
    ds.round(3)
  end

  def replay_overhead
    rs = request_start_at
    ds = request_dispatch_at

    return (ds - rs).round(3)
  end

  def user_agent
    @user_agent ||= begin
      DeviceDetector.new(request.headers['User-Agent'])
    end
  end

  def browser_description(ua = nil)
    ua ||= request.headers['User-Agent']
    return "-" if ua.blank?
    parsed = DeviceDetector.new(ua)

    details = [parsed.name, "on", parsed.os_name]
    if parsed.device_type.present?
      details.push("(#{parsed.device_type.humanize})")
    end
    details.join(" ")
  end

  def database_host
    raw = ENV['DATABASE_URL']
    if raw.blank?
      return "postgres://localhost:5432"
    end
    uri = URI.parse(ENV['DATABASE_URL'])

    uri.user = nil
    uri.password = nil
    uri.path = ""
    uri.query = nil
    uri.to_s
  end
end
