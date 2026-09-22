#pragma once


// CSetAtrr 对话框

class CSetAtrr : public CDialog
{
	DECLARE_DYNAMIC(CSetAtrr)

public:
	CSetAtrr(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CSetAtrr();

// 对话框数据
	enum { IDD = IDD_DIALOGSET };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOk();

public:
	int m_setTime;
};
