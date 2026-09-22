// GraphicSearchView.cpp : CGraphicSearchView 类的实现
//

#include "stdafx.h"
#include "GraphicSearch.h"

#include "GraphicSearchDoc.h"
#include "GraphicSearchView.h"
#include ".\graphicsearchview.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CGraphicSearchView

IMPLEMENT_DYNCREATE(CGraphicSearchView, CView)

BEGIN_MESSAGE_MAP(CGraphicSearchView, CView)
	// 标准打印命令
	ON_COMMAND(ID_FILE_PRINT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CView::OnFilePrintPreview)
	ON_COMMAND(ID_FILE_OPEN, OnFileOpen)

	ON_COMMAND(ID_FILE_SAVE, OnOpenPath)
	ON_WM_TIMER()
	ON_COMMAND(ID_SETV, OnSetv)
END_MESSAGE_MAP()

// CGraphicSearchView 构造/析构

CGraphicSearchView::CGraphicSearchView()
{
	// TODO: 在此处添加构造代码
	m_ShowPath = m_bShowPolice = m_bShowID = m_bVipPoint = m_bDraw = false;
	m_AllPointsMove = NULL;
	m_vist = 1000;
	//m_AllPointsMove = new PathPointArray [241];
}

CGraphicSearchView::~CGraphicSearchView()
{
	if(m_AllPointsMove!=NULL)
	{
		for(int i=0;i<241;i++)
		{
			m_AllPointsMove[i].RemoveAll();
		}
		delete [] m_AllPointsMove;
	}
	m_AllPointsMove = NULL;
}

BOOL CGraphicSearchView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: 在此处通过修改 CREATESTRUCT cs 来修改窗口类或
	// 样式

	return CView::PreCreateWindow(cs);
}

// CGraphicSearchView 绘制

void CGraphicSearchView::OnDraw(CDC* /*pDC*/)
{
	CGraphicSearchDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;

	if(m_bDraw)
	{
		CDC *pDc;
		pDc = GetDC();
		double x0,y0,x,y;
		double deltaX = (m_setCover.m_graphic.maxX-m_setCover.m_graphic.minX), deltaY = (m_setCover.m_graphic.maxY-m_setCover.m_graphic.minY);

		for(int i=0;i<m_setCover.m_graphic.m_gPoints.GetCount();i++)
		{
			x0 = (m_setCover.m_graphic.m_gPoints.GetAt(i).x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
			y0 = 670-(m_setCover.m_graphic.m_gPoints.GetAt(i).y - m_setCover.m_graphic.minY)/deltaY*600.0;

			for(int j=0;j<m_setCover.m_graphic.m_gPoints.GetAt(i).m_linkPoints.GetCount();j++)
			{
				if(j==0)
				{
					CBrush brush(RGB(0,0,255)),*oldBrush;
					oldBrush = pDc->SelectObject(&brush);
					pDc->Ellipse(x0-3,y0-3,x0+3,y0+3);
					pDc->SelectObject(oldBrush);
				}

				pDc->MoveTo(x0,y0);
				x = (m_setCover.m_graphic.m_gPoints.GetAt(m_setCover.m_graphic.m_gPoints.GetAt(i).m_linkPoints.GetAt(j)).x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
				y = 670-(m_setCover.m_graphic.m_gPoints.GetAt(m_setCover.m_graphic.m_gPoints.GetAt(i).m_linkPoints.GetAt(j)).y - m_setCover.m_graphic.minY)/deltaY*600.0;

				pDc->LineTo(x,y);
			}
		}

		if(m_ShowPath)
		{
			CDC *pDc;
			pDc = GetDC();
			int x,y;
			double deltaX = (m_setCover.m_graphic.maxX-m_setCover.m_graphic.minX), deltaY = (m_setCover.m_graphic.maxY-m_setCover.m_graphic.minY);

			for(int i=0;i<m_AllPointsMove[m_steps].GetCount();i++)
			{
				x = (m_AllPointsMove[m_steps].GetAt(i).x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
				y = 670-(m_AllPointsMove[m_steps].GetAt(i).y - m_setCover.m_graphic.minY)/deltaY*600.0;

				CBrush brush(RGB(255,0,0)),*oldBrush;
				oldBrush = pDc->SelectObject(&brush);
				pDc->Ellipse(x-5,y-5,x+5,y+5);
				pDc->SelectObject(oldBrush);

			}

			ReleaseDC(pDc);
		}

		ReleaseDC(pDc);
	}
	// TODO: 在此处为本机数据添加绘制代码
}


// CGraphicSearchView 打印

BOOL CGraphicSearchView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// 默认准备
	return DoPreparePrinting(pInfo);
}

void CGraphicSearchView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 打印前添加额外的初始化
}

void CGraphicSearchView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: 打印后添加清除过程
}


// CGraphicSearchView 诊断

#ifdef _DEBUG
void CGraphicSearchView::AssertValid() const
{
	CView::AssertValid();
}

void CGraphicSearchView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CGraphicSearchDoc* CGraphicSearchView::GetDocument() const // 非调试版本是内联的
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CGraphicSearchDoc)));
	return (CGraphicSearchDoc*)m_pDocument;
}
#endif //_DEBUG


// CGraphicSearchView 消息处理程序

void CGraphicSearchView::OnFileOpen()
{
	// TODO: 在此添加命令处理程序代码
	CString filePath;
	CFileDialog dlg(TRUE);///TRUE为OPEN对话框，FALSE为SAVE AS对话框
	if(dlg.DoModal()==IDOK)
	{
		if(m_AllPointsMove!=NULL)
		{
			for(int i=0;i<241;i++)
			{
				m_AllPointsMove[i].RemoveAll();
			}
			delete [] m_AllPointsMove;
			m_AllPointsMove = NULL;
		}

		m_AllPointsMove = new PathPointArray [241];

		filePath=dlg.GetPathName();
		m_setCover.m_graphic.ReadPointsData(filePath);

		filePath.Replace("Map.txt","Topo.txt");
		m_setCover.m_graphic.ReadToPoData(filePath);

		m_bDraw = TRUE;
		Invalidate();
	}

}

void CGraphicSearchView::OnOpenPath()
{
	// TODO: 在此添加命令处理程序代码
	CString filePath;
	CFileDialog dlg(TRUE);///TRUE为OPEN对话框，FALSE为SAVE AS对话框
	if(dlg.DoModal()==IDOK)
	{
		
		m_steps = 0;

		filePath=dlg.GetPathName();
		//m_AllPointsMove
		char tmpchars[256],ch;
		int tp;
		FILE *fp;
		int x,y;
		PathPoint pp;
		fp = fopen(filePath,"r");
		fscanf(fp,"%d",&m_icars);

		fgets(tmpchars,256,fp);
		for(int i=0;i<241;i++)
		{
			for(int j=0;j<m_icars;j++)
			{
				if(j==0)
					fscanf(fp,"%d",&tp);
				else
					fscanf(fp,"%c",&ch);
				fscanf(fp,"%c",&ch);
				fscanf(fp,"%c",&ch);
				
				fscanf(fp,"%d",&x);
				fscanf(fp,"%c",&ch);
				fscanf(fp,"%d",&y);
		
				pp.x = x;
				pp.y = y;
				m_AllPointsMove[i].Add(pp);
			}

			fscanf(fp,"%c",&ch);
			fscanf(fp,"%c",&ch);
		}

		fclose(fp);
		m_ShowPath = true;
		SetTimer(1,m_vist,NULL); 
	}
}

void CGraphicSearchView::OnTimer(UINT nIDEvent)
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值

	m_ShowPath = false;
	Invalidate();

	m_steps++;

	m_ShowPath = true;
	if(m_steps == 241)
		KillTimer(1);
	CView::OnTimer(nIDEvent);

}

void CGraphicSearchView::OnSetv()
{
	// TODO: 在此添加命令处理程序代码
	CSetAtrr dlg;

	KillTimer(1);
	if(dlg.DoModal()==IDOK)
	{
		m_vist = dlg.m_setTime;
	}
	SetTimer(1,m_vist,NULL); 
}




