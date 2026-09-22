//geometry.h 计算几何相关常数及函数
#pragma once

#include "point.h"
#include "segment.h"
#include "line.h"
#include <cmath>
#include <vector>

inline double Distance(const POINT& a, const POINT& b)					//求两点距离
{
	return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

inline double Cross(const POINT& a, const POINT& b, const POINT& o)		//叉乘(oa×ob)
{
	return (a.x - o.x) * (b.y - o.y) - (b.x - o.x) * (a.y - o.y);
}

inline double Cross(const SEGMENT & p, const SEGMENT & q)				//叉乘(p×q)
{
	return (p.b.x - p.a.x) * (q.b.y - q.a.y) - (q.b.x - q.a.x) * (p.b.y - p.a.y);
}

//点到直线的垂足
POINT Pedal_Point(const POINT& P, const LINE& L);

//点到线段的最近点
POINT Nearest_Point_To_Segment(const POINT& P, const SEGMENT& S);

POINT Intersection_Point(const LINE &L1, const LINE &L2);				//求两相交直线的交点

POINT Intersection_Point(const SEGMENT &S1, const SEGMENT &S2);			//求两相交线段的交点

bool Is_Intersect(const SEGMENT &u, const SEGMENT &v);					//判断两线段是否相交

bool Is_On_Segment(const POINT & P, const SEGMENT & S);					//判断点是否在线段上

bool Is_Touch(const SEGMENT &u, const SEGMENT & v);						//判断两线段是否相触

double Angle(const SEGMENT& S);											//由X轴逆时针旋转到S的弧度

double Angle_Between(const SEGMENT& s1, const SEGMENT& s2);				//返回s1逆时针旋转到s2的夹角

bool Is_Same_Direction(const VECTOR & v1, const VECTOR & v2);			//判断两向量是否同向

//求s1 - s2
std::vector<SEGMENT> Differ_Segment1(const SEGMENT & s1, const SEGMENT & s2);

std::vector<SEGMENT> Differ_Segment1(std::vector<SEGMENT> S1, const SEGMENT& s2);

std::vector<SEGMENT> Differ_Segments1(std::vector<SEGMENT> S1, std::vector<SEGMENT> S2);

void Differ_Segments2(std::vector<SEGMENT>& S1, std::vector<SEGMENT> S2);
