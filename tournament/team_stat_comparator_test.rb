require 'ostruct'
require 'minitest/autorun'
require_relative './team_stat_comparator'

class TeamStatComparatorTest < Minitest::Test
  def andy
    @andy ||= OpenStruct.new(name: 'Andy', points: 2)
  end

  def barbara
    @barbara ||= OpenStruct.new(name: 'Barbara', points: 1)
  end

  def carl
    @carl ||= OpenStruct.new(name: 'Coral', points: 2)
  end

  def test_compare_with_point_difference
    subject = TeamStatComparator.compare andy, barbara
    assert_equal -1, subject
    subject = TeamStatComparator.compare barbara, andy
    assert_equal 1, subject
  end

  def test_compare_with_same_points_different_names
    subject = TeamStatComparator.compare andy, carl
    assert_equal -1, subject
    subject = TeamStatComparator.compare carl, andy
    assert_equal 1, subject
  end

  def test_compare_with_same_points_and_name
    subject = TeamStatComparator.compare andy, andy.dup
    assert_equal 0, subject
  end

  def test_name_score
    subject = TeamStatComparator.new andy, barbara
    assert_equal -1, subject.name_score
    subject = TeamStatComparator.new barbara, andy
    assert_equal 1, subject.name_score
    subject = TeamStatComparator.new andy, andy.dup
    assert_equal 0, subject.name_score
  end

  def test_point_score
    subject = TeamStatComparator.new andy, barbara
    assert_equal -1, subject.point_score
    subject = TeamStatComparator.new barbara, andy
    assert_equal 1, subject.point_score
    subject = TeamStatComparator.new andy, andy.dup
    assert_equal nil, subject.point_score
  end

  def test_raw_point_score
    subject = TeamStatComparator.new andy, barbara
    assert_equal -1, subject.raw_point_score
    subject = TeamStatComparator.new barbara, andy
    assert_equal 1, subject.raw_point_score
    subject = TeamStatComparator.new andy, andy.dup
    assert_equal 0, subject.raw_point_score
  end
end
