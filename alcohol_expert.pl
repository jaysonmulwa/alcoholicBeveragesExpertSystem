
go :- hypothesize(Alcohol),
       write('The Alcohol was identified as: '),
       write(Alcohol), nl, undo.

 /* hypotheses to be tested */
/*Exclamation mark turns off backtracking*/
hypothesize(beer) :- beer, !.
hypothesize(wine) :- wine, !.
hypothesize(rum) :- rum, !.
hypothesize(whiskey) :- whiskey, !.
hypothesize(brandy) :- brandy, !.
hypothesize(gin) :- gin, !.
hypothesize(vodka) :- vodka, !.
hypothesize(unknown). /* no diagnosis */


/* animal identification rules */
beer :- non_spirit,

              verify(has_froth).
wine :- non_spirit,

            verify(has_no_froth).
rum :- spirit, sweet,

               verify(is_sweet).
whiskey :- spirit, non_sweet,
             verify(is_non_sweet),
             verify(has_colour),
             verify(has_aftertaste).
brandy :- spirit,non_sweet,

               verify(is_non_sweet),
                verify(has_colour),
               verify(has_no_aftertaste).
gin :- spirit,non_sweet,

                 verify(is_non_sweet),
                 verify(has_no_color),
                 verify(has_aroma).
vodka :- spirit,non_sweet,

                   verify(is_non_sweet),
                   verify(has_no_colour),
                   verify(has_no_aroma).

/* classification rules */

spirit :- verify(spirit_>20).
non_spirit :- verify(non_spirit_<20).
sweet :- verify(is_sweet).
non_sweet:- verify(is_non_sweet).

/* how to ask questions */
ask(Question) :-
        write('Does the Alcohol have the following attribute: '),
        write(Question), write('? '),
         read(Response), nl,
         ( (Response == yes ; Response == y)
         -> assert(yes(Question)) ;
         assert(no(Question)), fail).
:- dynamic yes/1,no/1.

/* How to verify something */
verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.



