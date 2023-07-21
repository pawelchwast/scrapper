class PhraseLookupJob < ApplicationJob
  queue_as :default
  discard_on ActiveRecord::RecordNotFound

  def perform(phrase_id)
    @phrase = Phrase.find(phrase_id)
    return unless @phrase
    search
  end

  def search
    SerpApiService.call(@phrase)
  end
end
