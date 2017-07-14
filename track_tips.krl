ruleset hello_world {
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
    select when echo message
    pre {
	mileage = event:attr("mileage")
    }
    send_directive("trip", {"length": mileage})
  }

}
