ruleset see_songs_v2 {
	meta {
		name "See Songs V2"
		description <<
			Enhanced See Songs ruleset
		>>
		author "Richard Adam Staples"
		logging on
		sharing on
	}
	rule songs {
		select when echo message msg_type "song" input "(.*)" setting(msg)
		send_directive("sing")
			with song = msg;
		always{
			raise explicit event "sung"
				with song = msg;
		}
	}
	rule find_hymn {
		select when explicit sung song re/.*god.*/i
		noop();
		always{
			raise explicit event "found_hymn";
		}
	}
}