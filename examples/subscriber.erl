%% @copyright 2016 Choven Corp.
%%
%% This file is part of chumak.
%%
%% chumak is free software: you can redistribute it and/or modify
%% it under the terms of the GNU Affero General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% chumak is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU Affero General Public License for more details.
%%
%% You should have received a copy of the GNU Affero General Public License
%% along with chumak.  If not, see <http://www.gnu.org/licenses/>
-module(subscriber).
-export([main/1]).

main(Topic) ->
    application:start(chumak),
    {ok, Socket} = chumak:socket(sub),
    chumak:subscribe(Socket, Topic),

    case chumak:connect(Socket, tcp, "localhost", 5555) of
        {ok, _BindPid} ->
            io:format("Binding OK with Pid: ~p\n", [Socket]);
        {error, Reason} ->
            io:format("Connection Failed for this reason: ~p\n", [Reason]);
        X ->
            io:format("Unhandled reply for bind ~p \n", [X])
    end,
    loop(Socket).

loop(Socket) ->
    {ok, Data1} = chumak:recv_multipart(Socket),
    io:format("Received by multipart ~p\n", [Data1]),
    {ok, Data2} = chumak:recv(Socket),
    io:format("Received ~p\n", [Data2]),
    loop(Socket).
