% Program o tematyce Ksi�garni mo�e by� wykorzystywany w ksi�garniach
% internetowych w telu wyszukiwania ksi��ek, jest w stanie m.in sortowa�
% ksi��ki po cenie czy wyszukiwa� je po gatunkach
% Definicje ksi��ek
ksiazka("Wladca Pierscieni", "J.R.R Tolkien", 15, "Fantasy").
ksiazka("littlewomen", "alcott", 11, "Powiesc").
ksiazka("Sherlock Holmes", "A.C Doyle", 12, "Detektywistyczna").
ksiazka("Harry Potter", "J.K Rowling", 17, "Fantasy").
ksiazka("Hobbit", "J.R.R Tolkien", 15, "Fantasy").
ksiazka("Zbrodnia i Kara", "Fiodor Dostojewski", 15, "Powiesc").
ksiazka("Duma i uprzedzenie", "Jane Austen", 12, "Powiesc").
ksiazka("Ballada Ptakow i Wezy", "Suzanne Collins", 11, "Fantasy").
ksiazka("Znak Czterek", "A.C Doyle", 11, "Detektywistyczna").
ksiazka("Dziewczyna z tatuazem smoka", "Stieg Larsson", 19, "Detektywistyczna").
%Predykat sprawdzajacy czy dany gatunek istnieje
% sprawdzaj�c wy��cznie zmienn� odpowiedaj�ca za gatunek ignoruj�c
% wszystko poza gatunkiem
% czyIstniejeTakiGatunek("Fantasy)".
% true.
czyIstniejeTakiGatunek(Gatunek) :-
    ksiazka(_, _, _, Gatunek) -> write("Gatunek istnieje")
    ;
    write("Nie istnieje taki gatunek"),
    !.
% Predykat wypisuj�cy ksi��ki z danego gatunku przy u�yciu komendy
% write i fail kt�ra odpowiada za wyszukanie kolejnej pasuj�cej ksi��ki
% pod wzgl�dem gatunku
% wypiszKsiazkiZGatunku("Fantasy").
% .....
wypiszKsiazkiZGatunku(Gatunek) :-
    ksiazka(Tytul, Autor, Cena, Gatunek),
    write('Tytul: '), write(Tytul), nl,
    write('Autor: '), write(Autor), nl,
    write('Cena: '), write(Cena),write(z�), nl,
    write('Gatunek: '), write(Gatunek), nl, nl, fail.
% predykat sprawdzaj�cy istnieje gatunek przed wypisaniem
wypiszKsiazkiZGatunku(Gatunek) :-
    \+ czyIstniejeTakiGatunek(Gatunek),
    write("Nie ma takiego gatunku prosz� poda� inny ni�: "), write(Gatunek).
% Predykat sprawdzaj�cy, czy istniej� ksi��ki danego autora sprawdzaj�c
% tylko zmienn� Autor i ignoruj�c inne
% czyIstniejaKsiazkiAutora("Tolkien").
% Ksiazki autora nie istnieja
czyIstniejaKsiazkiAutora(Autor) :-
    ksiazka(_, Autor, _, _) -> write("Ksiazki autora istnieja")
    ;
    write("Ksiazki autora nie istnieja"),
    !.
% Predykat wypisuj�cy ksi��ki danego autora z u�yciem komendy write i
% fail odpowiedaj�cej za wyszukanie kolejnej pasuj�cej ksi��ki pod
% wzgl�dem Autora
% wypiszKsiazkiAutora("J.R.R Tolkien").
% ...
wypiszKsiazkiAutora(Autor) :-
    czyIstniejaKsiazkiAutora(Autor),
    ksiazka(Tytul, Autor, Cena, Gatunek),
    write('Tytul: '), write(Tytul), nl,
    write('Autor: '), write(Autor), nl,
    write('Cena: '), write(Cena), nl,
    write('Gatunek: '), write(Gatunek), nl, nl, fail.
% Predykat sprawdzaj�cy czy dany autor istnieje u�ywaj�c negacji \+
wypiszKsiazkiAutora(Autor) :-
    \+ czyIstniejaKsiazkiAutora(Autor),
    write('Nie znaleziono ksi��ek autorstwa '), write(Autor).
% Predykat zbieraj�cy wszystkie ksi��ki w li�cie w celu wykorzystania w
% innych predykatach
zbierzKsiazki(L) :- findall((Cena, Tytul, Autor, Gatunek), ksiazka(Tytul, Autor, Cena, Gatunek), L).
% Predykat do sortowania ksi��ek wed�ug ceny
sortujKsiazkiPoCenie :-
    zbierzKsiazki(L),
    sort(1, @=<, L, Sorted),
    wypiszKsiazki(Sorted).
% Predykat zbieraj�cy wszystkie ksi��ki danego gatunku w li�cie w celu
% wykorzystania w innym predykacie
zbierzKsiazkiZGatunku(Gatunek, L) :-
    findall((Cena, Tytul, Autor, Gatunek), ksiazka(Tytul, Autor, Cena, Gatunek), L).
% Predykat do sortowania ksi��ek wed�ug ceny z danego gatunku
sortujKsiazkiPoCenieZGatunku(Gatunek) :-
    zbierzKsiazkiZGatunku(Gatunek, L),
    sort(1, @=<, L, Sorted),
    wypiszKsiazki(Sorted).
% predykat sprawdzaj�cy czy dany gatunek istnieje przed sortowaniem
sortujKsiazkiPoCenieZGatunku(Gatunek) :-
    \+ czyIstniejeTakiGatunek(Gatunek),
    write('Nie znaleziono ksi��ek z gatunku '), write(Gatunek), nl.
% Predykat wypisuj�cy ksi��ki z listy
wypiszKsiazki([(Cena, Tytul, Autor, Gatunek)|T]) :-
    write('Tytul: '), write(Tytul), nl,
    write('Autor: '), write(Autor), nl,
    write('Cena: '), write(Cena), nl,
    write('Gatunek: '), write(Gatunek), nl, nl,
    wypiszKsiazki(T).
%Predykat uruchamij�cy interfejs testuj�cy dzia�anie predykat�w
start:-
    menu.
menu:-
    writeln("---MENU---"),
    writeln("Dostepne opcje"),
    writeln("1. Czy gatunek istnieje"),
    writeln("2. Wypisz wszystkie pozycje z danego gatunku"),
    writeln("3. Czy ksi��ki autora istniej�"),
    writeln("4. Wypisanie wszystkich ksi��ek autora"),
    writeln("5. Sortowanie wed�ug ceny"),
    writeln("6. Sortuj wed�ug ceny i gatunku"),
    writeln("0. Zakoncz dzialanie"),
    write("Wybierz opcje: "),
    read(Wybor),
    zrob(Wybor).
zrob(1):-
    write("Wpisz gatunek: "),
    read(Gatun),
    czyIstniejeTakiGatunek(Gatun),
    nl,
    menu.
zrob(2):-
    write("Wpisz gatunek: "),
    read(Gatunek),
    wypiszKsiazkiZGatunku(Gatunek),
    nl,
    menu.
zrob(3):-
    write("Wpisz autora: "),
    read(Auto),
    czyIstniejaKsiazkiAutora(Auto),
    nl,
    menu.
zrob(4):-
    write("Wpisz autora: "),
    read(Auto),
    wypiszKsiazkiAutora(Auto),
    nl,
    menu.
zrob(5):-
    sortujKsiazkiPoCenie,
    nl,
    menu.
zrob(6):-
    write("Wpisz gatunek: "),
    read(Gatun),
    sortujKsiazkiPoCenieZGatunku(Gatun),
    nl,
    menu.
zrob(0):-
    write("Do widzenia").
%zrob(_):-
 %   write("Blad, wpisz ponownie"),
  %  nl,
   % nl,
   % menu.

