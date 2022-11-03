# frozen_string_literal: true

require 'website_view_counter'

describe WebsiteViewCounter do
  describe '#views' do
    subject(:calculate_views) { described_class.calculate_views(logfile: logfile) }

    let(:logfile) { File.read('spec/fixtures/webserver.log') }
    let(:result) do
      {
        total_views: {
          '/help_page/1' => 7,
          '/contact' => 6,
          '/about/2' => 5,
          '/home' => 4,
          '/about' => 4,
          '/index' => 4
        },
        unique_views: {
          '/help_page/1' => 5,
          '/contact' => 5,
          '/about/2' => 4,
          '/home' => 4,
          '/about' => 4,
          '/index' => 4
        }
      }
    end

    it 'returns hash containing page urls and their visits counter ordered by visits' do
      expect(calculate_views).to eq result
    end
  end
end
