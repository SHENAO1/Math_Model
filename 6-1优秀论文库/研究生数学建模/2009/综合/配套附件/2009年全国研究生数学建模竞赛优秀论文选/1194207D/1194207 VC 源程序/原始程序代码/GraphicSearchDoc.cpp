// GraphicSearchDoc.cpp :  CGraphicSearchDoc 类的实现
//

#include "stdafx.h"
#include "GraphicSearch.h"

#include "GraphicSearchDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CGraphicSearchDoc

IMPLEMENT_DYNCREATE(CGraphicSearchDoc, CDocument)

BEGIN_MESSAGE_MAP(CGraphicSearchDoc, CDocument)
END_MESSAGE_MAP()


// CGraphicSearchDoc 构造/析构

CGraphicSearchDoc::CGraphicSearchDoc()
{
	// TODO: 在此添加一次性构造代码

}

CGraphicSearchDoc::~CGraphicSearchDoc()
{
}

BOOL CGraphicSearchDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: 在此添加重新初始化代码
	// (SDI 文档将重用该文档)

	return TRUE;
}




// CGraphicSearchDoc 序列化

void CGraphicSearchDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: 在此添加存储代码
	}
	else
	{
		// TODO: 在此添加加载代码
	}
}


// CGraphicSearchDoc 诊断

#ifdef _DEBUG
void CGraphicSearchDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CGraphicSearchDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CGraphicSearchDoc 命令
