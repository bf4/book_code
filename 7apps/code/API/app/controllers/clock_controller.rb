#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
# Warning: This system is not production ready.
# It's a bit naive when it comes to timezone period boundaries.
# So, if the clock app has already loaded the time zones from
# this service, the current "period" could be daylight savings.
# Later, when it's no longer daylight savings for a given timezone
# the clock will not know to refresh the time_zones if it's still
# running with the old period.
# This is just meant to be a useful service for learning, not
# a production ready timezone service.

class ClockController < ActionController::Base
  # comment out the following line to exclude access to this API
  # from javascript not originating on this server.
  include PermissiveCorsBehavior

  def time_zones
    @zones = ActiveSupport::TimeZone.all.map do |zone|
      current_period = zone.tzinfo.current_period
      offset = zone.utc_offset + current_period.std_offset
      offset_hours = offset/3600
      offset_minutes = (offset % 3600) / 60
      {
        name: zone.name,
        zone_name: ActiveSupport::TimeZone::MAPPING[zone.name],
        offset: offset,
        formatted_offset: sprintf("%+03d:%02d", offset_hours, offset_minutes)
      }
    end
    render "clock/time_zones"
  end

end
