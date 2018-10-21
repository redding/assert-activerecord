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

    should "know its test env name" do
      assert_equal "test", subject.test_env_name
    end

    should "not implement its drop db method" do
      assert_raises(NotImplementedError){ subject.drop_db }
    end

    should "not implement its create db method" do
      assert_raises(NotImplementedError){ subject.create_db }
    end

    should "not implement its load schema method" do
      assert_raises(NotImplementedError){ subject.load_schema }
    end

    should "not implement its connect db method" do
      assert_raises(NotImplementedError){ subject.connect_db }
    end

  end

end
