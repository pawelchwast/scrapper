namespace :scrapper do
  desc "Enqueue phrases for lookup in serp api"
  task phrases_lookup: :environment do
    Phrase.where("1=1").each do |phrase|
      PhraseLookupJob.perform_later(phrase.id)
    end
  end

  desc "Fetch deleted domains from dns list"
  task deleted_domains: :environment do
    DeletedDomainsJob.perform_later
  end

  desc "Enqueue search results for ip lookup"
  task ping: :environment do
    SearchResult.left_outer_joins(:ips).where(ips: {search_result_id: nil}).each do |result_without_known_ip|
      PingJob.perform_later(result_without_known_ip.id)
    end
  end

  desc "Notify matched domains"
  task match: :environment do
    MatchService.call
  end

end
