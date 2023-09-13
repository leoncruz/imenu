# frozen_string_literal: true

module DownloadHelpers
  TIMEOUT = 10

  DOWNLOAD_PATH = Rails.root.join('tmp/downloads')

  def downloads
    Dir[DOWNLOAD_PATH.join('*')]
  end

  def downloaded_file
    File.basename downloads.first
  end

  def download_content
    wait_for_download

    File.read(downloaded_file)
  end

  def wait_for_download
    Timeout.timeout(TIMEOUT) do
      sleep 0.1 until downloaded?
    end
  end

  def downloaded?
    !downloading? && downloads.any?
  end

  def downloading?
    downloads.grep(/\.crdownload$/).any?
  end

  def clear_downloads
    FileUtils.rm_f(downloads)
  end
end
