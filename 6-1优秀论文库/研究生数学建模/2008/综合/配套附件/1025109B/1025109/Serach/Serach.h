// Serach.h : main header file for the SERACH application
//

#if !defined(AFX_SERACH_H__C95B909F_D683_499C_8061_3AF0EE9515EC__INCLUDED_)
#define AFX_SERACH_H__C95B909F_D683_499C_8061_3AF0EE9515EC__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CSerachApp:
// See Serach.cpp for the implementation of this class
//

class CSerachApp : public CWinApp
{
public:
	CSerachApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSerachApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CSerachApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SERACH_H__C95B909F_D683_499C_8061_3AF0EE9515EC__INCLUDED_)
