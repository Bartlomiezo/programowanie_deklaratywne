% Rekurencja
% Silnia: 0!=1, n!=n*(n-1)!
% Silnia(N,S)
% S=N!
% warunek zakoñczenia rekurencji
silnia(0,1).
% rekurencja
silnia(N,S):-
    N>0,
    N1 is N-1,
    silnia(N1, S1),
    S is N*S1.
