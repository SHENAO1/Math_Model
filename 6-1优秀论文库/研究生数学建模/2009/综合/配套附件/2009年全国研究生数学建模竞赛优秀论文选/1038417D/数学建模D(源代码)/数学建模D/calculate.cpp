#include "stdafx.h"
#include "calculate.h"
#include "geometry.h"
#include <iostream>
#include <iomanip>
#include <fstream>
#include <ctime>

using namespace std;

calculate::calculate()
{
}

void calculate::Init()
{
	for(int i = 0; i < data.n; i ++)
	{
		for(int j = 0; j < data.n; j ++)
		{
			if(i == j)
			{
				Dis[i][j] = 0.0;
			}
			else
			{
				if(!data.bConnect[i][j])
				{
					Dis[i][j] = INFINITY;
				}
				else
				{
					Dis[i][j] = Distance(data.points[i], data.points[j]);
				}
			}
		}
	}
	Floyd();

	Special[0].x = 5112.0;
	Special[0].y = 4806.0;
	Special[1].x = 9126.0;
	Special[1].y = 4266.0;
	Special[2].x = 7434.0;
	Special[2].y = 1332.0;

	totalLength = 0.0;
	for(size_t i = 0; i < data.roads.size(); i ++)
	{
		int a = data.roads[i].a;
		int b = data.roads[i].b;
		totalLength += Distance(data.points[a], data.points[b]);
	}

	//分配警车1
	rCar1[0] = 0;
	rCar1[1] = 1;
	rCar1[2] = 2;
	rCar1[3] = rCar1[4] = rCar1[5] = rCar1[6] = 3;
	rCar1[7] = rCar1[8] = 4;
	rCar1[9] = 5;
	rCar1[10] = rCar1[11] = 6;
	rCar1[12] = rCar1[13] = rCar1[14] = 7;
	rCar1[15] = rCar1[16] = rCar1[17] = 8;
	rCar1[18] = rCar1[19] = 9;
	rCar1[20] = rCar1[21] = 10;
	rCar1[22] = rCar1[23] = rCar1[24] = 11;
	rCar1[25] = rCar1[26] = rCar1[27] = 12;
	rCar1[28] = rCar1[29] = 13;

	//分配警车2
	rCar2[0] = 0;
	rCar2[1] = 1;
	rCar2[2] = 2;
	rCar2[3] = rCar2[4] = 3;
	rCar2[5] = 4;
	rCar2[6] = 5;
	rCar2[7] = rCar2[8] = 6;
	rCar2[9] = rCar2[10] = rCar2[11] = 7;
	rCar2[12] = rCar2[13] = rCar2[14] = 8;
	rCar2[15] = rCar2[16] = 9;
	rCar2[17] = rCar2[18] = 10;
	rCar2[19] = 11;
	rCar2[20] = rCar2[21] = rCar2[22] = 12;
	rCar2[23] = rCar2[24] = 13;

	//分配警车3
	rCar3[0] = 0;
	rCar3[1] = 1;
	rCar3[2] = 2;
	rCar3[3] = rCar3[4] = rCar3[5] = 3;
	rCar3[6] = rCar3[7] = 4;
	rCar3[8] = 5;
	rCar3[9] = rCar3[10] = 6;
	rCar3[11] = rCar3[12] = 7;
	rCar3[13] = rCar3[14] = 8;
	rCar3[15] = rCar3[16] = 9;
	rCar3[17] = rCar3[18] = 10;
	rCar3[19] = rCar3[20] = rCar3[21] = 11;
	rCar3[22] = rCar3[23] = rCar3[24] = 12;
	rCar3[25] = 13;

	nCar1 = 30;
	nCar2 = 25;
	nCar3 = 26;
}

void calculate::Floyd()
{
	for(int u = 0 ; u < data.n ; u++)
		for(int v = 0 ; v < data.n ; v++)
			for(int w = 0 ; w < data.n ; w++)
				if(Dis[v][u] + Dis[u][w] < Dis[v][w])
					Dis[v][w] = Dis[v][u] + Dis[u][w];
}

//储存所有可以到达重点位置的线段
void calculate::Calc_Special_Point()
{
	S[0].clear();
	S[1].clear();
	S[2].clear();

	for(int i = 0; i < 3; i ++)
	{
		int id;
		POINT I;
		Shortest_Road(Special[i], id, I);
		double l = V2 * 2 * 60;
		S[i] = Cover_Region1(I, id, l - Distance(I, Special[i]));
	}
}

void calculate::Shortest_Road(const POINT &p, int &best, POINT & bestP)
{
	double shortest = INFINITY;
	for(size_t j = 0; j < data.roads.size(); j ++)
	{
		SEGMENT s = SEGMENT(data.points[data.roads[j].a], data.points[data.roads[j].b]);
		POINT I = Nearest_Point_To_Segment(p, s);
		if(Distance(I, p) < shortest)
		{
			shortest = Distance(I, p);
			best = j;
			bestP = I;
		}
	}
}

vector<SEGMENT> calculate::Cover_Region1(const POINT &I, int id, double L)
{
	vector<SEGMENT> S;
	int a = data.roads[id].a;
	int b = data.roads[id].b;
	double t1 = Distance(data.points[a], I);
	double t2 = Distance(data.points[b], I);

	if(t1 > L)
	{
		VECTOR v = data.points[a] - I; 

		POINT p(v.x / t1 * L + I.x, v.y / t1 * L + I.y);
		S.push_back(SEGMENT(I, p));		
	}
	else S.push_back(SEGMENT(I, data.points[a]));
	if(t2 > L)
	{
		VECTOR v = data.points[b] - I; 

		POINT p(v.x / t2 * L + I.x, v.y / t2 * L + I.y);
		S.push_back(SEGMENT(I, p));		
	}
	else S.push_back(SEGMENT(I, data.points[b]));

	//加入每条线段
	for(size_t j = 0; j < data.roads.size(); j ++)
	{
		int a1 = data.roads[j].a;
		int b1 = data.roads[j].b;

		double t3 = Distance(data.points[a1], data.points[b1]);

		if(Dis[a][a1] + t1 < Dis[b][a1] + t2)
		{
			double d = L - Dis[a][a1] - t1;
			if(d > 0.0 && d < t3)
			{
				VECTOR v = data.points[b1] - data.points[a1]; 					

				POINT p(v.x / t3 * d + data.points[a1].x, v.y / t3 * d + data.points[a1].y);
				S.push_back(SEGMENT(data.points[a1], p));				
			}
			else if(d >= t3)
			{
				S.push_back(SEGMENT(data.points[a1], data.points[b1]));
			}
		}
		else
		{
			double d = L - Dis[b][a1] - t2;
			if(d > 0.0 && d < t3)
			{
				VECTOR v = data.points[b1] - data.points[a1]; 					
				
				POINT p(v.x / t3 * d + data.points[a1].x, v.y / t3 * d + data.points[a1].y);
				S.push_back(SEGMENT(data.points[a1], p));
			}			
			else if(d >= t3)
			{
				S.push_back(SEGMENT(data.points[a1], data.points[b1]));
			}
		}

		if(Dis[a][b1] + t1 < Dis[b][b1] + t2)
		{
			double d = L - Dis[a][b1] - t1;
			if(d > 0.0 && d < t3)
			{
				VECTOR v = data.points[a1] - data.points[b1]; 					
				
				POINT p(v.x / t3 * d + data.points[b1].x, v.y / t3 * d + data.points[b1].y);
				S.push_back(SEGMENT(data.points[b1], p));
			}
			else if(d >= t3)
			{
				S.push_back(SEGMENT(data.points[a1], data.points[b1]));
			}
		}
		else
		{
			double d = L - Dis[b][b1] - t2;
			if(d > 0.0 && d < t3)
			{
				VECTOR v = data.points[a1] - data.points[b1]; 					
				
				POINT p(v.x / t3 * d + data.points[b1].x, v.y / t3 * d + data.points[b1].y);
				S.push_back(SEGMENT(data.points[b1], p));
			}
			else if(d >= t3)
			{
				S.push_back(SEGMENT(data.points[a1], data.points[b1]));
			}
		}
	}
	return S;
}

vector<SEGMENT> calculate::Cover_Region2(const POINT &I, int id, double L)
{
	vector<SEGMENT> S;
	int a = data.roads[id].a;
	int b = data.roads[id].b;
	double t1 = Distance(data.points[a], I);
	double t2 = Distance(data.points[b], I);

	if(t1 <= L && t2 <= L)
	{
		S.push_back(SEGMENT(data.points[a], data.points[b]));		
	}

	//加入每条线段
	for(size_t j = 0; j < data.roads.size(); j ++)
	{
		if(j == id) continue;

		int a1 = data.roads[j].a;
		int b1 = data.roads[j].b;

		double t3 = Distance(data.points[a1], data.points[b1]);

		//只有当整条道路都被覆盖时才加入集合中
		if(Dis[a][a1] + t1 + t3 <= L || Dis[b][a1] + t2 + t3 <= L
			|| Dis[a][b1] + t1 + t3 <= L || Dis[b][b1] + t2 + t3 <= L)
		{
			S.push_back(SEGMENT(data.points[a1], data.points[b1]));		
		}
	}
	return S;
}

double calculate::Rmin(const POINT &a, const POINT & b)
{
	int i, j;
	for(i = 0; i < MAX_N; i ++)
	{
		if(data.points[i] == a) break;
	}

	for(j = 0; j < MAX_N; j ++)
	{
		if(data.points[j] == b) break;
	}

	//若两个点都是交叉点
	if(i < MAX_N && j < MAX_N)
	{
		return Dis[i][j];
	}
	else if(i < MAX_N)
	{
		int r = Road_Id(b);
		int a1 = data.roads[r].a;
		int b1 = data.roads[r].b;
		POINT pa = data.points[a1];
		POINT pb = data.points[b1];

		return min(Dis[i][a1] + Distance(b, pa), Dis[i][b1] + Distance(b, pb));
	}
	else if(j < MAX_N)
	{
		int r = Road_Id(a);
		int a1 = data.roads[r].a;
		int b1 = data.roads[r].b;
		POINT pa = data.points[a1];
		POINT pb = data.points[b1];

		return min(Dis[j][a1] + Distance(a, pa), Dis[j][b1] + Distance(a, pb));
	}
	else
	{
		int r1 = Road_Id(a);
		int r2 = Road_Id(b);
		if(r1 == r2) return Distance(a, b);

		int a1 = data.roads[r1].a;
		int b1 = data.roads[r1].b;
		int a2 = data.roads[r2].a;
		int b2 = data.roads[r2].b;

		POINT pa1 = data.points[a1];
		POINT pb1 = data.points[b1];
		POINT pa2 = data.points[a2];
		POINT pb2 = data.points[b2];

		double t1 = Dis[a1][a2] + Distance(a, pa1) + Distance(b, pa2);
		double t2 = Dis[a1][b2] + Distance(a, pa1) + Distance(b, pb2);
		double t3 = Dis[b1][a2] + Distance(a, pb1) + Distance(b, pa2);
		double t4 = Dis[b1][b2] + Distance(a, pb1) + Distance(b, pb2);
		return min(min(t1, t2), min(t3, t4));
	}
}

int calculate::Road_Id(const POINT & a)
{
	for(size_t i = 0; i < data.roads.size(); i ++)
	{
		int a1 = data.roads[i].a;
		int b1 = data.roads[i].b;
		SEGMENT s(data.points[a1], data.points[b1]);
		if(Is_On_Segment(a, s))
		{
			return i;
		}
	}
	return -1;
}

int calculate::Get_Road_Car(int cur, int r)	//返回当前道路r上的车辆数
{
	int cnt = 0;
	for(int i = 0; i < curNCar; i ++)
	{
		if(road_id[cur][i] == r) cnt ++;
	}
	return cnt;
}

int value[MAX_ROAD];

//每辆车到达交叉口时选择被巡逻次数最少的路线进行巡逻，
void calculate::Patrol1(int rCar[CARNUMBER], int nCar)
{
	time_t t;
	srand((unsigned)time(&t));

	memset(value, 0, sizeof(value));

	POINT cur;
	for(int i = 0; i < 240; i ++)
	{
		for(int j = 0; j < nCar; j ++)
		{
			int region = rCar[j];

			if(i == 0)
			{
				int k = rand() % data.regions[region].nRoad;
				road_id[0][j] = data.regions[region].roads_id[k];
				patrol[0][j] = data.points[data.roads[road_id[0][j]].a];
				next[0][j] = data.points[data.roads[road_id[0][j]].b];
			}
			else
			{
				cur = patrol[i-1][j];
				if(cur == next[i-1][j])		//若当前点即为交叉路口
				{
					//每次寻找权值最小的边
					int minValue = 0x7fffffff;
					int minID = -1;
					int minCarNum = 0x7fffffff;
					POINT tNext;
					for(size_t t = 0; t < data.regions[region].roads_id.size(); t ++)
					{
						int t1 = data.regions[region].roads_id[t];
						int a = data.roads[t1].a;
						int b = data.roads[t1].b;

						if(cur == data.points[a])
						{
							if(value[t1] < minValue)
							{
								minValue = value[t1];
								minID = t1;
								tNext = data.points[b];
							}
						}
						else if(cur == data.points[b])
						{
							if(value[t1] < minValue)
							{
								minValue = value[t1];
								minID = t1;
								tNext = data.points[a];
							}
						}
					}
					value[minID] ++;
					road_id[i][j] = minID;
					next[i][j] = tNext;
					VECTOR v = next[i][j] - cur;

					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);
					
					double d = Distance(next[i][j], cur);

					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i][j];
					}
				}//if
				else
				{
					VECTOR v = next[i - 1][j] - cur;
					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);

					double d = Distance(next[i - 1][j], cur);
					
					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i - 1][j];
						road_id[i][j] = road_id[i-1][j];
					}

					road_id[i][j] = road_id[i-1][j];
					next[i][j] = next[i-1][j];
				}
			}
		}
	}

	curNCar = nCar;
	Evaluate1();

	ofstream fcout;

	fcout.open("1038417-Result3.txt");

	fcout << nCar << "," << A << "," << B << "," << Z << "," << P1 << "," << P2 << "," << H << "," << J <<endl;
	for(int i = 0; i < 240; i ++)
	{
		fcout << "时间" << i + 1;
		for(int j = 0; j < nCar; j ++)
		{
			fcout << ",(" << patrol[i][j].x << "," << patrol[i][j].y << ")"; 
		}
		fcout << endl;
	}
	fcout << "End" << endl;

	fcout.close();
}

POINT calculate::Rand_Select()
{
	int k = rand() % data.roads.size();
	int a = data.roads[k].a;
	int b = data.roads[k].b;

	VECTOR v = data.points[b] - data.points[a];
	VECTOR e;
	double l = sqrt(v.x * v.x + v.y * v.y);
	e.x = v.x / l;
	e.y = v.y / l;
	double d = (double)rand() / RAND_MAX * l;

	e.x *= d;
	e.y *= d;
	return data.points[a] + e;
}

POINT calculate::Rand_Select(int region)
{
	int k = rand() % data.regions[region].nRoad;
	int road_id = data.regions[region].roads_id[k];
	int a = data.roads[road_id].a;
	int b = data.roads[road_id].b;

	VECTOR v = data.points[b] - data.points[a];
	VECTOR e;
	double l = sqrt(v.x * v.x + v.y * v.y);
	e.x = v.x / l;
	e.y = v.y / l;
	double d = (double)rand() / RAND_MAX * l;

	e.x *= d;
	e.y *= d;
	return data.points[a] + e;
}

void calculate::Test()
{
	for(int i = 0; i < curNCar; i ++)
	{
		for(int j = 1; j < 240; j ++)
		{
			double t = Rmin(patrol[j][i], patrol[j-1][i]);
			if(Rmin(patrol[j][i], patrol[j-1][i]) > V1 * 60 + EPSILON)
			{
				i = i;
			}
		}
	}
}

int Get_Period(vector<int> s)
{
	int next[240];
	int temp;
	next[0] = 0;
	for(size_t i = 1; i < s.size(); i++) 
	{ 
		temp = next[i - 1]; 
		while(s[i] != s[temp] && temp > 0)
		{
			temp = next[temp-1];
		}
		if(s[i] == s[temp]) 
		{
			next[i] = temp + 1;
		}
		else next[i] = 0; 
	}

	int Min = s.size();
	for(size_t l = s.size(); l >= s.size() / 2 + 1; l --)
	{
		size_t j, k;
		for(j = l, k = 0; j < s.size(); j ++, k ++)
		{
			if(s[j] != s[k]) break;
		}
		if(j < s.size()) continue;

		int t = l - next[l - 1];
		if(l % t == 0 && l / t != 1) 
		{
			Min = min(t, Min);
		}
	}
	return Min;
}

double calculate::Hide()
{
	vector<int> s;

	double H = 0.0;

	for(int i = 0; i < curNCar; i ++)
	{
		s.clear();
		s.push_back(road_id[0][i]);
		for(int j = 1; j < 240; j ++)
		{
			if(s.back() != road_id[j][i])
			{
				s.push_back(road_id[j][i]);
			}
		}

		int l = s.size();
		int t = Get_Period(s);
		H += (double)t / l;
	}
	return H / curNCar;
}


int Choose_Road(vector<int> roads)
{
	vector<double> p;
	p.resize(roads.size());

	int maxValue = 0;
	for(size_t i = 0; i < roads.size(); i ++)
	{
		maxValue = max(maxValue, value[roads[i]] + 1);
	}
	double tot = 0.0;
	for(size_t i = 0; i < roads.size(); i ++)
	{
		tot += maxValue - value[roads[i]];
	}

	for(size_t i = 0; i < roads.size(); i ++)
	{
		p[i] = (double)(maxValue - value[roads[i]]) / tot;
	}

	double t = 0.0;
	double k = (double)rand() / RAND_MAX;
	for(size_t i = 0; i < p.size(); i ++)
	{
		t += p[i];
		if(t >= k) return roads[i];
	}
	return roads[0];
}

//每辆车到达交叉口时选择被巡逻次数最少的路线进行巡逻，
void calculate::Patrol2(int rCar[CARNUMBER], int nCar)
{
	time_t t;
	srand((unsigned)time(&t));

	memset(value, 0, sizeof(value));

	POINT cur;
	for(int i = 0; i < 240; i ++)
	{
		for(int j = 0; j < nCar; j ++)
		{
			int region = rCar[j];

			if(i == 0)
			{
				int k = rand() % data.regions[region].nRoad;
				road_id[0][j] = data.regions[region].roads_id[k];
				patrol[0][j] = data.points[data.roads[road_id[0][j]].a];
				next[0][j] = data.points[data.roads[road_id[0][j]].b];
			}
			else
			{
				cur = patrol[i-1][j];
				if(cur == next[i-1][j])		//若当前点即为交叉路口
				{
					//每次寻找权值最小的边
					int minValue = 0x7fffffff;
					int minID = -1;
					int minCarNum = 0x7fffffff;
					POINT tNext;
					vector<int> Iroads;
					for(size_t t = 0; t < data.regions[region].roads_id.size(); t ++)
					{
						int t1 = data.regions[region].roads_id[t];
						int a = data.roads[t1].a;
						int b = data.roads[t1].b;
						if(cur == data.points[a] || cur == data.points[b])
						{
							Iroads.push_back(t1);
						}
					}
					int k = Choose_Road(Iroads);
					int a = data.roads[k].a;
					int b = data.roads[k].b;

					if(cur == data.points[a])
					{
						next[i][j] = data.points[b];
					}
					else if(cur == data.points[b])
					{
						next[i][j] = data.points[a];
					}
					value[k] ++;
					road_id[i][j] = k;
					VECTOR v = next[i][j] - cur;

					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);
					
					double d = Distance(next[i][j], cur);

					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i][j];
					}
				}//if
				else
				{
					VECTOR v = next[i - 1][j] - cur;
					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);

					double d = Distance(next[i - 1][j], cur);
					
					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i - 1][j];
						road_id[i][j] = road_id[i-1][j];
					}

					road_id[i][j] = road_id[i-1][j];
					next[i][j] = next[i-1][j];
				}
			}
		}
	}
	
	curNCar = nCar;
	Evaluate2();
}

//每辆车到达交叉口时选择被巡逻次数最少的路线进行巡逻，
void calculate::Patrol3(int rCar[CARNUMBER], int nCar)
{
	time_t t;
	srand((unsigned)time(&t));

	memset(value, 0, sizeof(value));

	POINT cur;
	for(int i = 0; i < 240; i ++)
	{
		for(int j = 0; j < nCar; j ++)
		{
			int region = rCar[j];

			if(i == 0)
			{
				int k = rand() % data.regions[region].nRoad;
				road_id[0][j] = data.regions[region].roads_id[k];
				patrol[0][j] = data.points[data.roads[road_id[0][j]].a];
				next[0][j] = data.points[data.roads[road_id[0][j]].b];
			}
			else
			{
				cur = patrol[i-1][j];
				if(cur == next[i-1][j])		//若当前点即为交叉路口
				{
					//每次寻找权值最小的边
					int minValue = 0x7fffffff;
					int minID = -1;
					int minCarNum = 0x7fffffff;
					POINT tNext;
					vector<int> Iroads;
					for(size_t t = 0; t < data.regions[region].roads_id.size(); t ++)
					{
						int t1 = data.regions[region].roads_id[t];
						int a = data.roads[t1].a;
						int b = data.roads[t1].b;
						if(cur == data.points[a] || cur == data.points[b])
						{
							Iroads.push_back(t1);
						}
					}
					int k = Choose_Road(Iroads);
					int a = data.roads[k].a;
					int b = data.roads[k].b;

					if(cur == data.points[a])
					{
						next[i][j] = data.points[b];
					}
					else if(cur == data.points[b])
					{
						next[i][j] = data.points[a];
					}
					value[k] ++;
					road_id[i][j] = k;
					VECTOR v = next[i][j] - cur;

					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);
					
					double d = Distance(next[i][j], cur);

					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i][j];
					}
				}//if
				else
				{
					VECTOR v = next[i - 1][j] - cur;
					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);

					double d = Distance(next[i - 1][j], cur);
					
					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i - 1][j];
						road_id[i][j] = road_id[i-1][j];
					}

					road_id[i][j] = road_id[i-1][j];
					next[i][j] = next[i-1][j];
				}
			}
		}
	}
	curNCar = nCar;
	
	Evaluate3();
	
	ofstream fcout;
	fcout.open("1038417-Result6.txt");

	fcout << nCar << "," << A << "," << B << "," << Z << "," << P1 << "," << P2 << "," << H << "," << J <<endl;
	for(int i = 0; i < 240; i ++)
	{
		fcout << "时间" << i + 1;
		for(int j = 0; j < nCar; j ++)
		{
			fcout << ",(" << patrol[i][j].x << "," << patrol[i][j].y << ")"; 
		}
		fcout << endl;
	}
	fcout << "End" << endl;

	fcout.close();	
}

//以一个小时为单位进行评估
void calculate::Evaluate1()
{
	A = 0.0;
	B = 0.0;
	double A[60][3];						//响应时间(单位为分钟)
	double A1[60];							//A1[i] = (A[i][0] + A[i][1] + A[i][2]) / 3
	POINT I[3];
	int id;
	for(int i = 0; i < 3; i ++)
	{
		Shortest_Road(Special[i], id, I[i]);
	}

	for(int i = 0; i < 60; i ++)
	{
		for(int j = 0; j < 3; j ++)
		{
			A[i][j] = INFINITY;
			for(int k = 0; k < curNCar; k ++)
			{
				A[i][j] = min(A[i][j], Rmin(I[j], patrol[i][k]));
			}
			A[i][j] /= V2 * 60;
		}
		A1[i] = (A[i][0] + A[i][1] + A[i][2]) / 3.0;
		this->A += A1[i];
	}
	this->A /= 60.0;

	double B1[300];
	POINT ps[300];
	int time[300];

	int top = 0;
	for(int i = 0; i < 300; i ++)
	{
		int k = rand() % 240;
		ps[i] = Rand_Select();
		time[i] = k;
	}
	for(int i = 0; i < 300; i ++)
	{
		B1[i] = INFINITY;
		for(int j = 0 ; j < curNCar; j ++)
		{
			B1[i] = min(B1[i], Rmin(ps[i], patrol[time[i]][j]));
		}
		B1[i] /= V2 * 60;
	}

	int cnt1 = 0;
	for(int i = 0; i < 60; i ++)
	{
		if(A1[i] <= 2.0 + EPSILON) cnt1 ++;
	}
	P1 = (double) cnt1 / 60.0;

	int cnt2 = 0;
	for(int i = 0; i < 300; i ++)
	{
		if(B1[i] <= 3 + EPSILON)cnt2 ++;
		B += B1[i];
	}
	B /= 300.0;
	P2 = (double) cnt2 / 300.0;


	bool bTempL[MAX_ROAD];

	memset(bTempL, 0, sizeof(bTempL));

	double L = 0.0;
	for(int i = 0; i < 60; i ++)
	{
		for(int j = 0; j < curNCar; j ++)
		if(value[road_id[i][j]])
		{
			bTempL[road_id[i][j]] = true;
		}
	}
	for(int i = 0; i < MAX_ROAD; i ++)
	{
		if(bTempL[i])
		{
			int a = data.roads[i].a;
			int b = data.roads[i].b;
			L += Distance(data.points[a], data.points[b]);
		}
	}
	Z = L / totalLength;
	H = Hide();
	J = 1.0 - (double)curNCar / 50;
}

//以一个小时为单位进行评估
void calculate::Evaluate2()
{
	this->A = 0.0;
	this->B = 0.0;
	double A[60][3];						//响应时间(单位为分钟)
	double A1[60];							//A1[i] = (A[i][0] + A[i][1] + A[i][2]) / 3
	POINT I[3];
	int id;
	for(int i = 0; i < 3; i ++)
	{
		Shortest_Road(Special[i], id, I[i]);
	}

	for(int i = 0; i < 60; i ++)
	{
		for(int j = 0; j < 3; j ++)
		{
			A[i][j] = INFINITY;
			for(int k = 0; k < curNCar; k ++)
			{
				A[i][j] = min(A[i][j], Rmin(I[j], patrol[i][k]));
			}
			A[i][j] /= V2 * 60;
		}
		A1[i] = (A[i][0] + A[i][1] + A[i][2]) / 3.0;
		this->A += A1[i];
	}
	this->A /= 60.0;

	int pNum[14];					//各区域案件发生次数
	pNum[3] = 10;
	pNum[4] = 5;
	pNum[5] = 1;
	pNum[6] = 50;
	pNum[7] = 54;
	pNum[8] = 30;
	pNum[9] = 15;
	pNum[10] = 10;
	pNum[11] = 20;
	pNum[12] = 50;
	pNum[13] = 55;

	double B1[300];
	POINT ps[300];
	int time[300];

	int top = 0;
	for(int i = 3; i < 14; i ++)
	{
		for(int j = 0; j < pNum[i]; j ++)
		{
			int k = rand() % 240;
			ps[top] = Rand_Select(i);
			time[top] = k;
			top ++;
		}
	}
	for(int i = 0; i < 300; i ++)
	{
		B1[i] = INFINITY;
		for(int j = 0 ; j < curNCar; j ++)
		{
			B1[i] = min(B1[i], Rmin(ps[i], patrol[time[i]][j]));
		}
		B1[i] /= V2 * 60;
	}

	int cnt1 = 0;
	for(int i = 0; i < 60; i ++)
	{
		if(A1[i] <= 2.0 + EPSILON) cnt1 ++;
	}
	P1 = (double) cnt1 / 60.0;

	int cnt2 = 0;
	for(int i = 0; i < 300; i ++)
	{
		if(B1[i] <= 3 + EPSILON)cnt2 ++;
		B += B1[i];
	}
	B /= 1000.0;
	P2 = (double) cnt2 / 300.0;


	bool bTempL[MAX_ROAD];

	memset(bTempL, 0, sizeof(bTempL));

	double L = 0.0;
	for(int i = 0; i < 60; i ++)
	{
		for(int j = 0; j < curNCar; j ++)
		if(value[road_id[i][j]])
		{
			bTempL[road_id[i][j]] = true;
		}
	}
	for(int i = 0; i < MAX_ROAD; i ++)
	{
		if(bTempL[i])
		{
			int a = data.roads[i].a;
			int b = data.roads[i].b;
			L += Distance(data.points[a], data.points[b]);
		}
	}
	Z = L / totalLength;
	H = Hide();
	J = 1.0 - (double)curNCar / 50;
}
//以一个小时为单位进行评估
void calculate::Evaluate3()
{
	A = 0.0;
	B = 0.0;
	double A[60][3];						//响应时间(单位为分钟)
	double A1[60];							//A1[i] = (A[i][0] + A[i][1] + A[i][2]) / 3
	POINT I[3];
	int id;
	for(int i = 0; i < 3; i ++)
	{
		Shortest_Road(Special[i], id, I[i]);
	}

	for(int i = 0; i < 60; i ++)
	{
		for(int j = 0; j < 3; j ++)
		{
			A[i][j] = INFINITY;
			for(int k = 0; k < curNCar; k ++)
			{
				A[i][j] = min(A[i][j], Rmin(I[j], patrol[i][k]));
			}
			A[i][j] /= V3 * 60;
		}
		A1[i] = (A[i][0] + A[i][1] + A[i][2]) / 3.0;
		this->A += A1[i];
	}
	this->A /= 60.0;

	double B1[300];
	POINT ps[300];
	int time[300];

	int top = 0;
	for(int i = 0; i < 300; i ++)
	{
		int k = rand() % 240;
		ps[i] = Rand_Select();
		time[i] = k;
	}
	for(int i = 0; i < 300; i ++)
	{
		B1[i] = INFINITY;
		for(int j = 0 ; j < curNCar; j ++)
		{
			B1[i] = min(B1[i], Rmin(ps[i], patrol[time[i]][j]));
		}
		B1[i] /= V3 * 60;
	}

	int cnt1 = 0;
	for(int i = 0; i < 60; i ++)
	{
		if(A1[i] <= 2.0 + EPSILON) cnt1 ++;
	}
	P1 = (double) cnt1 / 60.0;

	int cnt2 = 0;
	for(int i = 0; i < 300; i ++)
	{
		if(B1[i] <= 3.0 + EPSILON)cnt2 ++;
		B += B1[i];
	}
	B /= 300.0;
	P2 = (double) cnt2 / 300.0;


	bool bTempL[MAX_ROAD];

	memset(bTempL, 0, sizeof(bTempL));

	double L = 0.0;
	for(int i = 0; i < 60; i ++)
	{
		for(int j = 0; j < curNCar; j ++)
		if(value[road_id[i][j]])
		{
			bTempL[road_id[i][j]] = true;
		}
	}
	for(int i = 0; i < MAX_ROAD; i ++)
	{
		if(bTempL[i])
		{
			int a = data.roads[i].a;
			int b = data.roads[i].b;
			L += Distance(data.points[a], data.points[b]);
		}
	}
	Z = L / totalLength;
	H = Hide();
	J = 1.0 - (double)curNCar / 50;
}

//计算其他点距离道路r最近的距离
double calculate::Get_Min(int r, int curCar, int cur)
{
	double Min = INFINITY;
	SEGMENT s(data.points[data.roads[r].a], data.points[data.roads[r].a]);
	POINT O((s.a.x + s.b.x) / 2.0, (s.a.y + s.b.y) / 2.0);

	for(int i = 0; i < curCar; i ++)
	{
		Min = min(Min, Rmin(O, patrol[cur][i]));
	}
	return Min;
}

void calculate::Patrol4()
{
	time_t t;
	srand((unsigned)time(&t));

	memset(value, 0, sizeof(value));

	POINT cur;
	for(int i = 0; i < 240; i ++)
	{
		for(int j = 0; j < 3; j ++)
		{
			if(i == 0)
			{
				int k = rand() % data.regions[j].nRoad;
				road_id[0][j] = data.regions[j].roads_id[k];
				patrol[0][j] = data.points[data.roads[road_id[0][j]].a];
				next[0][j] = data.points[data.roads[road_id[0][j]].b];
			}
			else
			{
				cur = patrol[i-1][j];
				double maxDis = -1.0;
				int minID;
		
				if(cur == next[i-1][j])		//若当前点即为交叉路口
				{
					//每次寻找离其他车辆最远的一个方案

					for(int t = 0; t < data.regions[j].nRoad; t ++)
					{
						int t1 = data.regions[j].roads_id[t];
						int a = data.roads[t1].a;
						int b = data.roads[t1].b;
						if(cur == data.points[a])
						{
							double Min = this->Get_Min(t, j, i);
							if(Min > maxDis)
							{
								maxDis = Min;
								next[i][j] = data.points[b];
								minID = t1;
							}
						}
						else if(cur == data.points[b])
						{
							double Min = this->Get_Min(t, j, i);
							if(Min > maxDis)
							{
								maxDis = Min;
								next[i][j] = data.points[a];
								minID = t1;
							}							
						}
					}
					value[minID] ++;
					road_id[i][j] = minID;

					VECTOR v = next[i][j] - cur;

					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);
					
					double d = Distance(next[i][j], cur);

					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i][j];
					}
				}//if
				else
				{
					VECTOR v = next[i - 1][j] - cur;
					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);

					double d = Distance(next[i - 1][j], cur);
					
					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i - 1][j];
						road_id[i][j] = road_id[i-1][j];
					}

					road_id[i][j] = road_id[i-1][j];
					next[i][j] = next[i-1][j];
				}
			}
		}
	}

	for(int i = 0; i < 240; i ++)
	{
		for(int j = 3; j < 10; j ++)
		{
			if(i == 0)
			{
				int k = rand() % MAX_ROAD;
				road_id[0][j] = k;
				patrol[0][j] = data.points[data.roads[k].a];
				next[0][j] = data.points[data.roads[k].b];
			}
			else
			{
				cur = patrol[i-1][j];
				if(cur == next[i-1][j])		//若当前点即为交叉路口
				{
					//每次寻找离其他车辆最远的一个方案
					double maxDis = -1.0;
					int minID;

					for(int t = 0; t < MAX_ROAD; t ++)
					{
						int a = data.roads[t].a;
						int b = data.roads[t].b;
						if(cur == data.points[a])
						{
							double Min = this->Get_Min(t, j, i);
							if(Min > maxDis)
							{
								maxDis = Min;
								next[i][j] = data.points[b];
								minID = t;
							}
						}
						else if(cur == data.points[b])
						{
							double Min = this->Get_Min(t, j, i);
							if(Min > maxDis)
							{
								maxDis = Min;
								next[i][j] = data.points[a];
								minID = t;
							}							
						}
					}
					value[minID] ++;
					road_id[i][j] = minID;

					VECTOR v = next[i][j] - cur;

					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);
					
					double d = Distance(next[i][j], cur);

					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i][j];
					}
				}//if
				else
				{
					VECTOR v = next[i - 1][j] - cur;
					VECTOR e;
					e.x = v.x / sqrt(v.x * v.x + v.y * v.y); 
					e.y = v.y / sqrt(v.x * v.x + v.y * v.y);

					double d = Distance(next[i - 1][j], cur);
					
					if(V1 * 60 < d)		//如果一分钟内无法到达next
					{
						patrol[i][j].x = cur.x + V1 * 60 * e.x;
						patrol[i][j].y = cur.y + V1 * 60 * e.y;
					}
					else
					{
						patrol[i][j] = next[i - 1][j];
						road_id[i][j] = road_id[i-1][j];
					}

					road_id[i][j] = road_id[i-1][j];
					next[i][j] = next[i-1][j];
				}
			}
		}
	}

	curNCar = 10;
	
	Evaluate1();

	ofstream fcout;
	fcout.open("1038417-Result5.txt");

	fcout << 10 << "," << A << "," << B << "," << Z << "," << P1 << "," << P2 << "," << H << "," << J <<endl;
	for(int i = 0; i < 240; i ++)
	{
		fcout << "时间" << i + 1;
		for(int j = 0; j < 10; j ++)
		{
			fcout << ",(" << patrol[i][j].x << "," << patrol[i][j].y << ")"; 
		}
		fcout << endl;
	}
	fcout << "End" << endl;

	fcout.close();	
}
