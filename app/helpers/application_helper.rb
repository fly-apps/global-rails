module ApplicationHelper
  def request_start_at
    rs = request.headers['X-Request-Start']
    rs = 't=1624898184537138' if rs.blank?
    rs = rs.split("=").last.to_f / 1000
    rs.round(3)
  end

  def request_dispatch_at
    ds = request.headers['Fly-Dispatch-Start']
    ds = 't=1624898184537364' if ds.blank?
    ds = ds.split("=").last.to_f / 1000
    ds.round(3)
  end
  def replay_overhead
    rs = request_start_at
    ds = request_dispatch_at

    return (ds - rs).round(3)
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
