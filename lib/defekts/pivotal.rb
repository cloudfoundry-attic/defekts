require "pivotal-tracker"

module Defekts
  module Pivotal
    def self.sync

      if Defekts.check_synced
        return
      end

      PivotalTracker::Client.token = settings.token

      @projects = PivotalTracker::Project.all

      @projects.each do |p|

        if !settings.redis.hexists( "projects", p.id )
          settings.redis.hset( "projects", p.id, p.name )
        end

        @defekts = p.stories.all( :story_type => [ 'bug' ] )

        @defekts.each do |b|

          if !settings.redis.hexists( "defekts", b.id )
            settings.redis.hset( "defekts", b.id, b.inspect )
          end

        end

      end

      settings.redis.set( "defekts_last_sync", "" )
      settings.redis.expire( "defekts_last_sync", 3600 )

    end
  end
end

