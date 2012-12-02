require "pivotal-tracker"

module Defekts
  module Pivotal

    def self.get_severity(labels)

      if labels.nil?
        return -1
      elsif labels.include?("p1")
        return 1
      elsif labels.include?("p2")
        return 2
      else
        return 3
      end

    end

    def self.sync(force=false)

      if Defekts.check_synced and !force
        return
      end

      PivotalTracker::Client.token = settings.token

      @projects = PivotalTracker::Project.all

      @projects.each do |p|

        project = Project.find_by_origin_id(p.id)

        if project.nil?

          project = Project.create(
            :name => p.name,
            :origin_id => p.id )

        end

        @defekts = p.stories.all( :story_type => [ "bug" ] )

        @defekts.each do |d|

          defekt = Defekt.find_by_origin_id(d.id)

          if defekt.nil?

            severity = get_severity(d.labels)

            ndefekt = Defekt.create(
              :project_id => project.id,
              :origin_id => d.id,
              :title => d.name,
              :summary => d.description,
              :creation => d.created_at,
              :state => d.current_state,
              :severity => severity,
              :owner => d.owned_by,
              :reporter => d.requested_by )

          end

        end

      end

      settings.last_sync = Time.now

    end
  end
end

