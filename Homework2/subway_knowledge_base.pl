
% Knowledge Base based on the figure 2.6
left_of(bay, yonge).
left_of(spadina, st_george).
left_of(christie, bathurst).
left_of(bathurst, spadina).
left_of(st_george, bay).

% Define west_of based on left_of
west_of(X, Y) :- left_of(X, Y).
west_of(X, Y) :- left_of(X, Z), west_of(Z, Y).

% 1. Example of an atomic sentence not in the knowledge base but entailed by it:
% - 'yonge is west of st_george'
% This is because bay is left of yonge, and st_george is left of bay, so by transitivity, 
% yonge is west of st_george.

% 2. Explain why 'spadina is right of bathurst' is not entailed:
% The knowledge base only has left_of and west_of relations. Right is the inverse of left, 
% but we do not have the inverse defined explicitly.

% 3. Back-chaining procedure on the following queries:

% 3a. spadina is west of st_george
% ?- west_of(spadina, st_george).
% Answer: Yes (spadina is left_of st_george).

% 3b. yonge is east of bay
% ?- west_of(bay, yonge).
% Answer: Yes (bay is left_of yonge).

% 3c. christie is west of spadina
% ?- west_of(christie, spadina).
% Answer: Yes (christie is left_of bathurst, bathurst is left_of spadina).

% 3d. yonge is west of yonge
% ?- west_of(yonge, yonge).
% Answer: No (nothing can be west of itself in this case).

% 3e. st_george is east of bathurst
% ?- west_of(bathurst, st_george).
% Answer: No (no path shows bathurst is west of st_george).

% 3f. bay is west of sherbourne
% ?- west_of(bay, sherbourne).
% Answer: No (sherbourne is not in the knowledge base).

% 4. Changing the second conditional rule:
% The change will not affect what is entailed; it’s just another way of chaining west_of relations.
% Specifically, query 'yonge is west of yonge' will still return No.

% 5. Suppose we add the incorrect atomic sentence 'yonge is left of bay':
% It will create inconsistencies. Now 'spadina is west of X' will be entailed for X = yonge, bay, etc.
% The back-chaining for 'bay is west of sherbourne' would still return No since sherbourne is not in the knowledge base.

% Set up protocol to log output
:- protocol('logfile.txt').
:- noprotocol.

