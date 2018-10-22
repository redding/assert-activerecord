module AssertActiveRecord

  module Adapter

    def test_env_name
      "test"
    end

    def drop_db
      raise NotImplementedError
    end

    def create_db
      raise NotImplementedError
    end

    def load_schema
      raise NotImplementedError
    end

    def connect_db
      raise NotImplementedError
    end

    def transaction(&block)
      raise NotImplementedError
    end

    def rollback!
      raise NotImplementedError
    end

  end

end
