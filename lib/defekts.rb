require "redis"
require "sinatra"
require "yajl"
require "yaml"

require File.join( File.dirname(__FILE__), "defekts", "server" )
require File.join( File.dirname(__FILE__), "defekts", "pivotal" )

module Defekts

  configure do

    set :redis, Redis.new

    env = ENV["RACK_ENV"] || "development"

    config = YAML.load_file(File.join(                                            
      Sinatra::Application.root, "../conf/config.yml" ))[env]

    set :token, config["token"]

  end

  def self.check_synced
    return settings.redis.exists("defekts_last_sync")
  end

end

