# frozen-string-literal: true

require 'minitest/autorun'

describe TrueClass do
  it 'can run' do
    assert_equal 1 + 1, 2
    expect(1 + 1).must_equal 2
    expect(1 + 1).must_equal 2
  end
end
