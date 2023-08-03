class MatchService

  def initialize
    @results = []
  end

  def self.call
    new.search
  end

  def search
    @results = DeletedDomain.find_by_sql(arel_query)
    notify unless @results.empty?
  end

  def arel_query
    deleted_domains = DeletedDomain.arel_table
    search_results = SearchResult.arel_table
    predicate = deleted_domains[:fqdn].eq( search_results[:source] )
    deleted_domains.join(search_results).on( predicate ).project(deleted_domains[:fqdn])
  end

  def notify
    pp message
    SmsService.call(message)
  end

  def message
    @results.map(&:fqdn).join
  end

end
