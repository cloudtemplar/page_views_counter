# frozen_string_literal: true

require 'website_views_printer'

describe WebsiteViewsPrinter do
  describe '#call' do
    subject(:call) { described_class.new(views_counter: website_view_counter).call(logfile: logfile) }

    let(:website_view_counter) { instance_double(WebsiteViewCounter) }
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
    let(:formatted_pages_views) do
      <<~TEXT
      /help_page/1 -> 7 total views
      /contact -> 6 total views
      /about/2 -> 5 total views
      /home -> 4 total views
      /about -> 4 total views
      /index -> 4 total views

      /help_page/1 -> 5 unique views
      /contact -> 5 unique views
      /about/2 -> 4 unique views
      /home -> 4 unique views
      /about -> 4 unique views
      /index -> 4 unique views
      TEXT
    end

    before do
      allow(website_view_counter).to receive(:call).with(logfile: logfile).and_return result
    end

    it 'calls website views counter with a logfile' do
      call
      expect(website_view_counter).to have_received(:call).with(logfile: logfile)
    end

    it 'prints formatted total and unique webpage views' do
      expect(call).to eq formatted_pages_views
    end
  end
end
