namespace :scrapper do
  desc "Enqueue phrases for lookup in serp api"
  task phrases_lookup: :environment do
    Phrase.each do |phrase|
      PhraseLookupJob.perform_now(phrase.id)
    end
  end

  desc "Fetch deleted domains from nask list"
  task deleted_domains: :environment do
    DeletedDomainsJob.perform_now
  end

  desc "Enqueue search results for ip lookup"
  task ping: :environment do
    SearchResult.left_outer_joins(:ips).where(ips: {search_result_id: nil}).each do |result_without_known_ip|
      PingJob.perform_now(result_without_known_ip.id)
    end
  end

end
