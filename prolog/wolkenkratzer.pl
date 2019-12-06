:- use_module(library(clpfd)).

verify(0, _, _, _).
verify(N, [], _, N).
verify(N, [H|T], M, C):- H #> M, CT #= C + 1, verify(N, T, H, CT).
verify(N, [0|T], M, C):- verify(N, T, M, C).
verify(N, [H|T], M, C):- H #< M, verify(N, T, M, C).

% Lista e Lista de Listas
verify_rows([], []).
verify_rows([H|T], [R|W]):- verify(H, R, 0, 0), verify_rows(T, W).

reverseInList([],[]).
reverseInList([H|Ts],[H1|R]):-
      reverse(H,H1),
      reverseInList(Ts,R).

% transpor e tudo mais
verify_all([H|T], M):- verify_all([H|T], M, 1).
verify_all([H|T], M, 1):- transpose(M,MT), verify_rows(H, MT), verify_all(T, M, 2).
verify_all([H|T], M, 2):- reverseInList(M,MI), verify_rows(H, MI), verify_all(T, M, 3).
verify_all([H|T], M, 3):- transpose(M,MT), reverseInList(MT,MTI), verify_rows(H, MTI), verify_all(T, M, 4).
verify_all([H|[]], M, 4):- verify_rows(H, M).



vs(5, [[0, 3, 3, 0, 0], [3, 2, 3, 0, 1], [0, 2, 2, 2, 1], [1, 4, 3, 2, 0]]).
vs(6, [[4, 1, 2, 2, 3, 2], [2, 4, 2, 3, 1, 4],[1, 3, 5, 2, 4, 2], [2, 3, 3, 4, 2, 1]]).
vs(7, [[0, 4, 3, 4, 2, 4], [3, 2, 0, 3, 1, 2],[4,1,4,0,4,2],[0,4,0,2,3,2]]).

vs(4, [[4, 0, 0, 0], [3, 2, 0, 0], [0, 2, 2, 0], [0, 2, 2, 1]]).

vs(8, [[0, 0, 1, 2], [0, 3, 3, 0], [0, 2, 2, 0], [0, 0, 0, 0]]).

vs(31,  [[3, 0, 2, 0, 1], [1, 0, 0, 0, 0], [0, 0, 0, 1, 4], [5, 2, 0, 3, 4]]).
vs(41,  [[2, 3, 2, 2, 1, 3], [2, 3, 2, 1, 2, 2], [3, 1, 3, 2, 4, 2], [5, 1, 3, 2, 4, 2]]).

% Com espaço em branco
vs(18,  [[2, 3, 2, 3, 1], [1, 3, 2, 2, 3], [3, 1, 2, 1, 3], [2, 1, 3, 3, 2]]).
% Nao sei se roda
vs(300, [[2, 3, 1, 2, 3, 2], [4, 1, 3, 5, 2, 4], [2, 1, 3, 3, 2, 2], [2, 3, 3, 1, 3, 2]]).
vs(299, [[3, 3, 1, 2, 3, 1], [1, 2, 2, 2, 3, 4], [1, 2, 4, 3, 3, 5], [3, 2, 2, 3, 1, 1]]).





wolkenkratzer(Rows, Size, Lower, Upper, VsSky) :-
        length(Rows, Size), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins Lower..Upper,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns), maplist(all_distinct, Columns),
        vs(VsSky,V), verify_all(V, Rows).

wolkenkratzer(Rows, Size, Lower, Upper, VsSky, true) :-
        length(Rows, Size), maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins Lower..Upper,
        maplist(all_distinct, Rows),
        transpose(Rows, Columns), maplist(all_distinct, Columns),
        check_diag(Rows),
        vs(VsSky,V), verify_all(V, Rows).



%% Examples:

%% time(wolkenkratzer(R, 5, 1, 5, 5)), maplist(writeln, R).
%% % 388,023,953 inferences, 29.771 CPU in 29.772 seconds (100% CPU, 13033486 Lips)
%% [5,3,1,4,2]
%% [1,2,3,5,4]
%% [3,4,5,2,1]
%% [4,5,2,1,3]
%% [2,1,4,3,5]

%% time(wolkenkratzer(R, 6, 1, 6, 41)), maplist(writeln, R).
%% % 42,052,648 inferences, 3.067 CPU in 3.067 seconds (100% CPU, 13712832 Lips)
%% [1,3,4,5,6,2]
%% [6,2,3,4,5,1]
%% [3,5,6,1,2,4]
%% [5,1,2,3,4,6]
%% [2,4,5,6,1,3]
%% [4,6,1,2,3,5]

%% 0 = blank space
%% time(wolkenkratzer(R, 5, 0, 4, 18)), maplist(writeln, R).
%% % 60,693,208 inferences, 4.540 CPU in 4.540 seconds (100% CPU, 13369349 Lips)
%% [3,0,1,2,4]
%% [4,2,0,3,1]
%% [2,3,4,1,0]
%% [0,1,2,4,3]
%% [1,4,3,0,2]
