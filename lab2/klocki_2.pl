% PROGRAM: klocki_2
% Baza wiedzy o uk³adzie klocków
% Definowane predykaty:
% na/2
%     pod/2
%     miêdzy/2
%===================================


% na(X,Y)
% opis: spe³niony, gdy klocek X le¿y
% bezpoœrednio na klocku Y
%     pod(X,Y)
% opis: spe³niony, gdy klocek X le¿y
% bezpoœrednio pod klockiem Y
% miêdzy(X,Y,Z)
% opis: spe³niony, gdy klocek X le¿y miêdzy
% klockami Y i Z
% ==================================na/2
na(c,a).
na(c,b).
na(d,c).
       pod(X,Y):-na(Y,X).
       miêdzy(X,Y,Z):-na(Z,X),na(X,Y).
       miêdzy(X,Y,Z):-na(Y,X),na(X,Z).

% ==================================na/2

/*
Informacje o budowie programu:
Program sk³ada siê z 6 klauzul.
Program zawiera 3 definicje relacji.
S¹ to relacje na/2, pod/2 i miêdzy/3.
Definicja relacji na/2 sk³ada siêz 3 klauzul, które s¹ faktami.
Definicja relacji pod/2 sk³ada siê z 1 klauzuli, która jest regu³¹.
Definicja relacji miêdzy/3 sk³ada siê z 2 klauzul, które s¹ regu³ami.
*/
