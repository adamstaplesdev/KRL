ruleset song_store {
	meta {
		name "Song Store"
		description <<
			Song storage
		>>
		author "Richard Adam Staples"
		logging on
		sharing on
		provides songs, hymns, secular_music
	}
	global {
		songs = function() {
			song_map = ent:all_songs.encode()
			song_map
		};
		hymns = function() {
			hymn_map = ent:all_hymns.encode()
			hymn_map
		};
		secular_music = function() {
			hymn_array = ent:all_hymns.values();
			secular_map = ent:all_songs.filter(
				function(key, song){
					nothymn = hymn_array.reduce(
						function(res, hymn){
							(res && (hymn == song))
						},
						true
					)
					nothymn
				}
			)
			secular_map
		};
	}
	rule collect_songs {
		select when explicit sung song "(.*)" setting(msg)
		pre {
			timestamp = time:now();
			songs_map = ent:all_songs || {};
			new_songs_map = songs_map.put(timestamp, msg);
		}
		noop();
		fired{
			set ent:all_songs new_songs_map;
		}
	}
	rule collect_hymns {
		select when explicit found_hymn hymn "(.*)" setting(msg)
		pre {
			timestamp = time:now();
			hymns_map = ent:all_hymns || {};
			new_hymns_map = hymns_map.put(timestamp, msg);
		}
		noop();
		fired{
			set ent:all_hymns new_hymns_map;
		}
	}
	rule clear_songs {
		select when song reset
		noop();
		fired{
			clear ent:all_songs;
			clear ent:all_hymns;
		}
	}
}