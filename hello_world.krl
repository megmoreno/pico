ruleset hello_world {
  meta {
    name "Hello World"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    shares hello
  }
  
  global {
    hello = function(obj) {
      msg = "Hello " + obj;
      msg
    }
  }
  
  rule hello {
    select when echo hello
    send_directive("say", {"something": "Hello World"})
  }

  rule message {
    select when echo message
    pre {
	input = event::attr("input")
    }
    send_directive("say", {"something":input})	
  }
  
}
