ruleset track_tips {
  meta {
    name "Track Tips"
    description <<
A first ruleset for the Quickstart
>>
    author "Megan Moreno"
    logging on
    shares hello
  }
  
  global {
    hello = function(obj) {
      msg = "Hello " + obj;
      msg
    }
    long_trip = 15
  }
  
  rule process_trip {
    select when car new_trip
    pre {
	mileage = event:attr("mileage")
    }
    send_directive("trip", {"length": mileage})
    fired{
	raise explicit event "trip_processed"
    	  attributes {"mileage":mileage}
    }
  }

  rule find_long_trips {
    select when explicit trip_processed
    pre {
	mileage = event:attr("mileage")
    }
    if(mileage > long_trip) then {
	noop()
	fired{
	  log debug "found_long_trip: "+ mileage
	  raise explicit event "found_long_trip"
	}
    }
  }
}
