#include "stdafx.h"
#include "constant.h"
#include "geometry.h"
#include <algorithm>

using namespace std;

POINT Intersection_Point(const LINE &L1, const LINE &L2)
{
	POINT I;
	I.x = - (L2.B * L1.C - L1.B * L2.C) / (L1.A * L2.B - L2.A * L1.B);
	I.y =   (L2.A * L1.C - L1.A * L2.C) / (L1.A * L2.B - L2.A * L1.B);
	return I;      
}

POINT Intersection_Point(const SEGMENT &S1, const SEGMENT &S2)
{
	LINE L1(S1.a, S1.b);
	LINE L2(S2.a, S2.b);
	return Intersection_Point(L1, L2);      
}

bool Is_Intersect(const SEGMENT &u, const SEGMENT &v)
{
	if(Is_Touch(u, v)) return false;
	if( (max(u.a.x, u.b.x) > min(v.a.x, v.b.x) + EPSILON) &&
		(max(v.a.x, v.b.x) > min(u.a.x, u.b.x) + EPSILON) &&
		(max(u.a.y, u.b.y) > min(v.a.y, v.b.y) + EPSILON) &&
		(max(v.a.y, v.b.y) > min(u.a.y, u.b.y) + EPSILON))
	{
		double t1 = Cross(v.a, u.b, u.a);
		double t2 = Cross(u.b, v.b, u.a);
		double t3 = Cross(u.a, v.b, v.a);
		double t4 = Cross(v.b, u.b, v.a);
		if(fabs(t1) <= EPSILON || fabs(t2) <= EPSILON || fabs(t3) <= EPSILON || fabs(t4) <= EPSILON)
		{
			return false;
		}
		else
		{
			return (t1 * t2 > EPSILON) && (t3 * t4 > EPSILON);
		}
	}
	return false;
}

bool Is_On_Segment(const POINT & P, const SEGMENT & S)
{
	if(P == S.a || P == S.b) return true;
	else
	{
		if(P.x < max(S.a.x, S.b.x) + EPSILON && 
		   P.x > min(S.a.x, S.b.x) - EPSILON &&
		   P.y < max(S.a.y, S.b.y) + EPSILON &&
		   P.y > min(S.a.y, S.b.y) - EPSILON &&
		   fabs(Cross(S.b, P, S.a)) <= EPSILON)
		{
			return true;
		}
	}
	return false;
}

bool Is_Touch(const SEGMENT &u, const SEGMENT & v)
{
	if( (max(u.a.x, u.b.x) >= min(v.a.x, v.b.x) - EPSILON) &&
		(max(v.a.x, v.b.x) >= min(u.a.x, u.b.x) - EPSILON) &&
		(max(u.a.y, u.b.y) >= min(v.a.y, v.b.y) - EPSILON) &&
		(max(v.a.y, v.b.y) >= min(u.a.y, u.b.y) - EPSILON))
	{
		double t1 = Cross(v.a, u.b, u.a);
		double t2 = Cross(u.b, v.b, u.a);
		double t3 = Cross(u.a, v.b, v.a);
		double t4 = Cross(v.b, u.b, v.a);
		if(fabs(t1 * t2) <= EPSILON)
		{
			if(fabs(t3 * t4) <= EPSILON || t3 * t4 > 0.0)
			{
				return true;
			}
		}
		else if(t1 * t2 > 0.0 && fabs(t3 * t4) <= EPSILON)
		{
			return true;
		}
	}
	return false;
}

double Angle(const SEGMENT& S)
{
	double x1 = S.b.x - S.a.x;
	double y1 = S.b.y - S.a.y;
	if(fabs(x1) <= EPSILON)
	{
		if(y1 > 0.0) return 0.5 * PI;
		else return 1.5 * PI;
	}
	if(fabs(y1) <= EPSILON)
	{
		if(x1 > 0.0) return 0.0;
		else return PI;
	}
	double angle = atan(fabs(y1 / x1));
	if(x1 > 0)
	{
		return y1 > 0 ? angle : 2.0 * PI - angle;
	}
	else 
	{
		return y1 > 0 ? PI - angle : PI + angle;
	}
}

double Angle_Between(const SEGMENT& s1, const SEGMENT& s2)
{
	//注意误差，若太接近，就另为0
	double angle = Angle(s2) - Angle(s1);
	if(fabs(angle) < EPSILON) angle = 0.0;
	if(angle > 2.0 * PI) angle = 0.0;
	else if(angle < 0.0) angle += 2.0 * PI;
	return angle;
}

bool Is_Same_Direction(const VECTOR & v1, const VECTOR & v2)
{
	POINT o(0.0, 0.0);
	SEGMENT s1(o, v1);
	SEGMENT s2(v1, v1 + v2);
	if(fabs(Cross(s1, s2)) <= EPSILON)
	{
		if(!Is_On_Segment(o, s2) && !Is_On_Segment(v1 + v2, s1))
			return true;
	}
	return false;
}

//点到直线的垂足
POINT Pedal_Point(const POINT& P, const LINE& L)
{
	if(fabs(L.B) <= EPSILON)	//如果直线平行Y轴
	{
		return POINT(-L.C / L.A, P.y);
	}
	else if(fabs(L.A) <= EPSILON) //如果直线平行X轴
	{
		return POINT(P.x, -L.C / L.B);
	}
	else
	{
		double k1 = - L.A / L.B;
		double k2 = - 1 / k1;
		double b1 = - L.C / L.B;
		double b2 = P.y - k2 * P.x;

		double x = (b2 - b1) / (k1 - k2);
		double y = k2 * x + b2;

		return POINT(x, y);
	}
}

//点到线段的最近点
POINT Nearest_Point_To_Segment(const POINT& P, const SEGMENT& S)
{
	LINE L(S.a, S.b);
	POINT I = Pedal_Point(P, L);
	if(Is_On_Segment(I, S))
	{
		return I;
	}
	else
	{
		double t1 = Distance(P, S.a);
		double t2 = Distance(P, S.b);
		return t1 < t2 ? S.a : S.b; 
	}
}

vector<SEGMENT> Differ_Segment1(const SEGMENT & s1, const SEGMENT & s2)
{
	vector<SEGMENT> S;
	SEGMENT s;
	if(s1.a == s1.b) return S;

	if(Is_Touch(s1, s2))
	{
		if(Is_On_Segment(s1.a, s2) && Is_On_Segment(s1.b, s2))
		{
		}
		else if(Is_On_Segment(s2.a, s1) && Is_On_Segment(s2.b, s1))
		{
			double t1 = Distance(s1.a, s2.a);
			double t2 = Distance(s1.a, s2.b);
			if(t1 < t2)
			{
				s.a = s1.a;
				s.b = s2.a;
				S.push_back(s);
				s.a = s2.b;
				s.b = s1.b;
				S.push_back(s);
			}
			else 
			{
				s.a = s1.a;
				s.b = s2.b;
				S.push_back(s);
				s.a = s2.a;
				s.b = s1.b;
				S.push_back(s);
			}
		}
		else if(Is_On_Segment(s2.a, s1) && Is_On_Segment(s1.b, s2) && s2.a != s1.b)
		{
			s.a = s1.a;
			s.b = s2.a;
			S.push_back(s);
		}
		else if(Is_On_Segment(s2.b, s1) && Is_On_Segment(s1.b, s2) && s2.b != s1.b)
		{
			s.a = s1.a;
			s.b = s2.b;
			S.push_back(s);
		}
		else if(Is_On_Segment(s2.a, s1) && Is_On_Segment(s1.a, s2) && s2.a != s1.a)
		{
			s.a = s1.b;
			s.b = s2.a;
			S.push_back(s);
		}
		else if(Is_On_Segment(s2.b, s1) && Is_On_Segment(s1.a, s2) && s2.b != s1.a)
		{
			s.a = s1.b;
			s.b = s2.b;
			S.push_back(s);
		}
		else
		{
			s.a = s1.a;
			s.b = s1.b;
			S.push_back(s);
		}
	}
	else
	{
		s.a = s1.a;
		s.b = s1.b;
		S.push_back(s);
	}

	return S;
}

vector<SEGMENT> Differ_Segment1(std::vector<SEGMENT> S1, const SEGMENT& s2)
{
	vector<SEGMENT> S;
	for(size_t i = 0; i < S1.size(); i ++)
	{
		vector<SEGMENT> T = Differ_Segment1(S1[i], s2);
		for(size_t j = 0; j < T.size(); j ++)
		{
			S.push_back(T[j]);
		}
	}
	return S;
}

vector<SEGMENT> Differ_Segments1(std::vector<SEGMENT> S1, std::vector<SEGMENT> S2)
{
	vector<SEGMENT> S = S1;
	for(size_t i = 0; i < S2.size(); i ++)
	{
		S = Differ_Segment1(S, S2[i]);
	}
	return S;
}

void Differ_Segments2(std::vector<SEGMENT>& S1, std::vector<SEGMENT> S2)
{
	vector<SEGMENT> T;
	for(size_t j = 0; j < S2.size(); j ++)
	{
		T.clear();
		for(size_t i = 0; i < S1.size(); i ++)
		{
			if(S1[i] != S2[j])
			{
				T.push_back(S1[i]);
			}
		}
		S1 = T;
	}
}
