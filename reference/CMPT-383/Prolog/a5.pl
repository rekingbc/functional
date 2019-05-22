% Question 1
makelist(0, _, []).
makelist(N, X, [X | Rest]) :-
  N1 is N - 1,
  makelist(N1, X, Rest),
  !.


% Question 2
second_min(Lst, X) :-
  sort(Lst, [_, Min2 | _]),
  X is Min2.


% Question 3
mynumlist(Lo, Hi, []) :- Lo > Hi,
  !.
mynumlist(Lo, Hi, [X | Xs]) :-
  X is Lo,
  NewLo is Lo + 1,
  mynumlist(NewLo, Hi, Xs),
  !.


% Question 4
all_diff([]).
all_diff([X | Rest]) :-
  \+ member(X, Rest),
  all_diff(Rest).


% Question 5
negpos([], [], []).
negpos([X | Rest], [X | RestA], B) :-
  X < 0,
  negpos(Rest, RestA, B).
negpos([X | Rest], A, [X | RestB]) :-
  X >= 0,
  negpos(Rest, A, RestB),
  !.


% Question 6
magic([X1,X2,X3,X4,X5,X6,X7,X8,X9], [A1,A2,A3,B1,B2,B3,C1,C2,C3]) :-
  permutation([X1,X2,X3,X4,X5,X6,X7,X8,X9], [A1,A2,A3,B1,B2,B3,C1,C2,C3]),
  Row1 is A1 + A2 + A3,
  Row2 is B1 + B2 + B3,
  Row3 is C1 + C2 + C3,
  Col1 is A1 + B1 + C1,
  Col2 is A2 + B2 + C2,
  Col3 is A3 + B3 + C3,

  Row1 == Row2,
  Row2 == Row3,
  Row3 == Col1,
  Col1 == Col2,
  Col2 == Col3.



pellEq(X,Y,N) :-
  between(1, N, X),
  between(1, N, Y),
  X \= Y,
  Left is (X * X),
  Right is 1 + 2 * (Y * Y),
  Left == Right.
  
