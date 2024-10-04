% Knowledge Base
left_of(bay, yonge).           % bay is to the left of yonge (true)
left_of(st_george, spadina).    % st_george is to the left of spadina (true)
left_of(spadina, bathurst).     % spadina is to the left of bathurst (true)
left_of(bathurst, christie).    % bathurst is to the left of christie (true)
left_of(christie, bay).         % christie is to the left of bay (true)
left_of(st_george, bathurst).   % st_george is to the left of bathurst (true)

% Rules
west_of(X, Y) :- left_of(X, Y).
west_of(X, Y) :- left_of(X, Z), west_of(Z, Y).

% Question 1: New atomic sentence
% This is an example of an atomic sentence that is not explicitly in the knowledge base but is entailed:
% west_of(spadina, bathurst).   % This is true based on the rules.

% Question 2: Explanation
% The sentence "spadina is right of bathurst" is not entailed because based on the knowledge base,
% bathurst is to the left of spadina (spadina is west of bathurst). "Right" is interpreted as east,
% so the reverse relationship holds.

% Question 3: Trace the back-chaining procedure for the following queries:

% (3a) spadina is west of st-george:
% Query: ?- west_of(spadina, st_george).
% Answer: false. spadina is east (left) of st-george, not west.

% (3b) yonge is east of bay:
% Query: ?- west_of(yonge, bay).
% Answer: false. bay is west of yonge, not the other way around.

% (3c) christie is west of spadina:
% Query: ?- west_of(christie, spadina).
% Answer: true. christie is west (left) of bathurst, bathurst is west of spadina.

% (3d) yonge is west of yonge:
% Query: ?- west_of(yonge, yonge).
% Answer: false. This query would fail because something can't be west of itself.

% (3e) st-george is east of bathurst:
% Query: ?- west_of(st_george, bathurst).
% Answer: true. st-george is west of bathurst according to the knowledge base.

% (3f) bay is west of sherbourne:
% Query: ?- west_of(bay, sherbourne).
% Answer: false. There's no mention of sherbourne in the knowledge base, so this query would fail.

% Question 4: Changing the second conditional sentence
% If we change the rule to the following:
% west_of(X, Z) :- west_of(X, Y), left_of(Y, Z).
% This would affect the back-chaining because the query "yonge is west of yonge" would fail due to circular logic or lack of matching facts.

% Question 5: Adding incorrect sentence
% If we add the incorrect atomic sentence:
% left_of(yonge, bay).
% The knowledge base would allow invalid entailments. For example:
% Query: ?- west_of(spadina, X).
% Answer: This would allow west_of(spadina, yonge) to be true, which is incorrect based on the original data.
% Query: ?- west_of(bay, sherbourne).
% Answer: false, as no knowledge is given about sherbourne.














