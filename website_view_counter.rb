# frozen_string_literal: true

require_relative 'lib/website_views_printer'

logfile = File.read(ARGV[0])
print WebsiteViewsPrinter.new.call(logfile: logfile)
