% Name: Tsz Yan Wong
% Burn the Witch!

female(girl).
weight(girl).
weight(duck).

% Compare the weight of the girl to the weight of the duck, if same, a witch.

same_weight(X, Y) :- weight(X) = weight(Y).
witch(X, Y) :- same_weight(X, Y).





% References:
% 1) Book: Seven Languages in Seven Weeks by Bruce A. Tate
% 2) Class slides: Logic Programming
% 3) SWI Prolog: http://www.swi-prolog.org/
