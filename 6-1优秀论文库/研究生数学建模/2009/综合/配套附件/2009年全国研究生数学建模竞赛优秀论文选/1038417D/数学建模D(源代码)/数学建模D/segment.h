//segment.h ∂®“Âœﬂ∂Œ

#pragma once

#include "point.h"

struct SEGMENT
{
	POINT a, b;

	SEGMENT();
	
	SEGMENT(POINT _a, POINT _b);

	bool operator == (const SEGMENT& _S) const;

	bool operator != (const SEGMENT& _S) const;
};
