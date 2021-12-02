question_one:-
    read_all_lines("/code/02/input.txt", Values),
    move(Values, Horizontal, Depth),
    Result is Horizontal * Depth,
    write(Result), nl.

move(Moves, Horizontal, Depth):-
    move(Moves, 0, 0, Horizontal, Depth).

move([], Horizontal, Depth, Horizontal, Depth).
move([[forward, N] | Moves], H, D, Horizontal, Depth):-
    NewH is H + N,
    move(Moves, NewH, D, Horizontal, Depth).
move([[up, N] | Moves], H, D, Horizontal, Depth):-
    NewD is D - N,
    move(Moves, H, NewD, Horizontal, Depth).
move([[down, N] | Moves], H, D, Horizontal, Depth):-
    NewD is D + N,
    move(Moves, H, NewD, Horizontal, Depth).

question_two:-
    read_all_lines("/code/02/input.txt", Values),
    move_and_aim(Values, Horizontal, Depth),
    Result is Horizontal * Depth,
    write(Result), nl.

move_and_aim(Moves, Horizontal, Depth):-
    move_and_aim(Moves, 0, 0, 0, Horizontal, Depth).

move_and_aim([], Horizontal, Depth, _, Horizontal, Depth).
move_and_aim([[forward, N] | Moves], H, D, Aim, Horizontal, Depth):-
    NewH is H + N,
    NewD is D + Aim * N,
    move_and_aim(Moves, NewH, NewD, Aim, Horizontal, Depth).
move_and_aim([[up, N] | Moves], H, D, Aim, Horizontal, Depth):-
    NewAim is Aim - N,
    move_and_aim(Moves, H, D, NewAim, Horizontal, Depth).
move_and_aim([[down, N] | Moves], H, D, Aim, Horizontal, Depth):-
    NewAim is Aim + N,
    move_and_aim(Moves, H, D, NewAim, Horizontal, Depth).


%
% File read utils
%

read_all_lines(File, Lines):-
    open(File, read, Stream),
    read_file(Stream, Lines),
    close(Stream).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[Tuple | Lines]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, Chars),
    atom_chars(String, Chars),
    to_pair(String, Tuple),
    read_file(Stream, Lines).

read_chars(InStream,Chars):-
    get_code(InStream,Char),
    checkCharAndReadRest(Char,Chars,InStream).

checkCharAndReadRest(10,[],_):-  !.
checkCharAndReadRest(32,[],_):-  !.
checkCharAndReadRest(-1,[],_):-  !.
checkCharAndReadRest(end_of_file,[],_):-  !.
checkCharAndReadRest(Char,[Char|Chars],InStream):-
    get_code(InStream,NextChar),
    checkCharAndReadRest(NextChar,Chars,InStream).

to_pair(String, [Cmd,N]):-
    split_string(String, " ", "", [A, B]),
    string_to_atom(A, Cmd),
    string_to_atom(B, X),
    atom_number(X, N).
    
    