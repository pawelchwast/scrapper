require 'resolv'

class PingJob < ApplicationJob
  queue_as :default

  IP_REGEX = /(#{Resolv::IPv4::Regex256})\.(#{Resolv::IPv4::Regex256})\.(#{Resolv::IPv4::Regex256})\.(#{Resolv::IPv4::Regex256})/


  def perform(search_result_id)
    @search_result = SearchResult.find(search_result_id)
    fetch
    store_result
  end

  def fetch
    ping = `ping -c 1 #{@search_result.source}`
    @ip = ping.match(IP_REGEX).to_s
  end

  def store_result
    Ip.create(search_result: @search_result, address: @ip)
  end
end
