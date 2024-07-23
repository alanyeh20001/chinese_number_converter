# frozen_string_literal: true

RSpec.describe ChineseNumberConverter do
  describe "constants" do
    it "VERSION" do
      expect(ChineseNumberConverter::VERSION).not_to be nil
    end
  end

  describe ".convert_to_number" do
    context "contains compoundable units" do
      it "returns number" do
        chinese_number = "兩兆三千六百八十億七千一百二十"
        expect(described_class.convert_to_number(chinese_number)).to eq(2_368_000_007_120)
      end
    end

    context "contains zero" do
      it "returns number" do
        chinese_number = "四千零六萬三千八百"
        expect(described_class.convert_to_number(chinese_number)).to eq(40_063_800)
      end
    end

    context "contains units digit" do
      it "returns number" do
        chinese_number = "九千零二"
        expect(described_class.convert_to_number(chinese_number)).to eq(9_002)
      end
    end

    context "contains unit aliases" do
      it "returns number" do
        chinese_number = "兩佰叁拾壹億玖仟捌佰柒拾陸萬伍仟肆佰參拾貳"
        expect(described_class.convert_to_number(chinese_number)).to eq(23_198_765_432)
      end
    end
  end
end
