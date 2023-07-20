require "test_helper"

class PhraseLookupJobTest < ActiveJob::TestCase
  test 'should return error if phrase is no longer active' do
    phrase = Phrase.unscoped.find_by(name: 'test')
    result = PhraseLookupJob.perform_now(phrase.id)
    assert_equal ActiveRecord::RecordNotFound, result.class
  end
end
