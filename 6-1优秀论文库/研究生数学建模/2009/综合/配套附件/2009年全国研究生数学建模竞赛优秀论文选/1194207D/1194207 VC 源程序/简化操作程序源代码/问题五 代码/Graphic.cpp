#include "StdAfx.h"
#include ".\graphic.h"


CGraphic::CGraphic(void)
{
	minX = minY = maxX = maxY = 0;
	m_iPts = 0;
	//defaultLength = 2000/0.9;  
	//defaultLength = 2780/0.9; 
	defaultLength = 3250/0.9; //10
	//defaultLength = 2500/0.9;

	m_searchLinkPoints = NULL;
	m_gPoints.RemoveAll();
}

CGraphic::~CGraphic(void)
{
	if(m_searchLinkPoints!=NULL)
	{
		for(int i=0;i<m_iPts;i++)
		{
			m_searchLinkPoints[i].RemoveAll();
		}
		delete [] m_searchLinkPoints;
		m_searchLinkPoints = NULL;
	}
	m_gPoints.RemoveAll();
}

void CGraphic::ReadPointsData(CString &path)
{
	FILE *fp;
	fp = fopen(path,"r");
	int id, x, y;
	GPoint p;
	//int minX, minY, maxX, maxY;
	/*if(m_searchLinkPoints!=NULL)
	{
		for(int i=0;i<m_iPts;i++)
		{
			m_searchLinkPoints[i].RemoveAll();
		}
		delete [] m_searchLinkPoints;
		m_searchLinkPoints= NULL;
	}*/ 
	m_gPoints.RemoveAll();

	fscanf(fp,"%d%d%d",&id,&x,&y);
	minX = x;
	maxX = x;
	minY = y;
	maxY = y;
	while(1)
	{
		p.m_ID = id-1;
		p.x = x;
		p.y = y;
		m_gPoints.Add(p);
		fscanf(fp,"%d%d%d",&id,&x,&y);
		m_iPts++;

		if(id == -1) break;

		if(minX > x) 
			minX = x;
		if(maxX < x) 
			maxX = x;
		if(minY > y) 
			minY = y;
		if(maxY < y) 
			maxY = y;
	}
	fclose(fp);
}

void CGraphic::ReadToPoData(CString &path)
{
	FILE *fp;
	fp = fopen(path,"r");
	int id1, id2;
	bool exist = false;
	GPoint p;
	
	m_iEdges = 0;

	fscanf(fp,"%d%d",&id1,&id2);
	while(id1!=-1 && id2!=-1)
	{
		m_iEdges++;
		m_gPoints.GetAt(id1-1).m_linkPoints.Add(id2-1);
		exist = false;
		for(int i=0;i<m_gPoints.GetAt(id2-1).m_linkPoints.GetCount();i++)
		{
			if(id1-1 == m_gPoints.GetAt(id2-1).m_linkPoints.GetAt(i))
				exist = true;
		}
		if(!exist)
			m_gPoints.GetAt(id2-1).m_linkPoints.Add(id1-1);
		fscanf(fp,"%d%d",&id1,&id2);
	}
	fclose(fp);
}

void CGraphic::DensifyPoints(double length)
{
	int tID, ID1, ID2, curID;
	FILE *fp1,*fp2;
	fp1 = fopen("newPoints.txt","w+");
	fp2 = fopen("newTopo.txt","w+");

	for(int i=0;i<m_gPoints.GetCount();i++)
	{
		fprintf(fp1,"%d %d %d\n",i+1,m_gPoints.GetAt(i).x,m_gPoints.GetAt(i).y);
	}
	curID = m_gPoints.GetCount()+1;

	
	///////////////////////////////////////////////////////////////////////////
	//插点
	for(int i=0;i<m_gPoints.GetCount();i++)
	{

		double x1,x2,y1,y2;
		for(int j=0;j<m_gPoints.GetAt(i).m_linkPoints.GetCount();j++)
		{
			ID1 = i;
			ID2 = m_gPoints.GetAt(i).m_linkPoints.GetAt(j);

			//不重复建立topo
			for(int k=0;k<m_gPoints.GetAt(ID2).m_linkPoints.GetCount();k++)
			{
				if(m_gPoints.GetAt(ID2).m_linkPoints.GetAt(k) == ID1)
				{
					m_gPoints.GetAt(ID2).m_linkPoints.RemoveAt(k);
					break;
				}
			}

			x1 = m_gPoints.GetAt(ID1).x;
			y1 = m_gPoints.GetAt(ID1).y;
			x2 = m_gPoints.GetAt(ID2).x;
			y2 = m_gPoints.GetAt(ID2).y;

			ID1++;
			tID = ID1;
			ID2++;

			///////////////////////////////////////////////////////////////////////
			//直接Topo写文件
			GPoint ptTemp;
			int n;
			int divideNum;
			double deltaX, deltaY, distance = Distance(x1,y1, x2,y2);
			divideNum = ceil(distance/length);

			deltaX = x2 - x1;
			deltaY = y2 - y1;
			for (n=1; n<divideNum; n++)
			{
				ptTemp.x = x1 + n*deltaX/(divideNum*1.0);
				ptTemp.y = y1 + n*deltaY/(divideNum*1.0);

				//写点
				fprintf(fp1,"%d %d %d\n",curID,ptTemp.x,ptTemp.y);
				//写拓扑
				fprintf(fp2,"%d %d\n",tID,curID);

				tID = curID;
				curID++;
			}

			//写最后一点的拓扑
			if(divideNum > 1)
				fprintf(fp2,"%d %d\n",curID-1,ID2);
			else
				fprintf(fp2,"%d %d\n",ID1,ID2);
		}
	}

	fprintf(fp1,"-1 -1 -1");
	fprintf(fp2,"-1 -1");
	fclose(fp1);
	fclose(fp2);
}

void CGraphic::WriteData(CString &path)
{
	FILE *fp;
	fp = fopen(path,"w");
	
	fprintf(fp,"%d\n",m_iPts);

	for(int i=0;i<m_iPts;i++)
	{
		for(int j=0;j<m_searchLinkPoints[i].GetCount();j++)
		{
			fprintf(fp,"%d ",m_searchLinkPoints[i].GetAt(j)+1);
			if(j==0)
				fprintf(fp,"%d ",m_searchLinkPoints[i].GetCount()-1);
		}

		//点链接序号
		/*for(int j=0;j<m_searchLinkPoints[i].GetCount();j++)
		{
			fprintf(fp,"%d ",m_searchLinkPoints[i].GetAt(j)+1);
			if(j==0)
				fprintf(fp,"-> ");
		}*/

		//fprintf(fp,"%d ",m_searchLinkPoints[i].GetAt(0)+1);      //序号
		//fprintf(fp,"%d  ",m_searchLinkPoints[i].GetCount()-1);   //链接点个数

		fprintf(fp,"\n");
	}
	fprintf(fp,"-1");
	fclose(fp);
}

/////////////////////////////////////////////////////////////////////////
double CGraphic::Distance(int x1, int y1, int x2, int y2)
{
	return sqrt((double)((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)));
}

//出现则返回TRUE,没出现返回FALSE
bool CGraphic::IsExsitID(int curID, int ID)
{
	for(int i=0;i<m_searchLinkPoints[curID].GetCount();i++)
	{
		if(ID == m_searchLinkPoints[curID].GetAt(i))
		{
			return true;
		}
	}
	return false;
}

void CGraphic::SearchAllLinkPoints()
{
	int curID, id;
	int x0,y0,x,y;
	double dis,tmpDis;
	CIDArray tmpLinks;
	CArray<double, double>distanceArray;
	m_searchLinkPoints = new CIDArray[m_iPts];

	//查找符合条件（距离在defaultLength距离范围内）
	for(int i=0;i<m_iPts;i++)
	{
	
		tmpLinks.RemoveAll();
		distanceArray.RemoveAll();
		m_searchLinkPoints[i].RemoveAll();

		m_searchLinkPoints[i].Add(i);   //第一个元素是本身
		x0 = m_gPoints.GetAt(i).x;
		y0 = m_gPoints.GetAt(i).y;

		//判断当前节点的邻接点中是否存在不符合条件的节点
		for(int j=0;j<m_gPoints.GetAt(i).m_linkPoints.GetCount();j++)
		{
			x = m_gPoints.GetAt(m_gPoints.GetAt(i).m_linkPoints.GetAt(j)).x;
			y = m_gPoints.GetAt(m_gPoints.GetAt(i).m_linkPoints.GetAt(j)).y;
			dis = Distance(x0,y0,x,y);

			if(dis < defaultLength)
			{
				m_searchLinkPoints[i].Add(m_gPoints.GetAt(i).m_linkPoints.GetAt(j));
				tmpLinks.Add(m_gPoints.GetAt(i).m_linkPoints.GetAt(j));
				distanceArray.Add(defaultLength - dis);
			}
		}

		//查找所有符合条件的节点
		while(tmpLinks.GetCount()>0)
		{
			curID = tmpLinks.GetAt(0);
			tmpLinks.RemoveAt(0);
			dis = distanceArray.GetAt(0);
			distanceArray.RemoveAt(0);

			x0 = m_gPoints.GetAt(curID).x;
			y0 = m_gPoints.GetAt(curID).y;

			for(int j=0;j<m_gPoints.GetAt(curID).m_linkPoints.GetCount();j++)
			{
				id = m_gPoints.GetAt(curID).m_linkPoints.GetAt(j);
				if(IsExsitID(i, id))
					continue;

				x = m_gPoints.GetAt(id).x;
				y = m_gPoints.GetAt(id).y;
				tmpDis = Distance(x0,y0,x,y);
				if(tmpDis > dis)
					continue;

				//继续进队列
				m_searchLinkPoints[i].Add(id);
				tmpLinks.Add(id);
				distanceArray.Add(dis - tmpDis);
			}
		}
	}
	tmpLinks.RemoveAll();
	distanceArray.RemoveAll();
}

