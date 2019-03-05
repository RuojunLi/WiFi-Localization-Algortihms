function b = ge_solve(b,A,pvt)
%
% Produces the solution of Ax = b by overwriting b with the 
% solution. 
%
% Inputs:
%  b     = right-hand side vector. 
%  A     = matrix returned from Gaussian elimination, either 
%	   naive or with partial pivoting.
%  pvt   = vector of pivot information returned from Gaussian 
%	   elimination with partial pivoting, if that is used. 
%
% Output:
%  b     = vector containing the solution of Ax = b.
%
if nargin < 2, error('\n Not enough arguments.\n'); end

n = size(A,1);
if n ~= size(A,2), error('\n The matrix must be square.\n'); end
if size(b) ~= [n,1], error('\n A and b have incompatible dimensions.\n'); end 

% Prepare b. 
for k = 1:n-1, 
% If partial pivoting has been used, exchange components of b. 
  if nargin == 3, 
    if pvt(k,1) > k, 
      temp = b(k,1);
      b(k,1) = b(pvt(k,1),1);
      b(pvt(k,1),1) = temp;
    end
  end
% Perform the row operations on b. 
  b(k+1:n,1) = b(k+1:n,1) + b(k,1)*A(k+1:n,k);
end

% Form the solution using back-substitution. 
b(n,1) = A(n,n)\b(n,1);
for i = n-1:-1:1
  b(i,1) = A(i,i)\(b(i,1) - A(i,i+1:n)*b(i+1:n));
end