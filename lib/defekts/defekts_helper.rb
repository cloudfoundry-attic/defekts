module Defekts

  class Analysis

    def self.get_trend(days=5)

      trend = Array.new
      # TODO: skip sat sun
      for i in 1..days

        day = Array.new

        day.push( Date::ABBR_MONTHNAMES[(Date.today - i).month] + " " +
          (Date.today - i).day.to_s )

        c = Defekt.where( :day => Date.today - i, :state => "accepted" )
        o = Defekt.where( :day => Date.today - i, :state => [ "unstarted",
          "unscheduled", "started", "finished", "rejected", "delivered" ] )
        n = Defekt.where( :day => Date.today - i, :state => [ "unscheduled",
          "unstarted" ] )

        day.push(c.count)
        day.push(o.count)
        day.push(n.count)

        trend.push(day)

      end

      return trend

    end

  end

end

