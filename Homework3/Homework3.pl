/* Family Relations Exercise - Paksh Patel */

/* Facts - Family Relationships */
child(alberto, guido).    child(alberto, antonietta).
child(giulia, enrico).    child(giulia, annamaria).
child(dante, marco).      child(clara, marco).
child(dante, laura).      child(clara, laura).
child(marco, alberto).    child(marco, giulia).
child(laura, lawrence).   child(laura, julie).
child(emily, lawrence).   child(emily, julie).
child(claire, lawrence).  child(claire, julie).
child(sam, emily).        child(ben, emily).
child(sam, dave).         child(ben, dave).
child(eve, claire).       child(annabelle, claire).
child(eve, ed).           child(annabelle, ed).
child(giulio, guido).     child(donata, giulio).
child(sara, donata).      child(marco2, donata).
child(giulio, antonietta).child(gioia, clara).

male(guido).
male(enrico).
male(marco).
male(dante).
male(alberto).
male(lawrence).
male(sam).
male(ben).
male(dave).
male(ed).
male(giulio).
male(marco2).

female(antonietta).
female(annamaria).
female(clara).
female(laura).
female(giulia).
female(julie).
female(emily).
female(claire).
female(eve).
female(annabelle).
female(donata).
female(sara).
female(gioia).

/* Define parent/2 based on child/2 */
parent(X, Y) :- child(Y, X).

/* 1. mother, grand_parent, and great_grand_mother */
mother(X, Y) :-
    female(X),
    child(Y, X).

grand_parent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

great_grand_mother(X, Y) :-
    mother(X, Z),
    parent(Z, A),
    parent(A, Y).

/* Example usage and expected answers:
?- mother(X, alberto).
% Expected: X = antonietta.

?- grand_parent(X, marco).
% Expected: X = guido ; X = antonietta ; X = enrico ; X = annamaria.

?- great_grand_mother(X, ben).
% Expected: X = annamaria. If this fails, verify the connections of Julie and her mother.
*/

/* 2. sibling, brother, and sister */
sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

brother(X, Y) :-
    sibling(X, Y),
    male(X).

sister(X, Y) :-
    sibling(X, Y),
    female(X).

/* Example usage and expected answers:
?- sibling(dante, clara).
% Expected: true.

?- brother(marco, laura).
% Expected: false.

?- sister(giulia, marco).
% Expected: false.
*/

/* 3. half_sibling and full_sibling */
half_sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y,
    not((parent(A, X), parent(A, Y))).

full_sibling(X, Y) :-
    sibling(X, Y),
    parent(A, X),
    parent(A, Y).

/* Example usage and expected answers:
?- half_sibling(giulio, clara).
% Expected: false.

?- full_sibling(dante, clara).
% Expected: true.
*/

/* 4. first_cousin and second_cousin */
first_cousin(X, Y) :-
    parent(A, X),
    parent(B, Y),
    sibling(A, B).

second_cousin(X, Y) :-
    parent(A, X),
    parent(B, Y),
    first_cousin(A, B).

/* Example usage and expected answers:
?- first_cousin(sam, eve).
% Expected: true.

?- second_cousin(sara, ben).
% Expected: false.
*/

/* 5. half_first_cousin and double_first_cousin */
half_first_cousin(X, Y) :-
    parent(A, X),
    parent(B, Y),
    half_sibling(A, B).

double_first_cousin(X, Y) :-
    parent(A, X),
    parent(B, Y),
    sibling(A, B),
    sibling(_, _).

/* Example usage and expected answers:
?- half_first_cousin(sara, eve).
% Expected: false.

?- double_first_cousin(dante, marco).
% Expected: false.
*/

/* 6. first_cousin_once_removed and first_cousin_twice_removed */
first_cousin_once_removed(X, Y) :-
    first_cousin(X, Z),
    parent(Z, Y).

first_cousin_twice_removed(X, Y) :-
    first_cousin(X, Z),
    grand_parent(Z, Y).

/* Example usage and expected answers:
?- first_cousin_once_removed(sam, marco2).
% Expected: true.

?- first_cousin_twice_removed(sam, donata).
% Expected: false.
*/

/* 7. descendant and ancestor */
descendant(X, Y) :-
    child(X, Y).

descendant(X, Y) :-
    child(X, Z),
    descendant(Z, Y).

ancestor(X, Y) :-
    descendant(Y, X).

/* Example usage and expected answers:
?- descendant(marco, guido).
% Expected: true.

?- ancestor(guido, marco).
% Expected: true.
*/

/* 8. cousin */
cousin(X, Y) :-
    parent(A, X),
    parent(B, Y),
    (sibling(A, B); cousin(A, B)).

/* Example usage and expected answers:
?- cousin(sam, eve).
% Expected: true.
*/

/* 9. closest_common_ancestor */
closest_common_ancestor(X, Y, Z) :-
    ancestor(X, Y),
    ancestor(X, Z),
    not((child(A, X), ancestor(A, Y), ancestor(A, Z))).

/* Example usage and expected answers:
?- closest_common_ancestor(X, sam, eve).
% Expected: X = claire.
*/

/* 10. write_descendant_chain */
write_descendant_chain(X, Y) :-
    descendant(X, Y),
    write_chain(X, Y).

write_chain(X, Y) :-
    child(X, Z),
    write(X), write(' is a child of '), write(Z), nl,
    write_chain(Z, Y).

write_chain(X, Y) :-
    child(X, Y),
    write(X), write(' is a child of '), write(Y), nl.

/* Example usage and expected output:
?- write_descendant_chain(sam, guido).
% Expected output:
% sam is a child of emily
% emily is a child of julie
% julie is a child of guido
*/
