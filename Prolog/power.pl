% Name: Tsz Yan Wong
% Simple numerical computations

% The power is 0, 0th power of anything is 1
power(X, 0, 1) :- X > 0.

% The base is 0, 0 to any power is always 0
power(0, Y, 0) :- Y > 0.

% The base and the exponent are greater than 0
% Calculate the result by calling itself recursively and passing its power-1 as exponent
% For example: 2^3 = 2x(2^2) = 2x2x(2^1) = 8 => store it in P
power(X, Y, P) :- Z is Y - 1, power(X, Z, Temp), P is Temp * X.








% References:
% 1) Book: Seven Languages in Seven Weeks by Bruce A. Tate
% 2) Class slides: Logic Programming
% 3) SWI Prolog: http://www.swi-prolog.org/
