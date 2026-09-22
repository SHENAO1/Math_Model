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
	ON_COMMAND(ID_FILE_SAVE, OnFileSave)
	ON_COMMAND(ID_OPERATION_READVIPPOINT, OnOperationReadvippoint)
	ON_COMMAND(ID_OPERATION_SEARCHALLLINKS, OnOperationSearchalllinks)
	ON_COMMAND(ID_OPERATION_SHOWID, OnOperationShowid)
	ON_COMMAND(ID_OPERATION_GETSETCOVER, OnOperationGetsetcover)
	ON_COMMAND(ID_OPERATION_INITPROCSETCOVER, OnOperationInitprocsetcover)
	ON_COMMAND(ID_OPERATION_DENSIFYPOINTS, OnOperationDensifypoints)
	ON_COMMAND(ID_OPERATION_GETNEXTSETCOVER, OnOperationGetnextsetcover)
	ON_COMMAND(ID_OPERATION_SHOWSEARCHLINK, OnOperationShowsearchlink)
	ON_COMMAND(ID_OPERATION_GREEDYOPT, OnOperationGreedyopt)
	ON_COMMAND(ID_POLICECARSEARCH_SEARCHMOVEPATH, OnPolicecarsearchSearchmovepath)
	ON_COMMAND(ID_POLICECARSEARCH_CALCULATETARGET, OnPolicecarsearchCalculatetarget)
	ON_COMMAND(ID_ALLOP, OnAllop)
END_MESSAGE_MAP()

// CGraphicSearchView 构造/析构

CGraphicSearchView::CGraphicSearchView()
{
	// TODO: 在此处添加构造代码
	m_bShowPolice = m_bShowID = m_bVipPoint = m_bDraw = false;
}

CGraphicSearchView::~CGraphicSearchView()
{
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

		if(m_bVipPoint)
		{
			CBrush brush(RGB(255,255,0)),*oldBrush;
			oldBrush = pDc->SelectObject(&brush);
			for(int i=0;i<3;i++)
			{
				//if(i==1)
				//	x0 = (m_VipPoint[i].x - m_setCover.m_graphic.minX)/deltaX*900.0 + 55;
				//else
					x0 = (m_VipPoint[i].x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;

				y0 = 670-(m_VipPoint[i].y - m_setCover.m_graphic.minY)/deltaY*600.0;
				pDc->Rectangle(x0-8,y0-8,x0+8,y0+8);
			}
			pDc->SelectObject(oldBrush);
		}

		if(m_bShowID)
		{
			CString word;
			for(int i=0;i<m_setCover.m_graphic.m_gPoints.GetCount();i++)
			{
				x0 = (m_setCover.m_graphic.m_gPoints.GetAt(i).x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
				y0 = 670-(m_setCover.m_graphic.m_gPoints.GetAt(i).y - m_setCover.m_graphic.minY)/deltaY*600.0;

				word.Format("%d", i+1);
				pDc->TextOut(x0,y0+5,word);
			}
		}

		if(m_bShowPolice)
		{
			CBrush brush(RGB(255,0,255)),*oldBrush;
			oldBrush = pDc->SelectObject(&brush);
			for(int i=0;i<m_setCover.m_cover.GetCount();i++)
			{
				x0 = (m_setCover.m_graphic.m_gPoints.GetAt(m_setCover.m_cover.GetAt(i)).x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
				y0 = 670-(m_setCover.m_graphic.m_gPoints.GetAt(m_setCover.m_cover.GetAt(i)).y - m_setCover.m_graphic.minY)/deltaY*600.0;

				pDc->Ellipse(x0-8,y0-8,x0+8,y0+8);
			}
			pDc->SelectObject(oldBrush);
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
		filePath=dlg.GetPathName();
		m_setCover.m_graphic.ReadPointsData(filePath);

		if(filePath.Find("newMap.txt") != -1)
			filePath.Replace("newMap.txt","newTopo.txt");
		else
			filePath.Replace("Map.txt","Topo.txt");
			
		m_setCover.m_graphic.ReadToPoData(filePath);
		
		m_bDraw = TRUE;
		Invalidate();
	}

}

void CGraphicSearchView::OnFileSave()
{
	// TODO: 在此添加命令处理程序代码
	CString filePath;
	CFileDialog dlg(false);///TRUE为OPEN对话框，FALSE为SAVE AS对话框
	if(dlg.DoModal()==IDOK)
	{
		filePath=dlg.GetPathName();

		filePath=dlg.GetPathName();
		m_setCover.m_graphic.WriteData(filePath);
	}

}

void CGraphicSearchView::OnOperationReadvippoint()
{
	// TODO: 在此添加命令处理程序代码
	CString filePath;
	CFileDialog dlg(TRUE);///TRUE为OPEN对话框，FALSE为SAVE AS对话框
	if(dlg.DoModal()==IDOK)
	{
		int x,y;
		filePath=dlg.GetPathName();
		
		
		FILE *fp;
		fp = fopen(filePath,"r");
		for(int i=0;i<3;i++)
		{
			fscanf(fp,"%d%d",&x,&y);
			m_VipPoint[i].x = x;
			m_VipPoint[i].y = y;
		}
		fclose(fp);
		
		m_bVipPoint = TRUE;
		Invalidate();
	}
}

void CGraphicSearchView::OnOperationSearchalllinks()
{
	// TODO: 在此添加命令处理程序代码
	m_setCover.m_graphic.SearchAllLinkPoints();
	//AfxMessageBox("Data solved over!");
}

void CGraphicSearchView::OnOperationShowid()
{
	// TODO: 在此添加命令处理程序代码
	m_bShowID = !m_bShowID;

	Invalidate();
}

////////////////////////////////////////////////////////////////////////////

void CGraphicSearchView::OnOperationGetsetcover()
{
	// TODO: 在此添加命令处理程序代码
	CString filePath;
	CFileDialog dlg(TRUE);///TRUE为OPEN对话框，FALSE为SAVE AS对话框
	if(dlg.DoModal()==IDOK)
	{
		filePath=dlg.GetPathName();
		m_setCover.ReadData(filePath);
	}
	//AfxMessageBox("Read data over!");
}

void CGraphicSearchView::OnOperationInitprocsetcover()
{
	// TODO: 在此添加命令处理程序代码
	m_setCover.SCHF();

	m_bShowPolice = true;

	FILE *fp;
	fp = fopen("SearchAnswer.txt","w+");
	for(int k=0;k<m_setCover.m_cover.GetCount();k++)
	{
		int pos = m_setCover.m_cover.GetAt(k);

		fprintf(fp,"%d ",pos);
		for(int i=1;i<m_setCover.m_graphic.m_searchLinkPoints[pos].GetCount();i++)
		{
			fprintf(fp,"%d ",m_setCover.m_graphic.m_searchLinkPoints[pos].GetAt(i));

		}
		fprintf(fp,"\n");
	}

	fclose(fp);

	Invalidate();
}

void CGraphicSearchView::OnOperationDensifypoints()
{
	// TODO: 在此添加命令处理程序代码
	m_setCover.m_graphic.DensifyPoints(334.0);
	
}

void CGraphicSearchView::OnOperationGetnextsetcover()
{
	// TODO: 在此添加命令处理程序代码
	CString filePath;
	CFileDialog dlg(TRUE);///TRUE为OPEN对话框，FALSE为SAVE AS对话框
	if(dlg.DoModal()==IDOK)
	{
		filePath=dlg.GetPathName();
		m_setCover.ReadBanery(filePath);
	}
	
}

void CGraphicSearchView::OnOperationShowsearchlink()
{
	// TODO: 在此添加命令处理程序代码
	PathPointArray tmpPoints;

	for(int k=0;k<m_setCover.m_cover.GetCount();k++)
	{

		//检验点连接点的正确性
		/*if(k==0)
		{

			int x,y;
			double deltaX = (m_setCover.m_graphic.maxX-m_setCover.m_graphic.minX), 
				deltaY = (m_setCover.m_graphic.maxY-m_setCover.m_graphic.minY);

			CDC *pDc = GetDC();
			CBrush brush1(RGB(255,0,0)),brush2(RGB(0,255,0)),*oldBrush;		

			for(int i=0;i<=240;i++)
			{
				tmpPoints.Add(m_setCover.m_pathPointsArray[k].GetAt(i));

				x = m_setCover.m_pathPointsArray[k].GetAt(i).x;
				y = m_setCover.m_pathPointsArray[k].GetAt(i).y;

				x = (x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
				y = 670-(y - m_setCover.m_graphic.minY)/deltaY*600.0;

				//if(i==0)
				{
					oldBrush = pDc->SelectObject(&brush1);
					pDc->Ellipse(x-8,y-8,x+8,y+8);
					pDc->SelectObject(oldBrush);
					
					Sleep(10);
					//Invalidate(true);
				}
				//else
				//{
				//	oldBrush = pDc->SelectObject(&brush2);
				//	pDc->Ellipse(x-5,y-5,x+5,y+5);
				//}
				
			}

			oldBrush = pDc->SelectObject(&brush2);
			pDc->SelectObject(oldBrush);

			ReleaseDC(pDc);
		}
		//else continue;*/

		
		//if(k!=13 && k!=18 && k!=9)      //距离重要位置最近的三点
		//	continue;

		int pos = m_setCover.m_cover.GetAt(k);
		int x,y;
		double deltaX = (m_setCover.m_graphic.maxX-m_setCover.m_graphic.minX), deltaY = (m_setCover.m_graphic.maxY-m_setCover.m_graphic.minY);

		x = m_setCover.m_graphic.m_gPoints.GetAt(pos).x;
		y = m_setCover.m_graphic.m_gPoints.GetAt(pos).y;


		CDC *pDc = GetDC();
		CBrush brush1(RGB(255,0,0)),brush2(RGB(0,255,0)),*oldBrush;
		oldBrush = pDc->SelectObject(&brush1);
		x = (x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
		y = 670-(y - m_setCover.m_graphic.minY)/deltaY*600.0;
		pDc->Ellipse(x-8,y-8,x+8,y+8);
		pDc->SelectObject(oldBrush);


		oldBrush = pDc->SelectObject(&brush2);
		for(int i=1;i<m_setCover.m_graphic.m_searchLinkPoints[pos].GetCount();i++)
		{
			x = (m_setCover.m_graphic.m_gPoints.GetAt(m_setCover.m_graphic.m_searchLinkPoints[pos].GetAt(i)).x - m_setCover.m_graphic.minX)/deltaX*900.0 + 50;
			y = 670-(m_setCover.m_graphic.m_gPoints.GetAt(m_setCover.m_graphic.m_searchLinkPoints[pos].GetAt(i)).y - m_setCover.m_graphic.minY)/deltaY*600.0;
			pDc->Ellipse(x-5,y-5,x+5,y+5);
		}
		pDc->SelectObject(oldBrush);

		ReleaseDC(pDc);

		//Sleep(100);
	}

	/*
	FILE *fp;
	fp = fopen("7searchRoads.txt","w+");
	for(int i=0;i<tmpPoints.GetCount();i++)
	{
		fprintf(fp,"(%d, %d)\n",tmpPoints.GetAt(i).x,tmpPoints.GetAt(i).y);
	}
	fclose(fp);*/
}

void CGraphicSearchView::OnOperationGreedyopt()
{
	// TODO: 在此添加命令处理程序代码
	m_setCover.Greedy();
	CString ms;
	ms.Format("贪心优化后剩余车辆数: %d",m_setCover.m_cover.GetCount());
	AfxMessageBox(ms);
}

void CGraphicSearchView::OnPolicecarsearchSearchmovepath()
{
	// TODO: 在此添加命令处理程序代码
	m_setCover.m_pathArray = new SegmentPathArray [m_setCover.m_cover.GetCount()];     //保存所有警车搜索路径
	m_setCover.m_pathPointsArray = new PathPointArray [m_setCover.m_cover.GetCount()]; //保存所有警车搜索路径点
	
	for(int i=0;i<m_setCover.m_cover.GetCount();i++)
	{
		m_setCover.ShowPoliceCarMove(i,240);
	}
	AfxMessageBox("求解4小时巡逻警车分布完毕！");
}

void CGraphicSearchView::OnPolicecarsearchCalculatetarget()
{
	// TODO: 在此添加命令处理程序代码

	m_setCover.GetTargetThree();

	AfxMessageBox("指标计算完毕！ 请保存最终计算文件！");
	/////////////////////////////////////////////////
	//写入文件：保存每辆车所经过的所有点
	CString filePath;
	CFileDialog dlg(false);///TRUE为OPEN对话框，FALSE为SAVE AS对话框
	if(dlg.DoModal()==IDOK)
	{
		filePath=dlg.GetPathName();

		FILE *fp;
		fp = fopen(filePath,"w+");

		fprintf(fp,"%d,%0.1lf66,%0.3lf,%0.3lf,%0.3lf\n",m_setCover.m_cover.GetCount(),m_setCover.m_avgAll,m_setCover.m_fReGo,m_setCover.m_avgTime,m_setCover.m_fPath);

		for(int i=0;i<=240;i++)
		{
			fprintf(fp,"%d",i);
			for(int k=0;k<m_setCover.m_cover.GetCount();k++)
			{
				fprintf(fp,",(%d,%d)",m_setCover.m_pathPointsArray[k].GetAt(i).x,
					m_setCover.m_pathPointsArray[k].GetAt(i).y);
			}
			fprintf(fp,"\n");
		}
		fprintf(fp,"End");
		fclose(fp);
	}
}

void CGraphicSearchView::OnAllop()
{
	// TODO: 在此添加命令处理程序代码

	OnOperationSearchalllinks();
	CString path;
	path = ".\\SearchTopoInfo.txt";
	m_setCover.m_graphic.WriteData(path);

	path = ".\\SearchTopoInfo.txt";
	m_setCover.ReadData(path);

	path = ".\\TopoMatrix.txt";
	m_setCover.ReadBanery(path);

	AfxMessageBox("数据处理，拓扑建立完毕！");
}


