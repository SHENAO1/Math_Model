#include "stdafx.h"
#include "line.h"
#include "constant.h"
#include <cmath>

LINE::LINE(POINT _a, POINT _b)
{
	a = _a;
	b = _b;
	A = b.y - a.y;
	B = a.x - b.x;
	C = b.x * a.y - a.x * b.y;
}

LINE::LINE(double _A, double _B, double _C)
{
	A = _A;
	B = _B;
	C = _C;
}

bool LINE::operator==(const LINE& _L) const
{
	return fabs(A * _L.B - _L.A * B) <= EPSILON &&
		   fabs(A * _L.C - _L.A * C) <= EPSILON &&
		   fabs(B * _L.C - _L.B * C) <= EPSILON;
}