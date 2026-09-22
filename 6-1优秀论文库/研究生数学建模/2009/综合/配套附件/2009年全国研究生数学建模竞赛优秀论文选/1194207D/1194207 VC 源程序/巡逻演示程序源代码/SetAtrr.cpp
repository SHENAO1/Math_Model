// SetAtrr.cpp : 实现文件
//

#include "stdafx.h"
#include "GraphicSearch.h"
#include "SetAtrr.h"
#include ".\setatrr.h"


// CSetAtrr 对话框

IMPLEMENT_DYNAMIC(CSetAtrr, CDialog)
CSetAtrr::CSetAtrr(CWnd* pParent /*=NULL*/)
	: CDialog(CSetAtrr::IDD, pParent)
	, m_setTime(0)
{
	m_setTime = 500;
}

CSetAtrr::~CSetAtrr()
{
}

void CSetAtrr::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT_TIME, m_setTime);
	DDV_MinMaxInt(pDX, m_setTime, 0, 3000);
}


BEGIN_MESSAGE_MAP(CSetAtrr, CDialog)
	ON_BN_CLICKED(IDOK, OnBnClickedOk)
END_MESSAGE_MAP()


// CSetAtrr 消息处理程序

void CSetAtrr::OnBnClickedOk()
{
	// TODO: 在此添加控件通知处理程序代码
	UpdateData(true);
	OnOK();
}
