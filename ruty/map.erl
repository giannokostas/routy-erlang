-module(map).
-compile(export_all).

new()-> [].

update(Node, Links, Map)->	
				case lists:keysearch(Node, 1, Map) of
		            {value, Tuple} ->
							Temp = lists:keydelete(Node, 1, Map),
							lists:append([{Node,Links}], Temp);
					false->
							lists:append([{Node,Links}], Map)
				end.

reachable(Node,Map)->
				case lists:keysearch(Node, 1, Map) of
		            {value, Tuple} ->
							element(2,Tuple);
					false->
							[]
				end.
		
all_nodes(Map)->
				{List1,List2} = lists:unzip(Map),
				Ap = lists:append(List2),
				Mer = lists:umerge(List1,Ap),
				lists:usort(Mer).
