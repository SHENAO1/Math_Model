#include "stdafx.h"
#include "constant.h"
#include "point.h"
#include <cmath>

POINT::POINT()
{
}
	
POINT::POINT(double _x, double _y)
{
	x = _x;
	y = _y;
}

POINT POINT::operator + (const POINT& _P) const
{
	return POINT(x + _P.x, y + _P.y);
}

POINT POINT::operator - (const POINT& _P) const
{
	return POINT(x - _P.x, y - _P.y);
}

bool POINT::operator == (const POINT& _P) const
{
	return fabs(x - _P.x) <= EPSILON && fabs(y - _P.y) <= EPSILON;
}

bool POINT::operator != (const POINT& _P) const
{
	return fabs(x - _P.x) > EPSILON || fabs(y - _P.y) > EPSILON;
}
