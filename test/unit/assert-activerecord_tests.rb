require "assert"
require "assert-activerecord"

module AssertActiveRecord

  class UnitTests < Assert::Context
    desc "AssertActiveRecord"
    setup do
      @module = AssertActiveRecord
    end
    subject{ @module }

    should have_imeths :adapter
    should have_imeths :reset_db, :reset_db!
    should have_imeths :drop_db, :create_db, :load_schema, :connect_db

    should "set the DefaultAdapter as its adapter by default" do
      assert_instance_of DefaultAdapter, AssertActiveRecord.adapter
    end

    should "call to the adapter for its adapter methods" do
      assert_raises(NotImplementedError){ subject.drop_db }
      assert_raises(NotImplementedError){ subject.create_db }
      assert_raises(NotImplementedError){ subject.load_schema }
      assert_raises(NotImplementedError){ subject.connect_db }
    end

  end

  class ResetDbTests < UnitTests
    desc "when resetting the db"
    setup do
      @adapter_spy = AdapterSpy.new
      Assert.stub(AssertActiveRecord, :adapter){ @adapter_spy }
    end

    should "run adapter cmds to reset the db only once" do
      assert_equal [], @adapter_spy.cmds_called

      subject.reset_db

      exp = ["drop_db", "create_db", "load_schema", "connect_db"]
      assert_equal exp, @adapter_spy.cmds_called

      subject.reset_db

      exp = ["drop_db", "create_db", "load_schema", "connect_db"]
      assert_equal exp, @adapter_spy.cmds_called
    end

    should "force re-run adapter cmds to reset the db" do
      assert_equal [], @adapter_spy.cmds_called

      subject.reset_db!

      exp = ["drop_db", "create_db", "load_schema", "connect_db"]
      assert_equal exp, @adapter_spy.cmds_called

      subject.reset_db!

      exp = [
        "drop_db", "create_db", "load_schema", "connect_db",
        "drop_db", "create_db", "load_schema", "connect_db"
      ]
      assert_equal exp, @adapter_spy.cmds_called
    end

  end

  class DefaultAdapterTests < UnitTests
    desc "DefaultAdapter"
    setup do
      @class = DefaultAdapter
    end
    subject{ @class }

    should "mixin AssertActiveRecord::Adapter" do
      assert_includes AssertActiveRecord::Adapter, subject
    end

  end

  class AdapterSpy
    include AssertActiveRecord::Adapter

    attr_reader :cmds_called

    def initialize
      @cmds_called = []
    end

    def drop_db
      self.cmds_called << "drop_db"
    end

    def create_db
      self.cmds_called << "create_db"
    end

    def load_schema
      self.cmds_called << "load_schema"
    end

    def connect_db
      self.cmds_called << "connect_db"
    end

  end

end
