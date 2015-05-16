-module(hist).
-compile(export_all).

new(Name)->[{Name,0}].

seen(Node,History)->
	case lists:keysearch(Node, 1, History) of
		{value,Tuple} ->
					Temp = lists:keydelete(Node, 1, History),
					lists:append([{Node,element(2,Tuple)+1}], Temp);
		false->
					lists:append([{Node,1}],History)
	end.

update(Node, N, History)->
  case lists:keysearch(Node, 1, History) of
    {value , Tuple} ->
      if
        N > element(2,Tuple) ->
          Temp = lists:keydelete(Node, 1, History),
		  {new,lists:append([{Node,N}], Temp)};
        true -> old
      end;
    false ->
      {new, new(Node)  ++ History}
  end.