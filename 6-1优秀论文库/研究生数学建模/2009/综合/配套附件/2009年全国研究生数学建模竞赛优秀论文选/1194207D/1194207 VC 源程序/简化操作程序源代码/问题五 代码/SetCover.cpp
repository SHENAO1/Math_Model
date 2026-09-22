#include "StdAfx.h"
#include ".\setcover.h"

CSetCover::CSetCover(void)
{
	m_tmpMatrix = NULL;
	m_Matrix = NULL;
	m_ModS = NULL;
	m_K = NULL;
	m_P = NULL;
	m_R = NULL;
	m_F = NULL;
	m_flag = NULL;
	m_weight = NULL;
	m_space = NULL;
	m_linkList = NULL;
	m_pathArray = NULL;
	m_pathPointsArray = NULL;
}

CSetCover::~CSetCover(void)
{
	if(m_Matrix!=NULL)
	{
		for(int i=row;i<row;i++)
			delete [] m_Matrix[i];
		delete [] m_Matrix;
		m_Matrix = NULL;
	}
	if(m_tmpMatrix!=NULL)
	{
		for(int i=row;i<row;i++)
			delete [] m_tmpMatrix[i];
		delete [] m_tmpMatrix;
		m_tmpMatrix = NULL;
	}
	if(m_ModS!=NULL)
	{
		delete [] m_ModS;
	}
	if(m_K!=NULL)
	{
		delete [] m_K;
	}
	if(m_P!=NULL)
	{
		delete [] m_P;
	}
	if(m_R!=NULL)
	{
		delete [] m_R;
	}
	if(m_F!=NULL)
	{
		delete [] m_F;
	}
	if(m_flag!=NULL)
	{
		delete [] m_flag;
	}
	if(m_weight!=NULL)
	{
		delete [] m_weight;
	}
	if(m_space!=NULL)
	{
		delete [] m_space;
	}
	if(m_linkList!=NULL)
	{
		delete [] m_linkList;
	}
	if(m_pathArray!=NULL)
	{
		delete [] m_pathArray;
	}
	if(m_pathPointsArray!=NULL)
	{
		delete [] m_pathPointsArray;
	}
	m_carNodes.RemoveAll();
}

void CSetCover::ReadData(CString &path)
{
	FILE *fp;
	int id,lks,value;
	fp = fopen(path,"r");
	fscanf(fp,"%d",&row);
	col = row;
	N = col;

	m_Matrix = new int*[row];
	for(int i=0;i<row;i++)
	{
		m_Matrix[i] = new int [col];
		memset(m_Matrix[i],0,col*(sizeof(int)));
	}

	for(int i=0;i<row;i++)
	{
		//SValue.Add(i);

		fscanf(fp,"%d%d",&id,&lks);
		m_Matrix[id-1][id-1] = 1;
		for(int j=0;j<lks;j++)
		{
			fscanf(fp,"%d",&value);
			m_Matrix[value-1][id-1] = 1;
		}
	}

	/*for(int i=0;i<row;i++)
	{
		for(int j=0;j<col;j++)
			afxDump<<m_Matrix[i][j]<<" ";
		afxDump<<"\n";
	}*/

	fclose(fp);

	fp = fopen("TopoMatrix.txt","w+");
	fprintf(fp,"%d %d\n",row,col);
	for(int i=0;i<row;i++)
	{
		for(int j=0;j<col;j++)
			fprintf(fp,"%d ",m_Matrix[i][j]);

		fprintf(fp,"\n");
	}
	fclose(fp);

}

void CSetCover::ReadBanery(CString &path)
{

	FILE *fp;
	//int id,lks,value;

	if(m_tmpMatrix!=NULL)
	{
		for(int i=row;i<row;i++)
			delete [] m_tmpMatrix[i];
		delete [] m_tmpMatrix;
		m_tmpMatrix = NULL;
	}
	if(m_Matrix!=NULL)
	{
		for(int i=row;i<row;i++)
			delete [] m_Matrix[i];
		delete [] m_Matrix;
		m_Matrix = NULL;
	}
	if(m_ModS!=NULL)
	{
		delete [] m_ModS;
	}
	if(m_K!=NULL)
	{
		delete [] m_K;
	}
	if(m_P!=NULL)
	{
		delete [] m_P;
	}
	if(m_R!=NULL)
	{
		delete [] m_R;
	}
	if(m_F!=NULL)
	{
		delete [] m_F;
	}
	if(m_flag!=NULL)
	{
		delete [] m_flag;
	}
	if(m_weight!=NULL)
	{
		delete [] m_weight;
	}

	fp = fopen(path,"r");
	fscanf(fp,"%d %d",&row,&col);

	N = col;

	m_tmpMatrix = new int*[row];
	for(int i=0;i<row;i++)
	{
		m_tmpMatrix[i] = new int [col];
		memset(m_tmpMatrix[i],0,col*(sizeof(int)));
	}

	m_Matrix = new int*[row];
	for(int i=0;i<row;i++)
	{
		m_Matrix[i] = new int [col];
		memset(m_Matrix[i],0,col*(sizeof(int)));
	}

	m_weight = new int [col];
	memset(m_weight,0,col*(sizeof(int)));

	SValue.RemoveAll();
	for(int i=0;i<row;i++)
	{
		SValue.Add(i);
		for(int j=0;j<col;j++)
		{
			fscanf(fp,"%d",&m_Matrix[i][j]);
			m_tmpMatrix[i][j] = m_Matrix[i][j];
			if(m_Matrix[i][j] == 1)
			{
				m_weight[j]++;
			}
		}
	}

	/*for(int i=0;i<row;i++)
	{
		for(int j=0;j<col;j++)
		afxDump<<m_Matrix[i][j]<<" ";
		afxDump<<"\n";
	}*/

	fclose(fp);

}

void CSetCover::GetModS()
{
	if(m_ModS!=NULL)
	{
		delete [] m_ModS;
	}
	m_ModS = new int [col];
	memset(m_ModS,0,col*(sizeof(int)));
	for(int i=0;i<col;i++)
	{
		for(int j=0;j<row;j++)
		{
			m_ModS[i] += m_Matrix[j][i];
		}
	}
}

void CSetCover::GetK()
{
	if(m_K!=NULL)
	{
		delete [] m_K;
	}
	m_K = new int [row];
	memset(m_K,0,row*(sizeof(int)));
	for(int i=0;i<row;i++)
	{
		for(int j=0;j<col;j++)
		{
			if(m_flag[j])
				m_K[i] += m_Matrix[i][j];
		}
	}
}

int CSetCover::ReGetK(int cl)
{
	int K=0;
	for(int i=0;i<row;i++)
	{
		if(m_K[i] - m_Matrix[i][cl] == 1)
			K++;
	}

	return K;
}

void CSetCover::GetP()
{
	if(m_P!=NULL)
	{
		delete [] m_P;
	}
	m_P = new int [col];
	memset(m_P,0,col*(sizeof(int)));

	
	for(int i=0;i<col;i++)
	{
		int sml = 32767;

		if(m_flag[i])
		{
			/*for(int j=0;j<row;j++)
			{
				if(m_Matrix[j][i]==1)
				{
					sml = m_K[j];
					break;
				}
			}*/
			for(int j=0;j<row;j++)
			{
				if(m_Matrix[j][i]==1)
				{
					if(sml > m_K[j])
						sml = m_K[j];
				}
			}
			m_P[i] = sml;
		}
		else
			m_P[i] = -1;
	}

}
void CSetCover::GetR()
{
	if(m_R!=NULL)
	{
		delete [] m_R;
	}
	m_R = new int [col];
	memset(m_R,0,col*(sizeof(int)));

	for(int i=0;i<col;i++)
	{
		if(m_flag[i])
			m_R[i] = ReGetK(i);
		else
			m_R[i] = -1;
	}
}

bool CSetCover::CheckIn(int col1, int col2)
{
	for(int i=0;i<row;i++)
	{
		if(m_Matrix[i][col1] == 1)
		{
			if(m_Matrix[i][col2] != 1)
				return false;
		}
	}
	return true;
}

void CSetCover::InitProcess()
{
	m_flag = new bool [col];

	for(int i=0;i<col;i++)
		m_flag[i] = TRUE;

	GetModS();
	GetK();
	GetP();
	GetR();
}

bool CSetCover::Check(int col)
{
	for(int i=0;i<SValue.GetCount();i++)
	{
		if(1 != m_Matrix[SValue.GetAt(i)][col])
			return false;
	}
	return true;
}

void CSetCover::GetF()
{
	int a,b;

	double tmpMinF, tmpMaxF;
	m_F = new double [col];
	memset(m_F,0,col*(sizeof(double)));

	a = 1;
	b = 1;

	N = 0;

	N = SValue.GetCount();
	L = a*(1+N) + b;
	
	minSID = 0;
	maxSID = 0;

	for(int i=0;i<col;i++)
	{
		if(m_flag[i])
		{	
			if(Check(i))
			{
				m_cover.Add(i);
				SValue.RemoveAll();
				return;
			}

			if(m_P[i]-1 == 0 || N - m_ModS[i] == 0)
			{
				m_F[i] = 32767;
			}
			else
			{
				m_F[i] = a*(1+m_R[i])/((m_P[i]-1)*1.0);
				m_F[i] += b*(1.0/(N-m_ModS[i]));

				m_F[i] += 2*m_weight[i];
			}
		}
		else
		{
			m_F[i] = -1;
		}
	}

	int basicIndex = -1;
	for(int i=0;i<col;i++)
	{
		if(m_F[i] != -1)
		{
			basicIndex = i;
			tmpMinF = m_F[i];
			tmpMaxF = m_F[i];
			minSID = i;
			maxSID = i;
			break;
		}
	}

	for(int i=basicIndex+1;i<col;i++)
	{
		if(m_F[i] != -1)
		{
			if(tmpMinF > m_F[i])
			{
				tmpMinF = m_F[i];
				minSID = i;
			}
			else if(tmpMinF == m_F[i])
			{
				/*int ms1=0,ms2=0;
				for(int k=0;k<row;k++)
				{
					if(m_Matrix[k][minSID] == 1)
						ms1 ++;
					if(m_Matrix[k][i] == 1)
						ms2 ++;
				}*/
				//if(ms1 > ms2)
				//	minSID = i;
				if(m_weight[minSID] > m_weight[i])
					minSID = i;
			}
			if(tmpMaxF < m_F[i])
			{
				tmpMaxF = m_F[i];
				maxSID = i;
			}
			else if(tmpMaxF == m_F[i])
			{
				/*int ms1=0,ms2=0;
				for(int k=0;k<row;k++)
				{
					if(m_Matrix[k][maxSID] == 1)
						ms1 ++;
					if(m_Matrix[k][i] == 1)
						ms2 ++;
				}*/
				//if(ms1 < ms2)
				//	maxSID = i;
				if(m_weight[maxSID] < m_weight[i])
					maxSID = i;
			}
		}
	}
	
}

bool CSetCover::Finish()
{
	if(SValue.GetCount()>0)
		return false;
	return true;
}

void CSetCover::SCHF()
{
	m_cover.RemoveAll();

	/*
	初值,   COVER = {0}, COVER0= {S1, S2,. . . , Sm};
	第1 步. 求出使F (S i) 最大的Si0和使F(Si) 最小的Sj0 (其中Si, Si0, Sj0∈COV ER 0) ;
	第2 步. 如果F(Si0) > L , 则COVER = COVER + {Si0}, S = S - Si0, COVER0= COVER 0- {Si0},
	        否则 COVER 0= COVER0- {Sj0};
	第3 步. 如果S = 0 , 则输出COVER 之后停机, 否则返回第1 步.
	*/

	//int *counts;
	
	//counts = new int [row];
	//memset(counts,0,row*(sizeof(int)));

	InitProcess();

	do
	{
		GetF();

		if(Finish())
			break;
		
		if(m_F[maxSID] - 2*m_weight[maxSID] > L)
		{
			m_cover.Add(maxSID);
			for(int i=0;i<row;i++)
			{
				if(m_Matrix[i][maxSID]==1)
				{
					for(int j=0;j<SValue.GetCount();j++)
					{
						if(SValue.GetAt(j) == i)
						{
							SValue.RemoveAt(j);
							break;
						}
					}
				}
			}
			for(int k1=0;k1<row;k1++)
			{
				if(m_Matrix[k1][maxSID]==1)
				{
					for(int k2=0;k2<col;k2++)
					{
						m_Matrix[k1][k2] = 0;
					}
				}
			}
			m_flag[maxSID] = false;
		}
		else 
		{
			m_flag[minSID] = false;
		}

		///////////////////////////////////////////////////////////////////////
		//覆盖90%实现模拟
		/*int tmpcol, cns=0;
		double bit = 0.0;
		for(int i=0;i<m_cover.GetCount();i++)
		{
			tmpcol = m_cover.GetAt(i);
			for(int j=0;j<row;j++)
			{
				if(m_tmpMatrix[j][tmpcol] == 1)
					counts[j] = 1;
			}
		}
		cns = 0;
		for(int i=0;i<row;i++)
		{
			if(counts[i]==1)
				cns++;
		}
		bit = (double)cns/row; 
		if(bit > 0.9)
			break;*/
		///////////////////////////////////////////////////////////////////////

		GetModS();
		GetK();
		GetP();
		GetR(); 

	}while(!Finish());

	CString ms;
	ms.Format("all link points: %d",m_cover.GetCount());
	AfxMessageBox(ms);


	//解的矩阵
	FILE *fp;
	fp = fopen("AnswerMatrix.txt","w+");
	fprintf(fp,"%d %d\n",row,m_cover.GetCount());

	//列号
	//for(int j=0;j<m_cover.GetCount();j++)
	//{
	//	fprintf(fp,"%d ",m_cover.GetAt(j)+1);
	//}
	//fprintf(fp,"\n");
	//fprintf(fp,"\n");

	for(int i=0;i<row;i++)
	{
		for(int j=0;j<m_cover.GetCount();j++)
		{
			fprintf(fp,"%d ",m_tmpMatrix[i][m_cover.GetAt(j)]);
		}

		fprintf(fp,"\n");
	}
	fclose(fp);

	//delete [] counts;
	//counts = NULL;
	
}


/////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
//贪心策略，检测是否完备覆盖整个集合
bool CSetCover::Check(IntArray &cover)
{
	for(int i=0;i<cover.GetCount();i++)
	{
		for(int j=0;j<row;j++)
		{
			if(m_tmpMatrix[j][cover.GetAt(i)] == 1)
			{
				m_space[j]=1;
			}
		}
	}

	for(int i=0;i<row;i++)
	{
		if(m_space[i]==0)
			return false;
	}

	return true;
}

void CSetCover::Greedy()
{
	int id, index, wt;
	IntArray cover;

	if(m_space!=NULL)
	{
		delete [] m_space;
	}
	m_space = new int [row];
	//memset(m_space,0,row*(sizeof(int)));
	for(int i=0;i<row;i++)
		m_space[i]=0;

	while(true)
	{
		wt=0;
		for(int i=0;i<m_cover.GetCount();i++)
		{
			if(wt < m_weight[m_cover.GetAt(i)])
			{
				wt = m_weight[m_cover.GetAt(i)];
				id = m_cover.GetAt(i);
				index = i;
			}
		}
		cover.Add(id);
		m_cover.RemoveAt(index);

		if(Check(cover))
			break;
	}

	if(cover.GetCount()==0)
		return;
	m_cover.RemoveAll();
	for(int i=0;i<cover.GetCount();i++)
		m_cover.Add(cover.GetAt(i));

}

///////////////////////////////////////////////////////////////////
//给出巡逻策略，相应算法的实现
void CSetCover::ShowPoliceCarMove(int icar, int tim)
{
	if(m_linkList!=NULL)
	{
		delete [] m_linkList;
		m_linkList = NULL;
	}
	m_linkList = new IntArray [m_weight[m_cover.GetAt(icar)]];
	m_carNodes.RemoveAll();

	///////////////////////////////////////////////////////////////
	CarNode node;
	int origCol;

	//构造邻接表，实现存储一个警车的Topo
	//0号位置表示自己

	//首先建立本身的链接
	node.m_origID   = m_cover.GetAt(icar);   //方阵矩阵
	node.m_priority = tim;                   //240为优先权
	m_carNodes.Add(node);

	//建立主轴
	origCol = m_carNodes.GetAt(0).m_origID;
	for(int i=0;i<row;i++)
	{
		if(origCol!=i && m_tmpMatrix[i][origCol]==1)
		{
			node.m_origID   = i;   
			node.m_priority = tim;           //240为优先权  
			m_carNodes.Add(node); 
		}
	}

	////建立第一行
	//for(int i=1;i<m_carNodes.GetCount();i++)
	//{
	//	m_linkList[0].Add(i);
	//}

	//建立所链接节点的链接节点
	
	for(int i=0;i<m_carNodes.GetCount();i++)
	{
		origCol = m_carNodes.GetAt(i).m_origID;
		for(int j=0;j<row;j++)
		{
			if(j!=origCol && m_tmpMatrix[j][origCol]==1)
			{
				for(int k=0;k<m_graphic.m_gPoints[origCol].m_linkPoints.GetCount();k++)
				{
					if(m_graphic.m_gPoints[origCol].m_linkPoints.GetAt(k) == j)
					{
						for(int t=0;t<m_carNodes.GetCount();t++)
						{
							if(m_carNodes.GetAt(t).m_origID == j)
							{
								m_linkList[i].Add(t);
								break;
							}
						}
						break;
					}
				}
			}
		}
	}

	//邻接表的样式：
	//               真实点序号 -> 链接的点当前邻接表对应的序号 -> ... 

	CString pathName;
	pathName.Format("CarSearchTopo%d.txt",icar);
	FILE *fp;
	fp = fopen(pathName,"w+");
	fprintf(fp,"%d\n",m_carNodes.GetCount());

	for(int i=0;i<m_carNodes.GetCount();i++)
	{
		fprintf(fp,"%d ",m_carNodes.GetAt(i).m_origID);
		for(int j=0;j<m_linkList[i].GetCount();j++)
		{
			fprintf(fp,"%d ",m_linkList[i].GetAt(j));
		}
		fprintf(fp,"\n");
	}
	fclose(fp);

	//实现警车的模拟巡逻算法
	//根据当前节点的优先级来判断前进方向
	
	//得到icar编号的车的路径
	int curPos=0,nextPos; // 初始化当前位置
	int tmpPriority;
	SegmentPath segment;
	int steps = 0;
	double searchLength=0.0;
	IntArray record;
	searchLength = 333.3*(tim+20); //tim-1条线段 -> tim+20 确保>=240步骤 

	//启动随即函数
	srand(0);

	while(searchLength>0.0) //搜索长度为0，表示搜索完毕
	{
		m_carNodes.GetAt(curPos).m_priority--;
		
		for(int j=0;j<m_linkList[curPos].GetCount();j++)
		{
			if(j==0)
			{
				tmpPriority = m_carNodes.GetAt(m_linkList[curPos].GetAt(j)).m_priority;
			}
			else
			{
				if(tmpPriority < m_carNodes.GetAt(m_linkList[curPos].GetAt(j)).m_priority)
				{
					tmpPriority = m_carNodes.GetAt(m_linkList[curPos].GetAt(j)).m_priority;
				}
			}
		}
		////////////////////////////////////////////////////////////////////////////////
		//随机性
		record.RemoveAll();
		for(int j=0;j<m_linkList[curPos].GetCount();j++)
		{
			if(tmpPriority == m_carNodes.GetAt(m_linkList[curPos].GetAt(j)).m_priority)
			{
				record.Add(m_linkList[curPos].GetAt(j));
			}
		}
		
		nextPos = record.GetAt(rand()%record.GetCount());


		//找到下一个位置
		segment.carId1 = m_carNodes.GetAt(curPos).m_origID;
		segment.carId2 = m_carNodes.GetAt(nextPos).m_origID;
		segment.x1 = m_graphic.m_gPoints.GetAt(m_carNodes.GetAt(curPos).m_origID).x;
		segment.y1 = m_graphic.m_gPoints.GetAt(m_carNodes.GetAt(curPos).m_origID).y;
		segment.x2 = m_graphic.m_gPoints.GetAt(m_carNodes.GetAt(nextPos).m_origID).x;
		segment.y2 = m_graphic.m_gPoints.GetAt(m_carNodes.GetAt(nextPos).m_origID).y;

		m_pathArray[icar].Add(segment);

		searchLength -= CGraphic::Distance(segment.x1,segment.y1,segment.x2,segment.y2);   //减少搜索长度

		curPos = nextPos;

		steps++;
	}
	
	//CString ms;
	//ms.Format("PoliceCar %d all segments: %d",icar,steps);
	//AfxMessageBox(ms);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	//插入点模拟警车在路径上的点
	double x1,x2,y1,y2;
	for(int j=0;j<m_pathArray[icar].GetCount();j++)
	{
		segment = m_pathArray[icar].GetAt(j);

		x1 = segment.x1;
		y1 = segment.y1;
		x2 = segment.x2;
		y2 = segment.y2;

		PathPoint ptTemp;
		int n;
		int divideNum;
		double deltaX, deltaY, distance = CGraphic::Distance(x1,y1, x2,y2);
		
		double dtmpNum = distance/334.0;
		int    itmpNum = distance/334.0;
		if(dtmpNum - itmpNum > 0.5)
			divideNum = itmpNum+1;
		else
			divideNum = itmpNum;

		ptTemp.x = x1;
		ptTemp.y = y1;
		m_pathPointsArray[icar].Add(ptTemp);   //添加出发节点

		deltaX = x2 - x1;
		deltaY = y2 - y1;
		for (n=1; n<divideNum; n++)
		{
			ptTemp.x = x1 + n*deltaX/(divideNum*1.0);
			ptTemp.y = y1 + n*deltaY/(divideNum*1.0);

			m_pathPointsArray[icar].Add(ptTemp);
		}
	}
	//CString ms;
	//ms.Format("PoliceCar %d path's all points: %d",icar,m_pathPointsArray[icar].GetCount());
	//AfxMessageBox(ms);

}

//////////////////////////////////////////////////////////////////////////////////////////////////
//计算巡逻方案指标
//巡逻指标
//float m_fPath;      //单位时间内每一条路被走过后得到的道路的平均次数
//float m_fPath;      //单位时间内每一条路被走过后得到的道路的平均次数
//float m_avgTime;    //每个节点发生事件后，警车到达事发地点的平均时间
//float m_fReGo;      //单位时间内所有点中被重复次数与平均走过的次数的标准差

//m_graphic.m_linkAvg //平均链接数

void CSetCover::GetTargetThree()
{
	////////////////////////////////////////////////////////////////

	_int64 avgLinks = 0;
	for(int i=0;i<m_graphic.m_iPts;i++)
	{
		avgLinks += m_graphic.m_searchLinkPoints[i].GetCount()-1;
	}

	m_graphic.m_linkAvg = avgLinks/m_graphic.m_iPts;  //平均链接数
	////////////////////////////////////////////////////////////////
	int steps = m_graphic.m_linkAvg*2.0, tmpSteps;              //模拟巡逻步数
	SegmentPath sp;
	int divideNum;
	SegmentPathArray tmpSegs;
	for(int i=0;i<m_cover.GetCount();i++)
	{
		tmpSteps = steps;
		for(int k=0;k<m_pathArray[i].GetCount();k++)
		{
			sp = m_pathArray[i].GetAt(k);
			double dtmpNum = sp.Length()/334.0;
			int    itmpNum = sp.Length()/334.0;
			if(dtmpNum - itmpNum > 0.5)
				divideNum = itmpNum+1;
			else
				divideNum = itmpNum;

			tmpSteps -= divideNum;

			if(tmpSteps <= 0)
				break;
			tmpSegs.Add(sp);
		}
	}

	m_avgAll = (float)tmpSegs.GetCount()/m_graphic.m_iEdges;

	IntArray getCounts;
	int ipts = 0, icnts = 0;
	for(int i=0;i<tmpSegs.GetCount()-1;i++)
	{
		icnts = 1;  //至少出现一次
		sp = tmpSegs.GetAt(i);
		for(int j=i+1;j<tmpSegs.GetCount();j++)
		{
			if(sp == tmpSegs.GetAt(j))
			{
				tmpSegs.RemoveAt(j);
				j--;
				icnts ++;
			}
		}
		getCounts.Add(icnts);
	}

	m_fPath = (float)tmpSegs.GetCount()/m_graphic.m_iEdges;

	//为走过的点的方差累加
	m_fReGo = 0.0;
	for(int i=0;i<m_graphic.m_iEdges - getCounts.GetCount();i++)
		m_fReGo += m_avgAll * m_avgAll;

	for(int i=0;i<getCounts.GetCount();i++)
	{
		m_fReGo += (float)(getCounts.GetAt(i) - m_avgAll) * (getCounts.GetAt(i) - m_avgAll);
	}

	m_fReGo /= m_graphic.m_iEdges;
	m_fReGo = sqrt(m_fReGo);

	/*CString ms;
	ms.Format("一个时间段内访问节点的平均次数 %lf，一个时间段内重复巡逻次数与平均次数的方差  %lf",m_avgAll,m_fReGo);
	AfxMessageBox(ms);
	ms.Format("一个时间段内巡逻覆盖率 %lf",m_fPath);
	AfxMessageBox(ms);*/

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	//float m_avgTime;    //每个节点发生事件后，警车到达事发地点的平均时间
	m_avgTime = 0.0;
	float v = 666.7;
	int id;
	int x1,x2,y1,y2,dis,tmpDis;
	for(int i=0;i<row;i++)
	{
		x1 = m_graphic.m_gPoints.GetAt(i).x;
		y1 = m_graphic.m_gPoints.GetAt(i).y;
		for(int j=0;j<m_cover.GetCount();j++)
		{
			x2 = m_pathPointsArray[j].GetAt(steps).x;  //steps这步的时刻发生事件
			y2 = m_pathPointsArray[j].GetAt(steps).y;
			if(j==0)
			{
				dis = CGraphic::Distance(x1,y1,x2,y2);
				id = j;		
			}
			else
			{
				tmpDis = CGraphic::Distance(x1,y1,x2,y2);
				if(dis > tmpDis)
				{
					dis = tmpDis;
					id = j;
				}
			}
		}

		//dis *= 1.2;  //经验值

		m_avgTime += dis / v;
	}
	m_avgTime /= row;

	/*ms.Format("每个节点发生事件后，警车到达事发地点的平均时间  %lf 分",m_avgTime);
	AfxMessageBox(ms);*/

}













