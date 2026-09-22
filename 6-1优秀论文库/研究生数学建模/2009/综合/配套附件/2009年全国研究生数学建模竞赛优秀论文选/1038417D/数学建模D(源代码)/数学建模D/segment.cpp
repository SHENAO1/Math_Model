#include "stdafx.h"
#include "segment.h"

SEGMENT::SEGMENT(){};

SEGMENT::SEGMENT(POINT _a, POINT _b)
{
	a = _a;
	b = _b;
}

bool SEGMENT::operator == (const SEGMENT& _S) const
{
	return a == _S.a && b == _S.b;
}

bool SEGMENT::operator != (const SEGMENT& _S) const
{
	return a != _S.a || b != _S.b;
}