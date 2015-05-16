-module(intf).
-compile(export_all).

new()->[].

add(Name, Ref, Pid, Intf)->
	[{Name,Ref,Pid}|Intf].

remove(Name, Intf)->
	lists:keydelete(Name,1,Intf).

lookup(Name, Intf)->
		case lists:keysearch(Name, 1, Intf) of
		            {value, Tuple} ->
							{ok,element(3,Tuple)};
					false->
							notfound
	end.

ref(Name, Intf)->
	case lists:keysearch(Name, 1, Intf) of
		            {value, Tuple} ->
							{ok,element(2,Tuple)};
					false->
							notfound
	end.

name(Ref, Intf)->
		case lists:keysearch(Ref, 2, Intf) of
		            {value, Tuple} ->
							{ok,element(1,Tuple)};
					false->
							notfound
	end.

%list(Intf)-> lists:map(fun(X)->element(1,X) end , Intf).
list(Intf) ->
	list(Intf, []).
list(Intf, NameList) ->
	case Intf of
		[] ->
			NameList;
		[{Name, _, _} | T] -> list(T, [Name | NameList])
	end.


broadcast(Message, Intf)->
	case Intf of 
		[]->
			ok;
		[{_, _, Pid}|T] ->
			Pid ! Message,
			io:format("Broadcast: ~w ! ~w~n",[Pid,Message]),
			broadcast(Message,T)
	end.