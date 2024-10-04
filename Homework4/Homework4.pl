% Question 2:
% Draw a map of central Europe consisting of the following seven countries:
% France, Switzerland, Italy, Belgium, Holland, Germany, and Austria.
% Color the countries on the map using just red, yellow, and orange;
% no two countries with a border between them can be the same color.
% Look at an existing map to see where the borders are,
% and then write a Prolog program that will find a color for each country.

color(red).
color(yellow).
color(orange).

euromap(France, Switzerland, Italy, Belgium, Holland, Germany, Austria) :-
    color(France),
    color(Switzerland),
    color(Italy),
    color(Belgium),
    color(Holland),
    color(Germany),
    color(Austria),
    France \= Switzerland, France \= Italy, France \= Belgium, France \= Germany,
    Switzerland \= Italy, Switzerland \= Germany, Switzerland \= Austria, Switzerland \= France,
    Italy \= France, Italy \= Switzerland, Italy \= Austria,
    Belgium \= France, Belgium \= Germany, Belgium \= Holland,
    Holland \= Belgium, Holland \= Germany,
    Germany \= France, Germany \= Switzerland, Germany \= Belgium, Germany \= Holland, Germany \= Austria,
    Austria \= Switzerland, Austria \= Italy, Austria \= Germany.

% Solution:
% euromap(France, Switzerland, Italy, Belgium, Holland, Germany, Austria).
% France = Holland, Holland = Austria, Austria = red,
% Switzerland = Belgium, Belgium = yellow,
% Italy = Germany, Germany = orange

% Question 3:
% Use Prolog to solve the cryptarithmetic puzzle CROSS + ROADS = DANGER.
% Note: If you are not careful with the ordering of constraints in your program,
% the program could run for hours. With a proper ordering, it should only take a second or so.
% Define the cryptarithmetic puzzle: CROSS + ROADS = DANGER

puzzlesolution([C,R,O,S,A,D,N,G,E]):-
    % Assigning possible values to each letter
    D = 1,
    member(C,[1,2,3,4,5,6,7,8,9]),
    member(R,[0,1,2,3,4,5,6,7,8,9]),
    member(O,[0,1,2,3,4,5,6,7,8,9]),
    member(S,[0,1,2,3,4,5,6,7,8,9]),
    member(A,[0,1,2,3,4,5,6,7,8,9]),
    member(N,[0,1,2,3,4,5,6,7,8,9]),
    member(G,[0,1,2,3,4,5,6,7,8,9]),
    member(E,[0,1,2,3,4,5,6,7,8,9]),

    % Constraints
    CROSS is C*10000 + R*1000 + O*100 + S*10 + S,
    ROADS is R*10000 + O*1000 + A*100 + D*10 + S,
    DANGER is D*100000 + A*10000 + N*1000 + G*100 + E*10 + R,
    CROSS + ROADS =:= DANGER,
    write(CROSS + ROADS = DANGER), nl.

% Solution:
% puzzlesolution([C,R,O,S,A,D,N,G,E]).
% 18244+82014=100258
% C = D, D = 1,
% R = 8,
% O = G, G = 2,
% S = 4,
% A = N, N = 0,
% E = 5

% Question 4:
% Consider the following problem:
% Donna, Danny, David, and Doreen were seated at a table in a restaurant.
% The men sat across from each other, as did the women.
% They each ordered a different main course with a different beverage.
% In addition,
% –	Doreen sat beside the person who ordered steak.
% –	The chicken came with a Coke.
% – The person with the lasagna sat across from the person with milk.
% - David never drinks coffee.
% –	Donna only drinks water.
% - Danny could not afford to order steak.
% Who ordered the pizza?
% Write a Prolog program that solves this problem by displaying who ordered each of the
% main courses and each of the beverages. Hint: Begin by writing clauses defining predicates beside(x,y),
% which holds if person x is sitting beside person y, and across(x,y),
% which holds if person x is sitting across from person y.

% Define the 4 possible positions
pos(1). pos(2). pos(3). pos(4).

% Define 'beside' relationship
beside(A, B) :- pos(A), pos(B), (A =:= B + 1; A =:= B - 1; A =:= B + 3; A =:= B - 3).

% Define 'across' relationship
across(A, B) :- pos(A), pos(B), (A =:= B + 2; A =:= B - 2).

% Main predicate: zebra
whoatepizza(Donna, Danny, David, Doreen, Steak, Lasagna, Pizza, Chicken, Coke, Milk, Coffee, Water) :-
    % Clue 1: Doreen sat beside the person who ordered steak
    beside(Doreen, Steak),

    % Clue 2: The chicken came with a Coke
    Chicken = Coke,

    % Clue 3: The person with the lasagna sat across from the person with milk
    across(Lasagna, Milk),

    % Clue 4: Donna only drinks water
    Donna = Water,

    % Men and women sat across from each other
    across(David, Danny),
    across(Doreen, Donna),

    % Ensure uniqueness for all positions
    uniq_pos(Steak, Lasagna, Pizza, Chicken),
    uniq_pos(Coke, Milk, Coffee, Water),
    uniq_pos(Donna, Danny, David, Doreen),

    % Clue 5: David never drinks coffee
    \+ David = Coffee,

    % Clue 6: Danny didn't order steak
    \+ Danny = Steak,

    % Output who ordered each meal and drink
    print_order(Donna, 'Donna', Pizza, Steak, Lasagna, Chicken),
    print_order(Danny, 'Danny', Pizza, Steak, Lasagna, Chicken),
    print_order(David, 'David', Pizza, Steak, Lasagna, Chicken),
    print_order(Doreen, 'Doreen', Pizza, Steak, Lasagna, Chicken),

    % Identify who ordered the pizza
    identify_pizza_owner(Pizza, Donna, Danny, David, Doreen).

% All 4 items are in unique positions
uniq_pos(A, B, C, D) :-
    pos(A), pos(B), pos(C), pos(D),
    \+ A = B, \+ A = C, \+ A = D,
    \+ B = C, \+ B = D,
    \+ C = D.

% Helper predicate to print out the order for each person
print_order(PersonPos, PersonName, Pizza, Steak, Lasagna, Chicken) :-
    (PersonPos = Pizza -> format('~w ordered the Pizza.~n', [PersonName]);
     PersonPos = Steak -> format('~w ordered the Steak.~n', [PersonName]);
     PersonPos = Lasagna -> format('~w ordered the Lasagna.~n', [PersonName]);
     PersonPos = Chicken -> format('~w ordered the Chicken.~n', [PersonName])).

% Helper predicate to identify who ordered pizza
identify_pizza_owner(PizzaPos, Donna, Danny, David, Doreen) :-
    (PizzaPos = Donna -> format('Donna ordered the Pizza!~n');
     PizzaPos = Danny -> format('Danny ordered the Pizza!~n');
     PizzaPos = David -> format('David ordered the Pizza!~n');
     PizzaPos = Doreen -> format('Doreen ordered the Pizza!~n')).

% Solution:
% whoatepizza(Donna, Danny, David, Doreen, Steak, Lasagna, Pizza, Chicken, Coke, Milk, Coffee, Water).
% Donna ordered the Pizza.
% Danny ordered the Lasagna.
% David ordered the Steak.
% Doreen ordered the Chicken.
% Donna ordered the Pizza!
% Donna = Pizza, Pizza = Water, Water = 3,
% Danny = Lasagna, Lasagna = Coffee, Coffee = 4,
% David = Steak, Steak = Milk, Milk = 2,
% Doreen = Chicken, Chicken = Coke, Coke = 1