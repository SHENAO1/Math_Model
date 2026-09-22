#include "stdafx.h"

#include "data.h"
#include <iostream>
#include <fstream>

using namespace std;

DATA::DATA()
{
}

void DATA::Input()
{
	ifstream fcin1("in.txt");
	fcin1 >> n;
	int t;
	for(int i = 0; i < n; i ++)
	{
		fcin1 >> t >> points[i].x >> points[i].y;
	}
	memset(bConnect, 0, sizeof(bConnect));
	
	Road r;

	while(fcin1 >> r.a >> r.b)
	{
		r.a--;
		r.b--;
		roads.push_back(r);
		bConnect[r.a][r.b] = true;
		bConnect[r.b][r.a] = true;
	}
	
	fcin1.close();

	ifstream fcin2("Region.txt");
	Region region;
	int road_id;
	while(fcin2 >> region.nRoad)
	{
		for(int i = 0; i < region.nRoad; i ++)
		{
			fcin2 >> t >> road_id;
			region.roads_id.push_back(road_id);
		}
		regions.push_back(region);
		region.roads_id.clear();
	}
	fcin2.close();
}