require "assert"
require "assert-activerecord/adapter"

module AssertActiveRecord::Adapter

  class UnitTests < Assert::Context
    desc "AssertActiveRecord::Adapter"
    setup do
      @module = AssertActiveRecord::Adapter
    end
    subject{ @module }

  end

  class InitTests < UnitTests
    desc "when init"
    setup do
      adapter_class = Class.new do
        include AssertActiveRecord::Adapter
      end
      @adapter = adapter_class.new
    end
    subject{ @adapter }

    should have_imeths :test_env_name
    should have_imeths :drop_db, :create_db, :load_schema, :connect_db
    should have_imeths :transaction, :rollback!

    should "know its test env name" do
      assert_equal "test", subject.test_env_name
    end

    should "not implement its adapter methods" do
      assert_raises(NotImplementedError){ subject.drop_db }
      assert_raises(NotImplementedError){ subject.create_db }
      assert_raises(NotImplementedError){ subject.load_schema }
      assert_raises(NotImplementedError){ subject.connect_db }
      assert_raises(NotImplementedError){ subject.transaction }
      assert_raises(NotImplementedError){ subject.rollback! }
    end

  end

end
