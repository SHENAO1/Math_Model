// GraphicSearchView.h : CGraphicSearchView 类的接口
//


#pragma once
#include ".\graphic.h"
#include ".\setcover.h"

class CGraphicSearchView : public CView
{
protected: // 仅从序列化创建
	CGraphicSearchView();
	DECLARE_DYNCREATE(CGraphicSearchView)

// 属性
public:
	CGraphicSearchDoc* GetDocument() const;

	bool m_bDraw, m_bVipPoint, m_bShowID, m_bShowPolice;
	CPoint m_VipPoint[3];
	

	CSetCover m_setCover;


// 操作
public:

// 重写
	public:
	virtual void OnDraw(CDC* pDC);  // 重写以绘制该视图
virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);

// 实现
public:
	virtual ~CGraphicSearchView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// 生成的消息映射函数
protected:
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnFileOpen();
	afx_msg void OnFileSave();
	afx_msg void OnOperationReadvippoint();
	afx_msg void OnOperationSearchalllinks();
	afx_msg void OnOperationShowid();
	afx_msg void OnOperationGetsetcover();
	afx_msg void OnOperationInitprocsetcover();
	afx_msg void OnOperationDensifypoints();
	afx_msg void OnOperationGetnextsetcover();
	afx_msg void OnOperationShowsearchlink();
	afx_msg void OnOperationGreedyopt();
	afx_msg void OnPolicecarsearchSearchmovepath();
	afx_msg void OnPolicecarsearchCalculatetarget();
	afx_msg void OnAllop();
};

#ifndef _DEBUG  // GraphicSearchView.cpp 的调试版本
inline CGraphicSearchDoc* CGraphicSearchView::GetDocument() const
   { return reinterpret_cast<CGraphicSearchDoc*>(m_pDocument); }
#endif

