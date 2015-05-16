-module(dijkstra).
-export([table/2,route/2,iterate/3,initSortedList/3,entry/2,replace/4,update/4]).

entry(Node, Sorted)->
	Sor = lists:usort(Sorted),
	case lists:keysearch(Node, 1, Sor) of
		{value, Tuple} ->
		element(2,Tuple);	
	false-> 0
	end.

replace(Node,N,Gateway,Sorted)->
	Sor = lists:keysort(2,Sorted),
	case (lists:keysearch(Node, 1, Sor)) of
		{value, Tuple} ->
				Temp = lists:keydelete(Node, 1, Sor),
				Unsorted = lists:append([{Node,N,Gateway}], Temp),
				lists:keysort(2,Unsorted);
		false ->
			io:format("There is no link")
	end.

update(Node, N, Gateway, Sorted) ->
	Length = entry(Node, Sorted),
	if 
		N < Length ->
			replace(Node,N,Gateway,Sorted);
		true ->
			Sorted
	end.


iterate(Sorted, Map, Table)->
	case Sorted of
		[]->
			Table;
		[{_,inf,_}|_]->
			Table;	
		[H|T]->
			{Node,Hops,Gateway} = H,
			
			case map:reachable(Node, Map) of
				[] ->
					iterate(T, Map, [{Node, Gateway}] ++ Table);
				ReachableNodes ->
					UpdatedList = lists:foldl(
									fun(X, AccIn) ->
											update(X, Hops + 1, Gateway, AccIn)
									end, T, ReachableNodes
											 ),
					iterate(UpdatedList, Map, [{Node, Gateway}] ++ Table)
			end
	end.




table(Gateways, Map) ->
	Nodes = map:all_nodes(Map),
	Sorted = initSortedList(Nodes,[],Gateways),
	iterate(Sorted,Map,[]).

initSortedList(List,NewList,Gateways)->
	case List of
		[]->
			lists:keysort(2, NewList);
		[H|T] ->
			case lists:member(H,Gateways) of 
				true ->
					initSortedList(T,[{H,0,H}]++NewList,Gateways);
				false->
					initSortedList(T,[{H,inf,unknown}]++NewList,Gateways)
			end
	end.


route(Name, Table) ->
	case lists:keyfind(Name,1,Table) of
		{Name, Gateway} ->
			{ok, Gateway};
		false ->
			notfound
	end.
