require "test_helper"

class PingJobTest < ActiveJob::TestCase

  test 'should fetch 127.0.0.1 for localhost' do
    search_results = SearchResult.find_by(source: 'localhost')
    job = PingJob.new(search_results.id)
    job.perform_now
    assert_equal '127.0.0.1', job.instance_variable_get(:@ip)
  end

  test 'should create one record for ip' do
    search_results = SearchResult.first
    assert_difference 'Ip.count' do
      PingJob.perform_now(search_results.id)
    end
  end

end
