require "assert-activerecord/version"
require "assert-activerecord/adapter"
require "assert-activerecord/db_tests"

module AssertActiveRecord

  def self.adapter(instance = nil)
    @adapter = instance if !instance.nil?
    @adapter
  end

  def self.reset_db
    @reset_db ||= begin
      self.reset_db!
      true
    end
  end

  def self.reset_db!
    self.drop_db
    self.create_db
    self.load_schema
    self.connect_db
  end

  def self.drop_db
    self.adapter.drop_db
  end

  def self.create_db
    self.adapter.create_db
  end

  def self.load_schema
    self.adapter.load_schema
  end

  def self.connect_db
    self.adapter.connect_db
  end

  def self.transaction(&block)
    self.adapter.transaction(&block)
  end

  def self.rollback!
    self.adapter.rollback!
  end

  class DefaultAdapter
    include AssertActiveRecord::Adapter

  end

  self.adapter(DefaultAdapter.new)

end
