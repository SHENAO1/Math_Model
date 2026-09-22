#pragma once

#include "afxtempl.h"
using namespace std;
#include "math.h"

typedef CArray<int, int>CIDArray;

class GPoint
{
public:
	GPoint()
	{
		m_ID = -1;
		x = y = 0;
		m_linkPoints.RemoveAll();
	}
	~GPoint()
	{
		m_ID = -1;
		x = y = 0;
		m_linkPoints.RemoveAll();
	}
	GPoint(GPoint &p)
	{
		m_ID = p.m_ID;
		x = p.x;
		y = p.y;
		for(int i=0;i<p.m_linkPoints.GetCount();i++)
			m_linkPoints.Add(p.m_linkPoints.GetAt(i));
	}

	GPoint operator=(GPoint &p)
	{
		m_ID = p.m_ID;
		x = p.x;
		y = p.y;
		for(int i=0;i<p.m_linkPoints.GetCount();i++)
			m_linkPoints.Add(p.m_linkPoints.GetAt(i));
		return *this;
	}
public:
	int m_ID;
	int x, y;
	CIDArray m_linkPoints;
};

typedef CArray<GPoint, GPoint> GPointsArray;

class SegmentPath
{
public:
	SegmentPath()
	{
		carId1 = -1;
		carId2 = -1;
		x1 = 0;
		y1 = 0;
		x2 = 0;
		y2 = 0;
	}
	~SegmentPath()
	{
		carId1 = -1;
		carId2 = -1;
		x1 = 0;
		y1 = 0;
		x2 = 0;
		y2 = 0;
	}
	SegmentPath(SegmentPath &sp)
	{
		carId1 = sp.carId1;
		carId2 = sp.carId2;
		x1 = sp.x1;
		y1 = sp.y1;
		x2 = sp.x2;
		y2 = sp.y2;
	}

	SegmentPath operator=(SegmentPath &sp)
	{
		carId1 = sp.carId1;
		carId2 = sp.carId2;
		x1 = sp.x1;
		y1 = sp.y1;
		x2 = sp.x2;
		y2 = sp.y2;
		return *this;
	}

	bool operator==(SegmentPath &sp)
	{
		if((((x1-sp.x1)*(x1-sp.x1) + (y1-sp.y1)*(y1-sp.y1) < 2) && 
			((x2-sp.x2)*(x2-sp.x2) + (y2-sp.y2)*(y2-sp.y2) < 2)) ||
			(((x1-sp.x2)*(x1-sp.x2) + (y1-sp.y2)*(y1-sp.y2) < 2) && 
			((x2-sp.x1)*(x2-sp.x1) + (y2-sp.y1)*(y2-sp.y1) < 2)))
			return true;
		return false;
	}

	double Length()
	{
		return sqrt((double)((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)));
	}
public:
	int carId1, carId2;
	int x1,y1,x2,y2;   //起点与终点
};

typedef CArray<SegmentPath,SegmentPath>SegmentPathArray;

class CGraphic
{
public:
	CGraphic(void);
	~CGraphic(void);
	void ReadPointsData(CString &path);
	void ReadToPoData(CString &path);
	void DensifyPoints(double length);
	void WriteData(CString &path);

	////////////////////////////////////////////////
	static double Distance(int x1, int y1, int x2, int y2);
	bool IsExsitID(int curID, int ID);
	void SearchAllLinkPoints();

public:
	int m_iEdges;
	int m_iPts;
	GPointsArray m_gPoints;
	int minX, minY, maxX, maxY;
	int m_linkAvg;                      //平均链接数
	////////////////////////////////////////////////
	double defaultLength;
	CIDArray *m_searchLinkPoints;

};














