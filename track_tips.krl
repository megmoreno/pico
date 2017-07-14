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
  }
  
  rule process_trip {
    select when car new_trip
    pre {
	mileage = event:attr("mileage")
    }
    send_directive("trip", {"length": mileage})
  }

}
