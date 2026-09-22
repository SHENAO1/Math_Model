// SerachDlg.h : header file
//

#if !defined(AFX_SERACHDLG_H__372C8263_0DF2_4FF7_8A28_D06A6061EFE8__INCLUDED_)
#define AFX_SERACHDLG_H__372C8263_0DF2_4FF7_8A28_D06A6061EFE8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Result.h"
#include "RoadStreet.h"
#include "TimeSet.h"
/////////////////////////////////////////////////////////////////////////////
// CSerachDlg dialog

class CSerachDlg : public CDialog
{
// Construction
public:
	void CreatePop(int num);
	void NetWorkRoad();
	double StreetStop(double t1, double t2, double t3, double t4,
       	double tA1, double tA2, double tA3, double tA4,
		double tB1, double tB2, double tB3, double tB4,
		double tC1, double tC2, double tC3, double tC4,
		double tD1, double tD2, double tD3, double tD4);
	
	void yanshi();
	void NoneFixedCircle();


	void FixedCircle();
	CSerachDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CSerachDlg)
	enum { IDD = IDD_SERACH_DIALOG };
	CString	m_min;
	CString	m_t1;
	CString	m_t2;
	CString	m_t3;
	CString	m_t4;
	CString	m_x1;
	CString	m_x2;
	CString	m_x3;
	CString	m_x4;
	CString	m_x5;
	CString	m_x6;
	CString	m_x7;
	CString	m_x8;
	CString	m_num1;
	CString	m_num2;
	CString	m_num3;
	CString	m_num4;
	CString	m_num5;
	CString	m_num6;
	CString	m_num7;
	CString	m_num8;
	CString	m_ta1;
	CString	m_ta2;
	CString	m_ta3;
	CString	m_ta4;
	CString	m_tb1;
	CString	m_tb2;
	CString	m_tb3;
	CString	m_tb4;
	CString	m_tc1;
	CString	m_tc2;
	CString	m_tc3;
	CString	m_tc4;
	CString	m_td1;
	CString	m_td2;
	CString	m_td3;
	CString	m_td4;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSerachDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CSerachDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonStart();
	afx_msg void OnButton1();
	afx_msg void OnButton2();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
public:
	double LineStop(double t1, double t2, double t3, double t4,
		double tA1, double tA2, double tA3, double tA4,
		double tB1, double tB2, double tB3, double tB4);
	
	void CanculateA3();
	void CanculateA4();
	void CanculateA2(double tB1,double tB2,double tB3,double tB4);
	void CanculateA1(double tA1,double tA2,double tA3,double tA4);

	CTimeSet population[2000];

    void CreatePoisson();
    double AverageRandom(double min,double max);
	int GetXulie(double *pdata, int n , double value);
	int jiecheng(int value);
    double GetInputFlow(int *forward , int start , int end);

	CResult res;
	CRoadStreet m_roadstreet[5][8];

	double streetstop[8];
	double streetstop1[8];
	
	
	double rt1;
	double rt2;
	double rt3;
	double rt4;
	double rtA1;
	double rtA2;
	double rtA3;
	double rtA4;
	double rtB1;
	double rtB2;
	double rtB3;
	double rtB4;
	double rtC1;
	double rtC2;
	double rtC3;
	double rtC4;
	double rtD1;
	double rtD2;
	double rtD3;
	double rtD4;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SERACHDLG_H__372C8263_0DF2_4FF7_8A28_D06A6061EFE8__INCLUDED_)
