#pragma once

#include "constant.h"
#include "point.h"
#include "data.h"
#include "segment.h"
#include <vector>

struct calculate
{
	DATA data;
	double Dis[MAX_N][MAX_N];
	POINT Special[3];
	std::vector<SEGMENT> S[3];
	int rCar1[CARNUMBER];			//每辆警车负责的区域
	int rCar2[CARNUMBER];			//每辆警车负责的区域
	int rCar3[CARNUMBER];			//每辆警车负责的区域
	int nCar1, nCar2, nCar3;
	double totalLength;
	POINT patrol[240][CARNUMBER];	//保存巡逻方案
	int road_id[240][CARNUMBER];	//保存每个时刻的车所在的道路
	POINT next[240][CARNUMBER];		//保存每个时刻的车所要到达的交叉点
	int curNCar;					//当前方案的车辆数
	double A, B, P1, P2, Z, H, J;

	calculate();

	void Init();

	//FLOYD求最短路
	void Floyd();

	//计算重点位置
	void Calc_Special_Point();		

	//计算据I点距离为L的区域
	std::vector<SEGMENT> Cover_Region1(const POINT &I, int id, double L);

	//计算据I点距离为L的区域(只包括完整的道路)
	std::vector<SEGMENT> Cover_Region2(const POINT &I, int id, double L);

	void Shortest_Road(const POINT& p, int &id, POINT & I);

	//巡逻方案1
	void Patrol1(int rCar[CARNUMBER], int nCar);

	//巡逻方案2
	void Patrol2(int rCar[CARNUMBER], int nCar);

	//巡逻方案3
	void Patrol3(int rCar[CARNUMBER], int nCar);

	//巡逻方案4
	void Patrol4();

	double Get_Min(int r, int curCar, int cur);

	//遍历道路
	void dfs(int road_id, const POINT &cur, int a, int b);

	//道路上两点的最短距离
	double Rmin(const POINT &a, const POINT &b);

	//寻找点a所在的道路编号
	int Road_Id(const POINT &a);

	void Test();

	void Evaluate1();
	void Evaluate2();
	void Evaluate3();

	//随机选择一个道路上的点
	POINT Rand_Select();

	//随机选择一个指定区域内道路上的点
	POINT Rand_Select(int region);

	int Get_Road_Car(int cur, int r);

	//隐蔽性
	double Hide();
};