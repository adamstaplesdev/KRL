ruleset see_songs {
  meta {
    name "See Songs"
    description <<
		Sings songs
	>>
    author "Richard Adam Staples"
    logging on
    sharing on
  }
  rule songs {
    select when echo message input "(.*)" setting(msg)
    send_directive("sing") with
      song = msg;
  }
}