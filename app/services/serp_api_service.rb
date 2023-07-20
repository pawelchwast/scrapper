require 'google_search_results'

class SerpApiService

  def initialize(phrase)
    @phrase = phrase
    @params = default_params.merge(
      {
        hl: phrase.hl,
        gl: phrase.gl,
        q: phrase.name,
        google_domain: phrase.google_domain,
      }
    )
  end

  def default_params
    {
      engine: "google",
      num: 100,
      api_key: ENV['SERP_API_KEY'],
    }
  end

  def self.call(phrase)
    new(phrase).fetch
  end

  def fetch
    search = GoogleSearch.new(@params)
    @organic_results = search.get_hash[:organic_results]
    store_results
  end

  def store_results
    @organic_results.map do |result|
      SearchResult.create(
        position: result[:position],
        source: result[:source],
        title: result[:title],
        link: result[:link],
        phrase: @phrase
      )
    end
  end

end
