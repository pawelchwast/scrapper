require "test_helper"

class DeletedDomainsJobTest < ActiveJob::TestCase

  test 'should extract current date from text' do
    VCR.use_cassette("deleted_domains") do
      job = DeletedDomainsJob.new
      job.perform_now
      assert_equal Date.current, job.date
    end
  end

  test 'should extract domains list from text' do
    VCR.use_cassette("deleted_domains") do
      domains = DeletedDomainsJob.perform_now
      assert_not_empty domains
    end
  end

  test 'should create records for all domains' do
    VCR.use_cassette("deleted_domains") do
      cnt_before = DeletedDomain.count
      domains = DeletedDomainsJob.perform_now
      cnt_after = DeletedDomain.count
      assert_equal domains.count, cnt_after - cnt_before
    end
  end

end
