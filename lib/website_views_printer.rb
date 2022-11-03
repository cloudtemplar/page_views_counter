require_relative 'website_view_counter'

class WebsiteViewsPrinter
  def initialize(views_counter: WebsiteViewCounter.new)
    @views_counter = views_counter
  end

  def call(logfile:)
    counted_views = views_counter.call(logfile: logfile)
    print_counted_views(counted_views)
  end

  private

  attr_reader :views_counter

  def print_counted_views(counted_views)
    result_string = ''

    counted_views[:total_views].each do |url, times_visited|
      result_string << "#{url} -> #{times_visited} total views\n"
    end

    result_string << "\n"

    counted_views[:unique_views].each do |url, times_visited|
      result_string << "#{url} -> #{times_visited} unique views\n"
    end

    result_string
  end
end
