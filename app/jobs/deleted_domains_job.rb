class DeletedDomainsJob < ApplicationJob
  queue_as :default

  SERVICE_URL = 'https://www.dns.pl/deleted_domains.txt'

  def perform
    fetch
    parse_response
    store_results
  end

  def fetch
    @response = HTTParty.get(SERVICE_URL)
  end

  def parse_response
    @date_line, _, *@domains = @response.split("\n")
  end

  def store_results
    @domains.map do |fqdn|
      DeletedDomain.find_or_create_by(date: date, fqdn: fqdn)
    end
  end

  def date
    Date.parse @date_line
  end
end
