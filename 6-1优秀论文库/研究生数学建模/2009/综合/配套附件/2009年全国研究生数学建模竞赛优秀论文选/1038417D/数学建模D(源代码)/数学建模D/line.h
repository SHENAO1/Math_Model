//line.h 定义直线

#pragma once

#include "point.h"

//Ax + By + C = 0
struct LINE      
{
	POINT a, b;

	double A, B, C;
	
	LINE(POINT _a, POINT _b);

	LINE(double _A, double _B, double _C);

	bool operator==(const LINE& _L) const;
};