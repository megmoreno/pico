ruleset trip_store {
  meta {
    name "Track Tips"
    description <<
A first ruleset for the Quickstart
>>
    author "Megan Moreno"
    logging on
    shares trips, long_trips, short_trips
    provides trips, long_trips, short_trips
  }
  
  global {
    
	trips = function() {
		ent:tripArray
	}

	long_trips = function() {
		ent:longTripArray
	}

	short_trips = function() {
		ent:tripArray.difference(ent:longTripArray)
	}

  }
  
  rule collect_trips {
    select when explicit processed_trip
    pre {
	mileage = event:attr("mileage")
	timestamp = event:attr("timestamp")
    }
    always {
	ent:tripArray := ent:tripArray.append({"mileage":mileage, "timestamp":timestamp})
    }
    
  }

  rule collect_long_trips {
    select when explicit found_long_trip
    pre {
	mileage = event:attr("mileage")
        timestamp = event:attr("timestamp")
    }
    always {
	ent:longTripArray := ent:tripArray.append({"mileage":mileage, "timestamp":timestamp})
    } 
  }

  rule clear_trips {
    select when car trip_reset
    always {
	ent:tripArray := ent:tripArray.clear()
	ent:longTripArray := ent:longTripArray.clear()
    }
  }
}
