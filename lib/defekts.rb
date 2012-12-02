require "active_record"
require "logger"
require "pg"
require "sinatra"
require "time"
require "yajl"
require "yaml"

require File.join( File.dirname(__FILE__), "defekts", "defekts_helper" )
require File.join( File.dirname(__FILE__), "defekts", "server" )
require File.join( File.dirname(__FILE__), "defekts", "pivotal" )
require File.join( File.dirname(__FILE__), "defekts/models", "defekt" )
require File.join( File.dirname(__FILE__), "defekts/models", "project" )
require File.join( File.dirname(__FILE__), "defekts/models", "projectdefekt" )

module Defekts

  configure do

    env = ENV["RACK_ENV"] || "development"

    config = YAML.load_file(File.join(                                            
      Sinatra::Application.root, "../conf/database.yml" ))[env]

    ActiveRecord::Base.establish_connection config

    set :last_sync, -1
    set :token, "3d26a26b680fb9fb58103187296bbc61"

  end

  before do
    #ActiveRecord::Base.connection.verify_active_connections!
  end

  def self.check_synced

    if settings.last_sync == -1
      return false
    end

    elapsed = Time.now.to_i - settings.last_sync.to_i

    if elapsed >= 3600
      return false
    else 
      return true
    end

  end

end

