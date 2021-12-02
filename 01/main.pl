question_one:-
    read_all_lines("/code/01/input.txt", Values),
    count_inc(Values, Result),
    write(Result), nl.

count_inc(L, C):- count_inc(L, [], C).
count_inc([], [], 0).
count_inc([X, Y | T], R, C):-
    (Y > X
        -> count_inc([Y|T], [X|R], C)
        ; count_inc([Y|T], R, C)
    ).
count_inc(_, R, C):- length(R, C).

question_two:-
    read_all_lines("/code/01/input.txt", Values),
    count_window_inc(Values, Result),
    write(Result), nl.

count_window_inc(L, C):- count_window_inc(L, [], C).
count_window_inc([], [], 0).
count_window_inc([X1, X2, X3, X4 | T], R, C):-
    X is X1 + X2 + X3,
    Y is X2 + X3 + X4,
    (Y > X
        -> count_window_inc([X2, X3, X4 | T], [X|R], C)
        ; count_window_inc([X2, X3, X4 | T], R, C)
    ).
count_window_inc(_, R, C):- length(R, C).


%
% File read utils
%

read_all_lines(File, Lines):-
    open(File, read, Stream),
    read_file(Stream, Lines),
    close(Stream).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_number(Stream,X),
    read_file(Stream,L).

read_number(InStream,Number):-
    get_code(InStream,Char),
    checkCharAndReadRest(Char,Chars,InStream),
    atom_codes(W,Chars),
    atom_number(W, Number).

checkCharAndReadRest(10,[],_):-  !.
checkCharAndReadRest(32,[],_):-  !.
checkCharAndReadRest(-1,[],_):-  !.
checkCharAndReadRest(end_of_file,[],_):-  !.
checkCharAndReadRest(Char,[Char|Chars],InStream):-
    get_code(InStream,NextChar),
    checkCharAndReadRest(NextChar,Chars,InStream).