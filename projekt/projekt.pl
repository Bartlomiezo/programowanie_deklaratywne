% Program o tematyce Ksiêgarni mo¿e byæ wykorzystywany w ksiêgarniach
% internetowych w telu wyszukiwania ksi¹¿ek, jest w stanie m.in sortowaæ
% ksi¹¿ki po cenie czy wyszukiwaæ je po gatunkach
% Definicje ksi¹¿ek
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
% sprawdzaj¹c wy³¹cznie zmienn¹ odpowiedaj¹ca za gatunek ignoruj¹c
% wszystko poza gatunkiem
% czyIstniejeTakiGatunek("Fantasy)".
% true.
czyIstniejeTakiGatunek(Gatunek) :-
    ksiazka(_, _, _, Gatunek) -> write("Gatunek istnieje")
    ;
    write("Nie istnieje taki gatunek"),
    !.
% Predykat wypisuj¹cy ksi¹¿ki z danego gatunku przy u¿yciu komendy
% write i fail która odpowiada za wyszukanie kolejnej pasuj¹cej ksi¹¿ki
% pod wzglêdem gatunku
% wypiszKsiazkiZGatunku("Fantasy").
% .....
wypiszKsiazkiZGatunku(Gatunek) :-
    ksiazka(Tytul, Autor, Cena, Gatunek),
    write('Tytul: '), write(Tytul), nl,
    write('Autor: '), write(Autor), nl,
    write('Cena: '), write(Cena),write(z³), nl,
    write('Gatunek: '), write(Gatunek), nl, nl, fail.
% predykat sprawdzaj¹cy istnieje gatunek przed wypisaniem
wypiszKsiazkiZGatunku(Gatunek) :-
    \+ czyIstniejeTakiGatunek(Gatunek),
    write("Nie ma takiego gatunku proszê podaæ inny ni¿: "), write(Gatunek).
% Predykat sprawdzaj¹cy, czy istniej¹ ksi¹¿ki danego autora sprawdzaj¹c
% tylko zmienn¹ Autor i ignoruj¹c inne
% czyIstniejaKsiazkiAutora("Tolkien").
% Ksiazki autora nie istnieja
czyIstniejaKsiazkiAutora(Autor) :-
    ksiazka(_, Autor, _, _) -> write("Ksiazki autora istnieja")
    ;
    write("Ksiazki autora nie istnieja"),
    !.
% Predykat wypisuj¹cy ksi¹¿ki danego autora z u¿yciem komendy write i
% fail odpowiedaj¹cej za wyszukanie kolejnej pasuj¹cej ksi¹¿ki pod
% wzglêdem Autora
% wypiszKsiazkiAutora("J.R.R Tolkien").
% ...
wypiszKsiazkiAutora(Autor) :-
    czyIstniejaKsiazkiAutora(Autor),
    ksiazka(Tytul, Autor, Cena, Gatunek),
    write('Tytul: '), write(Tytul), nl,
    write('Autor: '), write(Autor), nl,
    write('Cena: '), write(Cena), nl,
    write('Gatunek: '), write(Gatunek), nl, nl, fail.
% Predykat sprawdzaj¹cy czy dany autor istnieje u¿ywaj¹c negacji \+
wypiszKsiazkiAutora(Autor) :-
    \+ czyIstniejaKsiazkiAutora(Autor),
    write('Nie znaleziono ksi¹¿ek autorstwa '), write(Autor).
% Predykat zbieraj¹cy wszystkie ksi¹¿ki w liœcie w celu wykorzystania w
% innych predykatach
zbierzKsiazki(L) :- findall((Cena, Tytul, Autor, Gatunek), ksiazka(Tytul, Autor, Cena, Gatunek), L).
% Predykat do sortowania ksi¹¿ek wed³ug ceny
sortujKsiazkiPoCenie :-
    zbierzKsiazki(L),
    sort(1, @=<, L, Sorted),
    wypiszKsiazki(Sorted).
% Predykat zbieraj¹cy wszystkie ksi¹¿ki danego gatunku w liœcie w celu
% wykorzystania w innym predykacie
zbierzKsiazkiZGatunku(Gatunek, L) :-
    findall((Cena, Tytul, Autor, Gatunek), ksiazka(Tytul, Autor, Cena, Gatunek), L).
% Predykat do sortowania ksi¹¿ek wed³ug ceny z danego gatunku
sortujKsiazkiPoCenieZGatunku(Gatunek) :-
    zbierzKsiazkiZGatunku(Gatunek, L),
    sort(1, @=<, L, Sorted),
    wypiszKsiazki(Sorted).
% predykat sprawdzaj¹cy czy dany gatunek istnieje przed sortowaniem
sortujKsiazkiPoCenieZGatunku(Gatunek) :-
    \+ czyIstniejeTakiGatunek(Gatunek),
    write('Nie znaleziono ksi¹¿ek z gatunku '), write(Gatunek), nl.
% Predykat wypisuj¹cy ksi¹¿ki z listy
wypiszKsiazki([(Cena, Tytul, Autor, Gatunek)|T]) :-
    write('Tytul: '), write(Tytul), nl,
    write('Autor: '), write(Autor), nl,
    write('Cena: '), write(Cena), nl,
    write('Gatunek: '), write(Gatunek), nl, nl,
    wypiszKsiazki(T).
%Predykat uruchamij¹cy interfejs testuj¹cy dzia³anie predykatów
start:-
    menu.
menu:-
    writeln("---MENU---"),
    writeln("Dostepne opcje"),
    writeln("1. Czy gatunek istnieje"),
    writeln("2. Wypisz wszystkie pozycje z danego gatunku"),
    writeln("3. Czy ksi¹¿ki autora istniej¹"),
    writeln("4. Wypisanie wszystkich ksi¹¿ek autora"),
    writeln("5. Sortowanie wed³ug ceny"),
    writeln("6. Sortuj wed³ug ceny i gatunku"),
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

