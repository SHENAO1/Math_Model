//point.h ∂®“Âµ„

#pragma once

struct POINT
{
public:
	double x, y;
	
	POINT();
	
	POINT(double _x, double _y);

	POINT operator + (const POINT& _P) const;

	POINT operator - (const POINT& _P) const;

	bool operator == (const POINT& _P) const;

	bool operator != (const POINT& _P) const;

};

typedef POINT VECTOR;