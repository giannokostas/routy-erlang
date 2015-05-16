-module(tester).
-export([denmark/0,peru/0,sweden/0,bsweden/0,bdenmark/0]).


denmark() ->
	routy:start(copenhagen),
	io:format("[Test] Started router 'copenhagen'~n", []),
	routy:start(odense),
	io:format("[Test] Started router 'odense'~n", []),
	routy:start(aarhus),
	io:format("[Test] Started router 'aarhus'~n", []),
	copenhagen ! {add, odense, {odense, ip()}},
	io:format("[Test] Added 'odense' to 'copenhagen'~n", []),
	odense ! {add, copenhagen, {copenhagen, ip()}},
	io:format("[Test] Added 'copenhagen' to 'odense'~n", []),
	odense ! {add, aarhus, {aarhus, ip()}},
	io:format("[Test] Added 'aarhus' to 'odense'~n", []),
	aarhus ! {add, odense, {odense, ip()}},
	io:format("[Test] Added 'odense' to 'aarhus'~n", []),
	copenhagen ! broadcast,
	timer:sleep(2000),
	odense ! broadcast,
	timer:sleep(2000),
	aarhus ! broadcast,
	timer:sleep(2000),
	copenhagen ! update,
	odense ! update,
	aarhus ! update,
	copenhagen ! {status, self()},
	timer:sleep(2000),
	aarhus ! {status, self()},
	timer:sleep(2000),
	odense ! {status, self()},
	timer:sleep(2000).

sweden() ->
	routy:start(stockholm),
	io:format("[Test] Started router 'stockholm'~n", []),
	routy:start(goteborg),
	io:format("[Test] Started router 'goteborg'~n", []),
	routy:start(malmo),
	io:format("[Test] Started router 'malmo'~n", []),
	routy:start(uppsala),
	io:format("[Test] Started router 'uppsala'~n", []),
	stockholm ! {add, malmo, {malmo, ip2()}},
	io:format("[Test] Added 'malmo' to 'stockholm'~n", []),
	malmo ! {add, stockholm, {stockholm, ip2()}},
	io:format("[Test] Added 'stockholm' to 'malmo'~n", []),
	malmo ! {add, goteborg, {goteborg, ip2()}},
	io:format("[Test] Added 'goteborg' to 'malmo'~n", []),
	goteborg ! {add, malmo, {malmo, ip2()}},
	io:format("[Test] Added 'malmo' to 'goteborg'~n", []),
	uppsala ! {add, stockholm, {stockholm, ip2()}},
	io:format("[Test] Added 'stockholm' to 'uppsala'~n", []),
	stockholm ! {add, uppsala, {uppsala, ip2()}},
	io:format("[Test] Added 'uppsala' to 'stockholm,'~n", []),
	stockholm ! broadcast,
	timer:sleep(2000),
	goteborg ! broadcast,
	timer:sleep(2000),
	malmo ! broadcast,
	timer:sleep(2000),
	uppsala ! broadcast,
	timer:sleep(2000),
	stockholm ! update,
	goteborg ! update,
	malmo ! update,
	uppsala ! update,
	stockholm ! {status, self()},
	timer:sleep(2000),
	goteborg ! {status, self()},
	timer:sleep(2000),
	malmo ! {status, self()},
	timer:sleep(2000),
	uppsala ! {status, self()},
	timer:sleep(2000).

ip() -> 'denmark@213.103.196.67'.
ip2() -> 'sweden@213.103.196.67'.

peru() ->
	routy:start(lima),
	routy:start(ica),
	lima ! {add, ica, {ica, 'peru@130.229.141.35'}},
	ica ! {add, lima, {lima, 'peru@130.229.141.35'}},
	lima ! broadcast,
	ica ! broadcast,
	lima ! update,
	ica ! update,
	ok.

bsweden()->
	stockholm ! broadcast,
	timer:sleep(2000),
	goteborg ! broadcast,
	timer:sleep(2000),
	malmo ! broadcast,
	timer:sleep(2000),
	uppsala ! broadcast,
	timer:sleep(2000),
	stockholm ! update,
	goteborg ! update,
	malmo ! update,
	uppsala ! update,
	stockholm ! {status, self()},
	timer:sleep(2000),
	goteborg ! {status, self()},
	timer:sleep(2000),
	malmo ! {status, self()},
	timer:sleep(2000),
	uppsala ! {status, self()},
	timer:sleep(2000).

bdenmark()->
	copenhagen ! broadcast,
	timer:sleep(2000),
	odense ! broadcast,
	timer:sleep(2000),
	aarhus ! broadcast,
	timer:sleep(2000),
	copenhagen ! update,
	odense ! update,
	aarhus ! update,
	copenhagen ! {status, self()},
	timer:sleep(2000),
	aarhus ! {status, self()},
	timer:sleep(2000),
	odense ! {status, self()},
	timer:sleep(2000).
