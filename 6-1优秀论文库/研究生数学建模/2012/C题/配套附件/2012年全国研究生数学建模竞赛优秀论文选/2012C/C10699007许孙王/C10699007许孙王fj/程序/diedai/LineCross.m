function cross = LineCross(line1, line2)

A1=line1(1); B1=line1(2); C1=line1(3);
A2=line2(1); B2=line2(2); C2=line2(3);
cross = [(B1*C2-B2*C1)/(A1*B2-A2*B1), -(A1*C2-A2*C1)/(A1*B2-A2*B1)];

end
