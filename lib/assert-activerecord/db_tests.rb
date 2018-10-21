require "assert"
require "assert-activerecord"

module AssertActiveRecord

  class DbTests < Assert::Context
    around do |block|
      AssertActiveRecord.transaction do
        block.call
        AssertActiveRecord.rollback!
      end
    end
  end

end
