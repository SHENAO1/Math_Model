// LinerSearch.h : main header file for the LINERSEARCH application
//

#if !defined(AFX_LINERSEARCH_H__F88CD78C_31E7_4E35_B5F7_6FF31BBFCE2C__INCLUDED_)
#define AFX_LINERSEARCH_H__F88CD78C_31E7_4E35_B5F7_6FF31BBFCE2C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CLinerSearchApp:
// See LinerSearch.cpp for the implementation of this class
//

class CLinerSearchApp : public CWinApp
{
public:
	CLinerSearchApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLinerSearchApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CLinerSearchApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LINERSEARCH_H__F88CD78C_31E7_4E35_B5F7_6FF31BBFCE2C__INCLUDED_)
