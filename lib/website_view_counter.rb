# frozen_string_literal: true

class WebsiteViewCounter
  def call(logfile:)
    url_hits_by_ip = url_hits_by_ip(logfile)
    pages_views = counted_pages_views(url_hits_by_ip)

    ordered_pages_views(pages_views)
  end

  private

  def url_hits_by_ip(logfile)
    # https://stackoverflow.com/a/28916684
    url_hits_by_ip = Hash.new { |h, k| h[k] = [] }

    logged_pages_views(logfile).each do |logged_view|
      url = extract_url(logged_view)
      ip = extract_ip(logged_view)
      url_hits_by_ip[url] << ip
    end

    url_hits_by_ip
  end

  def counted_pages_views(url_hits_by_ip)
    {
      total_views: url_hits_by_ip.transform_values { |ips| ips.count },
      unique_views: url_hits_by_ip.transform_values { |ips| ips.uniq.count }
    }
  end

  def ordered_pages_views(pages_views)
    pages_views.transform_values { |views| views.sort_by { |_key, value| value }.reverse.to_h }
  end

  def logged_pages_views(logfile)
    logfile.split("\n")
  end

  def extract_url(logged_view)
    logged_view.split(' ').first
  end

  def extract_ip(logged_view)
    logged_view.split(' ').last
  end
end
