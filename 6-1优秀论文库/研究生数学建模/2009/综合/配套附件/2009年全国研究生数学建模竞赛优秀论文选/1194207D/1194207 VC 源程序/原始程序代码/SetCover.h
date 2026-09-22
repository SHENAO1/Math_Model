#pragma once
#include ".\graphic.h"
#include "math.h"
#include "iostream"
#include "afxtempl.h"
using namespace std;

typedef CArray<int, int>IntArray;

class CarNode
{
public:
	CarNode()
	{
		m_priority = 100;
		m_origID = -1;
	}
	~CarNode()
	{
		m_priority = 100;
		m_origID = -1;
	}
	CarNode(CarNode &car)
	{
		m_priority = car.m_priority;
		m_origID = car.m_origID;
	}

	CarNode operator=(CarNode &car)
	{
		m_priority = car.m_priority;
		m_origID = car.m_origID;
		return *this;
	}
public:
	int m_priority;
	int m_origID;   //节点原始实际序号
};

typedef CArray<CarNode,CarNode>CarNodeArray;

class PathPoint
{
public:
	PathPoint()
	{
		x = 0;
		y = 0;
	}
	~PathPoint()
	{
		x = 0;
		y = 0;
	}
	PathPoint(PathPoint &pp)
	{
		x = pp.x;
		y = pp.y;
	}

	PathPoint operator=(PathPoint &pp)
	{
		x = pp.x;
		y = pp.y;
		return *this;
	}

	bool operator==(PathPoint &pp)
	{
		if((x-pp.x)*(x-pp.x) + (y-pp.y)*(y-pp.y) < 2)
			return true;
		return false;
	}
public:
	int x,y;   
};

typedef CArray<PathPoint,PathPoint>PathPointArray;

class CSetCover
{
public:
	CSetCover(void);
	~CSetCover(void);

	void ReadData(CString &path);

	void ReadBanery(CString &path);

	void GetModS();
	void GetK();
	int  ReGetK(int cl);
	void GetP();
	void GetR();

	bool CheckIn(int col1, int col2);
	void InitProcess();

	bool Check(int col);

	bool Finish();
	void GetF();

	void SCHF();

	///////////////////////////////////////////////////////////////////
	//贪心策略检测
	bool Check(IntArray &cover);
	void Greedy();
	///////////////////////////////////////////////////////////////////

	///////////////////////////////////////////////////////////////////
	//巡逻策略
	void ShowPoliceCarMove(int icar, int tim);  //表示m_cover中的序号；4小时-240分钟 tim=240

	///////////////////////////////////////////////////////////////////
	//计算巡逻指标值
	//第三问
	void GetTargetThree();

public:
	int row,col;
	int **m_Matrix;
	int **m_tmpMatrix;

	int N;

	///////////////////////////////////////////////////////////////////
	bool *m_flag;
	int *m_ModS;
	int *m_K;
	int *m_P;
	int *m_R;
	int *m_weight;
	int *m_space;

	double L;
	double *m_F;
	int minSID, maxSID;
	IntArray m_cover;
	IntArray SValue;

	///////////////////////////////////////////////////////////////////
	CGraphic m_graphic;

	///////////////////////////////////////////////////////////////////////////////
	//巡逻策略
	CarNodeArray m_carNodes;
	IntArray     *m_linkList;

	SegmentPathArray *m_pathArray;
	PathPointArray   *m_pathPointsArray;

	///////////////////////////////////////////////////////////////////////////////
	//问题三的4个巡逻指标
	float m_avgAll;     //单位时间内每一条路被走过后得到的道路的平均次数
	float m_fReGo;      //单位时间内所有点中被重复次数与平均走过的次数的标准差
	float m_avgTime;    //每个节点发生事件后，警车到达事发地点的平均时间
	float m_fPath;      //单位时间内每一条路被走过后得到的道路的覆盖率
	
};
