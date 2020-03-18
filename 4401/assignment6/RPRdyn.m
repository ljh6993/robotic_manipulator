function T = RPRdyn(aq,dq,q)
coder.extrinsic('innerfunction');
T=innerfunction(q,dq,aq);

end

