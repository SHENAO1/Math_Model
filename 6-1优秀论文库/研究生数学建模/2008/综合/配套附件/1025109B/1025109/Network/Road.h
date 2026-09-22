// Road.h: interface for the Road class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_ROAD_H__BA3CAF58_7BF3_4745_ABCF_A0F78CA708C2__INCLUDED_)
#define AFX_ROAD_H__BA3CAF58_7BF3_4745_ABCF_A0F78CA708C2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class Road  
{
public:
	Road();
	double arrive;
	double output;
	double stop;

	virtual ~Road();

};

#endif // !defined(AFX_ROAD_H__BA3CAF58_7BF3_4745_ABCF_A0F78CA708C2__INCLUDED_)
