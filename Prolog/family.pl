% Name: Tsz Yan Wong

% Making the family tree, firstly the male
male(kenneth). % Me
male(jacky).   % Brother
male(david).   % Dad
male(kenny).   % Uncle
male(gavin).   % Cousin
male(jason).   % Uncle
male(wu).      % Grandfather

% Females
female(selina).    % Cousin
female(may).       % Mom
female(karen).     % Aunt
female(lee).       % Grandmother

% Parents
parent(david, kenneth).     % Davin is the father of kenneth
parent(david, jacky).       % Father of jacky
parent(jason, gavin).       % Jason is the father of gavin
parent(jason, selina).      % Father of selina
parent(karen, gavin).
parent(karen, selina).
parent(may, kenneth).
parent(may, jacky).
parent(wu, may).
parent(wu, karen).
parent(wu, kenny).
parent(lee, may).
parent(lee, karen).
parent(lee, kenny).

% Parents and sibilings of X
father(X, Y) :- male(X), parent(X, Y).   % X is the father of Y i f X is male and X is the parent of Y
mother(X, Y) :- female(X), parent(X, Y).   % X is the mother of Y i f X is female and X is the parent of Y

% X and Y are sibilings i f they have the same parents and X and Y are not the same people
sibiling(X, Y) :- \+(X=Y), father(Z, X), father(Z, Y), mother(F, X), mother(F, Y).

% Brother and Sister
brother(X, Y) :- male(X), sibiling(X, Y).     % X is the brother of Y
sister(X, Y) :- female(X), sibiling(X, Y).    % Same idea as above

% Uncle, X is Ys uncle i f Ys parent is Xs sibiling
uncle(X, Y) :- male(X), sibiling(X, Z), parent(Z, Y).

% Aunt, same idea as above
aunt(X, Y) :- female(X), sibiling(X, Z), parent(Z, Y).

% Cousin
cousin(X, Y) :- parent(Z, X), parent(W, Y), sibiling(W, Z).




% References:
% 1) Book: Seven Languages in Seven Weeks by Bruce A. Tate
% 2) Class slides: Logic Programming
% 3) SWI Prolog: http://www.swi-prolog.org/
