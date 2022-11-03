# frozen_string_literal: true

require_relative 'lib/website_view_counter'

logfile = File.read(ARGV[0])
p WebsiteViewCounter.calculate_views(logfile: logfile)
