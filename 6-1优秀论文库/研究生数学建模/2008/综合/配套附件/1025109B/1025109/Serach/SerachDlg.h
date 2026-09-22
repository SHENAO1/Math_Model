// SerachDlg.h : header file
//

#if !defined(AFX_SERACHDLG_H__372C8263_0DF2_4FF7_8A28_D06A6061EFE8__INCLUDED_)
#define AFX_SERACHDLG_H__372C8263_0DF2_4FF7_8A28_D06A6061EFE8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Result.h"
#include "RoadStreet.h"

/////////////////////////////////////////////////////////////////////////////
// CSerachDlg dialog

class CSerachDlg : public CDialog
{
// Construction
public:
	void GudingPeishi();
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
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
		
    void CreatePoisson();
    double AverageRandom(double min,double max);
	int GetXulie(double *pdata, int n , double value);
	int jiecheng(int value);
    double GetInputFlow(int *forward , int start , int end);

	CResult res;
	CRoadStreet m_roadstreet[8];

	double streetstop[8];
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SERACHDLG_H__372C8263_0DF2_4FF7_8A28_D06A6061EFE8__INCLUDED_)
