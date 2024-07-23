# frozen_string_literal: true

require_relative "chinese_number_converter/version"

module ChineseNumberConverter
  class Error < StandardError; end

  CHINESE_NUMBER_MAPPINGS = {
    '九' => 9, '玖' => 9, '八' => 8, '捌' => 8, '七' => 7, '柒' => 7, '六' => 6, '陸' => 6, '五' => 5,
    '伍' => 5, '四' => 4, '肆' => 4, '三' => 3, '參' => 3, '叁' => 3, '二' => 2, '貳' => 2, '兩' => 2,
    '一' => 1, '壹' => 1
  }.freeze
  CHINESE_COMPOUNDABLE_UNIT_MAPPINGS = {
    '兆' => 1_000_000_000_000, '億' => 100_000_000, '萬' => 10_000
  }.freeze
  CHINESE_UNIT_MAPPINGS = {
    '千' => 1000, '仟' => 1000, '百' => 100, '佰' => 100, '十' => 10, '拾' => 10
  }.freeze
  CHINESE_COMPOUNDABLE_UNITS_DESC = CHINESE_COMPOUNDABLE_UNIT_MAPPINGS.keys
  CHINESE_UNITS_DESC = CHINESE_UNIT_MAPPINGS.keys

  def self.convert_to_number(chinese_number)
    chars = chinese_number.chars
    group = {}
    CHINESE_COMPOUNDABLE_UNITS_DESC.each do |unit|
      if (unit_index = chars.index(unit))
        set = chars.slice!(0..unit_index)
        group[CHINESE_COMPOUNDABLE_UNIT_MAPPINGS[set.pop]] = set.join
      end
      break if chars.length.zero?
      if chars.length <= 2
        group[1] = chars.join.gsub('零')
        break
      end
    end
    if group.empty? || chars.length > 0
      group[1] = chars.join
    end

    group.map do |base_unit, str|
      chars = str.chars
      chars.delete('零')
      sub_sum = chars.each_slice(2).map do |number, unit|
        if unit
          CHINESE_NUMBER_MAPPINGS[number] * CHINESE_UNIT_MAPPINGS[unit]
        else
          CHINESE_NUMBER_MAPPINGS[number]
        end
      end.sum
      base_unit * sub_sum
    end.sum
  end
end
