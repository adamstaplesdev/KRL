ruleset echo {
  meta {
    name "Echo"
    description <<
		A simple echo server
	>>
    author "Richard Adam Staples"
    logging on
    sharing on
  }
  rule hello {
    select when echo hello
    send_directive("say") with
      something = "Hello World";
  }
  rule message {
    select when echo message input "(.*)" setting(msg)
    send_directive("say") with
      something = msg;
  }
}