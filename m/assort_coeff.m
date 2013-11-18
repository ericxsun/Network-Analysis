function ra = assort_coeff(edgeL, directed)
%ASSORT_COEFF Calculate the assortativity coefficient.
%   ra = ASSORT_COEFF(edgeL, directed, 'edgeL') returns the assortativity
%   coefficient of a given graph described by the edge list. The 
%   directionality of the graph is defined by the value of 'directed'.
%
%   Algorithm:
%
%   Note:
%   1. Each line in edgeL is expressed as [src dst weight] or [src dst], 
%      where 'src', 'dst' and 'weight' stand for nodes index at the ends of 
%      an edge and its weight respectively. The node index starts at zero.
%
%   Example:
%
%   Ref:
%   1.Newman M E J. Assortative mixing in networks[J]. Physical Review 
%     Letters, 2002, 89(20): 208701.
%
%   See also:
%

%   Author: Eric x. sun
%   Email:  followyourheart1211@gmail.com
%   $Date:  2012/07/31 15:25$
%

%--------------------------------------------------------------------------

assert(size(edgeL, 2) >= 2, 'The edgeL must contain 2 columns at least.');
[~, edgeL] = issimple(edgeL, directed, 'edgeL');

edgeL = edgeL(:, 1:2);
if min(min(edgeL)) == 0
    edgeL = edgeL + 1;
end
    
E = size(edgeL, 1);
    
if not(directed)
    deg = degrees(edgeL, directed, 'edgeL');
        
    jk       = 0;
	jkmean   = 0;
	jksquare = 0;

    for i = 1 : E
        u = edgeL(i, 1);
        v = edgeL(i, 2);

        deg_u = deg(u, 2);
        deg_v = deg(v, 2);

        jk       = jk + deg_u * deg_v;
        jkmean   = jkmean + deg_u + deg_v;
        jksquare = jksquare + deg_u^2 + deg_v^2;
    end

	ra = (4*E*jk - jkmean^2) / (2*E*jksquare - jkmean^2);        
else
    error('Not implemented.'); 
end

%--------------------------------------------------------------------------
end