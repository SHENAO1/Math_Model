#pragma once

#include "point.h"
#include "constant.h"
#include <vector>

struct Road
{
	int a, b;
};

struct Region
{
	int nRoad;
	std::vector<int> roads_id;	//µÀÂ·±àºÅ
};

struct DATA
{
	int n;
	POINT points[MAX_N];
	bool  bConnect[MAX_N][MAX_N];
	std::vector<Road> roads;
	
	DATA();

	void Input();

	std::vector<Region> regions;	//ÇøÓò
};