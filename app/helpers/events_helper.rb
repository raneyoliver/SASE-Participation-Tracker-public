# Helper functions for events controller
module EventsHelper

  #returns an array of form ids
  def serialize_event(event)
    
    return {
      **event.attributes.symbolize_keys,
      forms: Form.where({event_id: event.id}).select("id")
    }
  end

  def makeUniqueID()
    # previous method
    #id = DateTime.now.strftime("%Y%m%d%k%M%S%L") # date in ms
    #return id.to_i.to_s(36)
    #return id.to_i(36)

    # unique id based on date, hexadecimal. Using first 10 characters only
    return Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
  end

end
