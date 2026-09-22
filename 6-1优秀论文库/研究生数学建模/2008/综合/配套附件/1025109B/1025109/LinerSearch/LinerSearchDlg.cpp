// LinerSearchDlg.cpp : implementation file
//

#include "stdafx.h"
#include "LinerSearch.h"
#include "LinerSearchDlg.h"
#include <math.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLinerSearchDlg dialog

CLinerSearchDlg::CLinerSearchDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CLinerSearchDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CLinerSearchDlg)
	m_h = 0.0;
	m_maxgenindex = 0;
	m_maxindex = 0;
	m_min = 0.0;
	m_popsize = 400;
	m_sumtime1 = 0.0;
	m_sumtime2 = 0.0;
	m_t1 = 0.0;
	m_t2 = 0.0;
	m_t3 = 0.0;
	m_t4 = 0.0;
	m_t5 = 0.0;
	m_t6 = 0.0;
	m_t7 = 0.0;
	m_t8 = 0.0;
	m_y1 = 0.0;
	m_y2 = 0.0;
	m_y3 = 0.0;
	m_y4 = 0.0;
	m_y5 = 0.0;
	m_y6 = 0.0;
	m_y7 = 0.0;
	m_y8 = 0.0;
	m_maxgeneration = 300;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CLinerSearchDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CLinerSearchDlg)
	DDX_Control(pDX, IDC_PROGRESS1, m_progress);
	DDX_Text(pDX, IDC_EDIT_H, m_h);
	DDX_Text(pDX, IDC_EDIT_MAXGENINDEX, m_maxgenindex);
	DDX_Text(pDX, IDC_EDIT_MAXINDEX, m_maxindex);
	DDX_Text(pDX, IDC_EDIT_MIN, m_min);
	DDX_Text(pDX, IDC_EDIT_POPSIZE, m_popsize);
	DDX_Text(pDX, IDC_EDIT_SUMTIME1, m_sumtime1);
	DDX_Text(pDX, IDC_EDIT_SUMTIME2, m_sumtime2);
	DDX_Text(pDX, IDC_EDIT1, m_t1);
	DDX_Text(pDX, IDC_EDIT2, m_t2);
	DDX_Text(pDX, IDC_EDIT3, m_t3);
	DDX_Text(pDX, IDC_EDIT4, m_t4);
	DDX_Text(pDX, IDC_EDIT5, m_t5);
	DDX_Text(pDX, IDC_EDIT6, m_t6);
	DDX_Text(pDX, IDC_EDIT7, m_t7);
	DDX_Text(pDX, IDC_EDIT8, m_t8);
	DDX_Text(pDX, IDC_EDIT9, m_y1);
	DDX_Text(pDX, IDC_EDIT10, m_y2);
	DDX_Text(pDX, IDC_EDIT11, m_y3);
	DDX_Text(pDX, IDC_EDIT12, m_y4);
	DDX_Text(pDX, IDC_EDIT13, m_y5);
	DDX_Text(pDX, IDC_EDIT14, m_y6);
	DDX_Text(pDX, IDC_EDIT15, m_y7);
	DDX_Text(pDX, IDC_EDIT16, m_y8);
	DDX_Text(pDX, IDC_EDIT_MAXGEN, m_maxgeneration);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CLinerSearchDlg, CDialog)
	//{{AFX_MSG_MAP(CLinerSearchDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_START, OnButtonStart)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLinerSearchDlg message handlers

BOOL CLinerSearchDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	MakeSureCycle();
	pc = 0.8;
//	pm = 0.5;

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CLinerSearchDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CLinerSearchDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CLinerSearchDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CLinerSearchDlg::OnButtonStart() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	
	m_progress.SetRange(0 , m_maxgeneration);
	m_progress.SetPos(0);
	
	double yuzhi = 1.70;
	CreatePoisson(0.1);
	
	generation=0;
	
	GenerateInitialPopulationCycle();
	EvaluatePopulationCycle();
	double diff = population[generation].value - yuzhi;
	while((generation<m_maxgeneration)&&(diff>0))
	{
		generation++;
		if (generation==300)
		{
			int a=0;
		}
		diff = population[generation].value - yuzhi;
		GenerateNextPopulationCycle();
		EvaluatePopulationCycle();
		PerformeVolution();
		
		m_progress.SetPos(generation);
	}
	OutputTextReportCycle();
}

void CLinerSearchDlg::CreatePoisson(double d)
{
	const int count = 20;
	double *data = new double[count];//k从0到20的poisson概率放在data数组中
	double pk = 0.0;
	double t = 100;
	double lamuda = d;
	
	int i=0;
	int n=0;
	double sum = 0.0;
	
	for (i=0;i<count;i++)
	{
		pk = pow(lamuda*t , i)/jiecheng(i)*exp(-lamuda*t);//pk为poisson概率
		sum += pk;
		data[i] = sum;
		if (sum > 0.99)
		{
			n=i;
			break;
		}
	}
	
	const int randcount = 250;
	double *p = new double[randcount];
	for (i=0; i<randcount; i++)
	{
		double temp = AverageRandom(0.0,1.0);
		p[i] = temp;
	}
	
	int sequencevalue = 0;
	for (i=0; i<randcount; i++)
	{
		sequencevalue = GetXulie(data , n , p[i]);
		forward[i] = sequencevalue;
	}

	delete []data;
	delete []p;
}

int CLinerSearchDlg::jiecheng(int value)
{
	if ((value == 0)||(value == 1))
	{
		return 1;
	} 
	else
	{
		return value*jiecheng(value - 1);
	}
}

int CLinerSearchDlg::GetXulie(double *pdata, int n , double value)
{
	int i=0;
	while (i<=n)
	{
		if (value <= pdata[i])
		{
			return i;
		}
		i++;
	}
	return 0;
}








void CLinerSearchDlg::FindBestAndWorstIndividual()
{
	int i;
	double sum=0.0;
	
	bestindividual=population[0];
	worstindividual=population[0];
	currentbest = population[0];

	for (i=1;i<m_popsize; i++)
	{
		
		//if (population[i].fitness>bestindividual.fitness)
		if (population[i].value<bestindividual.value)
		{
			bestindividual=population[i];
			best_index=i;
		}
		else if (population[i].value>worstindividual.value)//if (population[i].fitness<worstindividual.fitness)
		{
			worstindividual=population[i];
			worst_index=i;
			
		}
        
		sum+=population[i].value;
	}
	
	if (generation==0)
	{
		currentbest=bestindividual;
		//fatherbestindividual = bestindividual;
		m_maxgenindex=generation;//m_maxgenindex为最早出现的最优个体的世代数
		//m_maxfitness = currentbest.value;
		m_maxindex = best_index;
	}
	else
	{
		if(bestindividual.value<currentbest.value)
		{
			currentbest=bestindividual;
			//m_maxfitness = currentbest.fitness;
			//m_maxfitness = currentbest.value;
			m_maxgenindex=generation;//m_maxgenindex为最早出现的最优个体的世代数
			maxindexindividual = bestindividual;//maxindexindividual为最早出现的最优个体
			m_maxindex = best_index;
		}

	}

	

}

void CLinerSearchDlg::PerformeVolution()//最优个体保存策略
{
	//if (bestindividual.fitness>currentbest.fitness)
	if (bestindividual.value<currentbest.value)
	{
		currentbest=population[best_index];
	}
	else
	{
		population[worst_index]=currentbest;
	}
}

void CLinerSearchDlg::SelectOperator()
{
	//比例选择算法
	int i,index;
	double p,sum=0.0;
	double cfitness[POPSIZE];
	
	struct individual newpopulation[POPSIZE];
	
	for(i=0;i<m_popsize;i++)
	{
		sum+=population[i].fitness;
	}
	
	avgfitness = sum/m_popsize;

	for(i=0;i<m_popsize; i++)
	{
		cfitness[i]=population[i].fitness/sum;
	}
	
	for(i=1;i<m_popsize; i++)
	{
		cfitness[i]=cfitness[i-1]+cfitness[i];
	}
	
	for (i=0;i<m_popsize;i++)
	{
		p=rand()%1000/1000.0;
		
		index=0;
		
		while (p>cfitness[index])
		{
			index++;
		}
		
		newpopulation[i]=population[index];
	}
	
	for(i=0;i<m_popsize; i++)
	{
		population[i]=newpopulation[i];
	}

}


double CLinerSearchDlg::AverageRandom(double min, double max)
{
	int minInteger = (int)(min*10000);
	
	int maxInteger = (int)(max*10000); 
	
	int randInteger = rand()*rand(); 
	
	int diffInteger = maxInteger - minInteger; 
	
	int resultInteger = randInteger % diffInteger + minInteger; 
	
	return resultInteger/10000.0;     
}




int CLinerSearchDlg::GetValue(int forward[], int i)
{
	return forward[i];
}



void CLinerSearchDlg::EvaluatePopulationCycle()
{
	CalculateObjectValueCycle();
	//CalculateFitnessValue();
	FindBestAndWorstIndividual();
}

void CLinerSearchDlg::CalculateObjectValueCycle()
{
	double c1=0.0 , c2=0.0;
	double d , d1 , d2,d3,d4 , d5,d6,d7,d8;
	double p1 , p2 ,p , p3 , p4 , pp , subtime1, subtime2;
	double w1,w2,w3;
	double baohe13 = 0.27;
	double baohe24 = 0.33;
	double s1=960,s2=1200,s3=960,s4=1200,hour=3600;
	double y1,y2,y3,y4,y5,y6,y7,y8;
	for (int i=0;i<m_popsize;i++)
	{
		c1 = 0.0;
		c2 = 0.0;
		for (int j=0;j<4;j++)
		{
			c1 += population[i].chrom[j] + li;
		}

		for (j=4;j<8;j++)
		{
			c2 += population[i].chrom[j] + li;
		}

		for (j=0;j<3;j++)
		{
			population[i].mdata[j]=0.0;
		}

		y1=y2=y3=y4=y5=y6=y7=y8=0.0;
		if (i==350)
		{
			int a=0;
		}
		double x1 = population[i].chrom[0];
		y1 = GetValue(forward , 0);
		y1 = (y1/100)/baohe13;
		y1 = y1*0.3;

		p1 = (1-4*li/c1)*(1-4*li/c1);
		p2 = 2*4/c1;
		p = p1/p2;

		double x2 = population[i].chrom[1];
		y2 = GetValue(forward , 1);
		y2 = (y2/100)/baohe24;

		double x3 = population[i].chrom[2];
		y3 = GetValue(forward , 2);
		y3 = (y3/100)/baohe13;
		y3 = y3*0.3;

		double x4 = cycle - x1-x2-x3;
		population[i].chrom[3] = x4;
		y4 = GetValue(forward , 3);
		y4 = (y4/100)/baohe24;

		subtime1=y1+y2+y3+y4;

		if(subtime1>1.0)
		{
			population[i].value = 10000.0;
			continue;
		}

		double x5 = population[i].chrom[4];
		y5 = GetValue(forward , 4);
		y5 = (y5/100)/baohe13;
		y5 = y5*0.3;
		
		p3 = (1-4*li/c2)*(1-4*li/c2);
		p4 = 2*4/c2;
		pp = p3/p4;
		
		double x6 = population[i].chrom[5];
		y6 = GetValue(forward , 5);
		y6 = (y6/100)/baohe24;
		
		double x7 = population[i].chrom[6];
		y7 = GetValue(forward , 6);
		y7 = (y7/100)/baohe13;
		y7 = y7*0.3;
		
		double x8 = cycle - x5-x6-x7;
		population[i].chrom[7] = x8;
		y8 = GetValue(forward , 7);
		y8 = (y8/100)/baohe24;
		
		subtime2=y5+y6+y7+y8;
		
		if(subtime2>1.0)
		{
			population[i].value = 10000.0;
			continue;
		}

    	w1=0.011;
		w2=0.866;
		w3=0.012;
		d1 = w1*(c1*(1.0-x1/c1)*(1.0-x1/c1))/(2*(1.0-y1)+p) + w2*fabs(0.9*(1.0-x1/c1)/(1.0-y1));
		d1 = d1 - w3*(x1/c1)*s1/hour;

		d2 = w1*(c1*(1.0-x2/c1)*(1.0-x2/c1))/(2*(1.0-y2)+p) + w2*fabs(0.9*(1.0-x2/c1)/(1.0-y2));
		d2 = d2 - w3*(x2/c1)*s2/hour;

		d3 = w1*(c1*(1.0-x3/c1)*(1.0-x3/c1))/(2*(1.0-y3)+p) + w2*fabs(0.9*(1.0-x3/c1)/(1.0-y3));
		d3 = d3 - w3*(x3/c1)*s3/hour;

		d4 = w1*(c1*(1.0-x4/c1)*(1.0-x4/c1))/(2*(1.0-y4)+p) + w2*fabs(0.9*(1.0-x4/c1)/(1.0-y4));
		d4 = d4 - w3*(x4/c1)*s4/hour;

		d5 = w1*(c2*(1.0-x5/c2)*(1.0-x5/c2))/(2*(1.0-y5)+pp) + w2*fabs(0.9*(1.0-x5/c2)/(1.0-y5));
		d5 = d5 - w3*(x5/c2)*s1/hour;
		
		d6 = w1*(c2*(1.0-x6/c2)*(1.0-x6/c2))/(2*(1.0-y6)+pp) + w2*fabs(0.9*(1.0-x6/c2)/(1.0-y6));
		d6 = d6 - w3*(x6/c2)*s2/hour;
		
		d7 = w1*(c2*(1.0-x7/c2)*(1.0-x7/c2))/(2*(1.0-y7)+pp) + w2*fabs(0.9*(1.0-x7/c2)/(1.0-y7));
		d7 = d7 - w3*(x7/c2)*s3/hour;
		
		d8 = w1*(c2*(1.0-x8/c2)*(1.0-x8/c2))/(2*(1.0-y8)+pp) + w2*fabs(0.9*(1.0-x8/c2)/(1.0-y8));
		d8 = d8 - w3*(x8/c2)*s4/hour;

		d = d1+d2+d3+d4+d5+d6+d7+d8;
		population[i].value = d;

		population[i].mdata[0] = subtime1;
		population[i].mdata[1] = subtime2;

		population[i].mdata[2] = 0.9*fabs((1.0-x1/c1)/(1.0-y1));
		population[i].mdata[2] += 0.9*fabs((1.0-x2/c1)/(1.0-y2));
		population[i].mdata[2] += 0.9*fabs((1.0-x3/c1)/(1.0-y3));
		population[i].mdata[2] += 0.9*fabs((1.0-x4/c1)/(1.0-y4));
		population[i].mdata[2] += 0.9*fabs((1.0-x5/c2)/(1.0-y5));
		population[i].mdata[2] += 0.9*fabs((1.0-x6/c2)/(1.0-y6));
		population[i].mdata[2] += 0.9*fabs((1.0-x7/c2)/(1.0-y7));
		population[i].mdata[2] += 0.9*fabs((1.0-x8/c2)/(1.0-y8));

		population[i].y[0] = y1;
		population[i].y[1] = y2;
		population[i].y[2] = y3;
		population[i].y[3] = y4;
		population[i].y[4] = y5;
		population[i].y[5] = y6;
		population[i].y[6] = y7;
		population[i].y[7] = y8;
	}
}

void CLinerSearchDlg::GenerateInitialPopulationCycle()
{
	double p = 0.0;
	double sum = 0.0;
	int i=0 , j=0;
	double up = 0.0;
	for (i=0;i<m_popsize;i++)
	{
		double p = AverageRandom(20.0 , 30.0);
		population[i].chrom[0] = p;
		
		up = (30<(cycle-population[i].chrom[0]))?30:(cycle-population[i].chrom[0]);
		p = AverageRandom(20.0 , up);
		population[i].chrom[1] = p;
		
		up = (30<(cycle-population[i].chrom[0]-population[i].chrom[1]))?30:(cycle-population[i].chrom[0]-population[i].chrom[1]);
		p = AverageRandom(20.0 , up);
		population[i].chrom[2] = p;
		
		sum = population[i].chrom[0]+population[i].chrom[1] + population[i].chrom[2];
		population[i].chrom[3] = cycle-sum;
		
		population[i].chrom[4] = population[i].chrom[0];
		
		population[i].chrom[5] = population[i].chrom[1];
		
		population[i].chrom[6] = population[i].chrom[2];
		
		population[i].chrom[7] = population[i].chrom[3];
		
		population[i].chrom[chormlength] = '\0';

		/*double p = AverageRandom(20.0 , 30.0);
		population[i].chrom[0] = p;

		up = (30<(cycle-population[i].chrom[0]))?30:(cycle-population[i].chrom[0]);
		p = AverageRandom(20.0 , up);
		population[i].chrom[1] = p;

		up = (30<(cycle-population[i].chrom[0]-population[i].chrom[1]))?30:(cycle-population[i].chrom[0]-population[i].chrom[1]);
		p = AverageRandom(20.0 , up);
		population[i].chrom[2] = p;

		sum = population[i].chrom[0]+population[i].chrom[1] + population[i].chrom[2];
		population[i].chrom[3] = cycle-sum;

		p = AverageRandom(20.0 , 30.0);
		population[i].chrom[4] = p;
		
		up = (30<(cycle-population[i].chrom[4]))?30:(cycle-population[i].chrom[4]);
		p = AverageRandom(20.0 , up);
		population[i].chrom[5] = p;
		
		up = (30<(cycle-population[i].chrom[4]-population[i].chrom[5]))?30:(cycle-population[i].chrom[4]-population[i].chrom[5]);
		p = AverageRandom(20.0 , up);
		population[i].chrom[6] = p;
		
		sum = population[i].chrom[4]+population[i].chrom[5] + population[i].chrom[6];
		population[i].chrom[7] = cycle-sum;

		population[i].chrom[chormlength] = '\0';*/
	}
}

void CLinerSearchDlg::GenerateNextPopulationCycle()
{
	SelectOperator();
	CrossoverOperatorCycle();
	MutationOperatorCycle();
}

void CLinerSearchDlg::MutationOperatorCycle()
{
	int point = 0;
	double p = 0.0;
	double newvalue = 0.0;
	
	const double start = 20.0;
	const double  end = 30.0;
	
	struct individual tempindividual;

	for (int i=0; i<m_popsize; i++)
	{
		tempindividual = population[i];
		p=rand()%1000/1000.0;
		point=rand()%3;
		for (int j=point;j>0;j--)
		{
			pm=((double)j)/chormlength;
			if (p < pm)
			{
				newvalue = AverageRandom(start , end);		
				if (newvalue != population[i].chrom[point])
				{
					population[i].chrom[point] = newvalue;
				}	
				population[i].chrom[3]=cycle-population[i].chrom[0]-population[i].chrom[1]-population[i].chrom[2];
				
				population[i].chrom[point+4] = population[i].chrom[point];
				population[i].chrom[7] = population[i].chrom[3];
				/*newvalue = AverageRandom(start , end);		
				if (newvalue != population[i].chrom[4+point])
				{
					population[i].chrom[4+point] = newvalue;
				}	
				population[i].chrom[7]=cycle-population[i].chrom[4]-population[i].chrom[5]-population[i].chrom[6];*/

				if (GetObjectValue(population[i]) < GetObjectValue(tempindividual))
				{
					break;
				}
				else
				{
					population[i] = tempindividual;
				}
			}	
			
		}
		if (population[i].value == tempindividual.value)
		{
			p=rand()%1000/1000.0;
			pm = 1.0/chormlength;
			if (p < pm)
			{
				point=rand()%3;
				newvalue = AverageRandom(start , end);		
				if (newvalue != population[i].chrom[point])
				{
					population[i].chrom[point] = newvalue;
				}	
				population[i].chrom[3]=cycle-population[i].chrom[0]-population[i].chrom[1]-population[i].chrom[2];
				
				population[i].chrom[point+4] = population[i].chrom[point];
				population[i].chrom[7] = population[i].chrom[3];

				/*point=rand()%3;
				newvalue = AverageRandom(start , end);		
				if (newvalue != population[i].chrom[4+point])
				{
					population[i].chrom[4+point] = newvalue;
				}	
				population[i].chrom[7]=cycle-population[i].chrom[4]-population[i].chrom[5]-population[i].chrom[6];*/
			}
		}
	}
}



void CLinerSearchDlg::OutputTextReportCycle()
{
	m_t1 = currentbest.chrom[0];
	m_t2 = currentbest.chrom[1];
	m_t3 = currentbest.chrom[2];
	m_t4 = currentbest.chrom[3];
	m_t5 = currentbest.chrom[4];
	m_t6 = currentbest.chrom[5];
	m_t7 = currentbest.chrom[6];
	m_t8 = currentbest.chrom[7];

	m_sumtime1 = currentbest.mdata[0];
	m_sumtime2 = currentbest.mdata[1];
	m_h = currentbest.mdata[2];

	m_y1 = currentbest.y[0];
	m_y2 = currentbest.y[1];
	m_y3 = currentbest.y[2];
	m_y4 = currentbest.y[3];
	m_y5 = currentbest.y[4];
	m_y6 = currentbest.y[5];
	m_y7 = currentbest.y[6];
	m_y8 = currentbest.y[7];
	
	m_min = currentbest.value;
	UpdateData(FALSE);
}




void CLinerSearchDlg::MakeSureCycle()
{
	int length = 900;
	int v = 10;
	int count = 2;
	int totaltime = length*count/v;

	int n=2;
	while((totaltime/n>=80)&&(totaltime/n<=240))
	{
		cycle = totaltime/n;
		n++;
	}
}

void CLinerSearchDlg::CrossoverOperatorCycle()
{
	int i,j;
	int *index = new int[m_popsize];
	int point , pos;
	double p;	
	double temp = 0.0;
	
	for (i=0;i<m_popsize;i++)
	{
		index[i]=i;
	}
	
	//index[i]与index[point+i]互换
	for (i=0;i<m_popsize;i++)
	{
		point=rand()%(m_popsize-i);
		pos=index[i];
		index[i]=index[point+i];
		index[point+i]=pos;
	}
	
	for (i=0;i<m_popsize-1;i+=2)
	{
		p=rand()%1000/1000.0;
		if (p<pc)
		{
			point=rand()%3;
			for (j=point; j<3;j++)
			{
				temp=population[index[i]].chrom[j];
				population[index[i]].chrom[j]=population[index[i+1]].chrom[j];
				population[index[i+1]].chrom[j]=temp;
			}

			population[index[i]].chrom[3]=cycle-population[index[i]].chrom[0];
			population[index[i]].chrom[3]-=cycle-population[index[i]].chrom[1];
			population[index[i]].chrom[3]-=cycle-population[index[i]].chrom[2];

			population[index[i+1]].chrom[3]=cycle-population[index[i+1]].chrom[0];
			population[index[i+1]].chrom[3]-=cycle-population[index[i+1]].chrom[1];
			population[index[i+1]].chrom[3]-=cycle-population[index[i+1]].chrom[2];

			/*point=rand()%3;
			for (j=4+point; j<4+3;j++)
			{
				temp=population[index[i]].chrom[j];
				population[index[i]].chrom[j]=population[index[i+1]].chrom[j];
				population[index[i+1]].chrom[j]=temp;
			}

			population[index[i]].chrom[7]=cycle-population[index[i]].chrom[4];
			population[index[i]].chrom[7]-=cycle-population[index[i]].chrom[5];
			population[index[i]].chrom[7]-=cycle-population[index[i]].chrom[6];
			
			population[index[i+1]].chrom[7]=cycle-population[index[i+1]].chrom[4];
			population[index[i+1]].chrom[7]-=cycle-population[index[i+1]].chrom[5];
			population[index[i+1]].chrom[7]-=cycle-population[index[i+1]].chrom[6];*/
		}

		population[index[i]].chrom[4] = population[index[i]].chrom[0];
		population[index[i]].chrom[5] = population[index[i]].chrom[1];
		population[index[i]].chrom[6] = population[index[i]].chrom[2];
		population[index[i]].chrom[7] = population[index[i]].chrom[3];

		population[index[i+1]].chrom[4] = population[index[i+1]].chrom[0];
		population[index[i+1]].chrom[5] = population[index[i+1]].chrom[1];
		population[index[i+1]].chrom[6] = population[index[i+1]].chrom[2];
		population[index[i+1]].chrom[7] = population[index[i+1]].chrom[3];
	}
	
	delete []index;
}

double CLinerSearchDlg::GetObjectValue(individual tempindividual)
{
	double c1=0.0 , c2=0.0;
	double d , d1 , d2,d3,d4 , d5,d6,d7,d8;
	double p1 , p2 ,p , p3 , p4 , pp , subtime1, subtime2;
	double w1,w2,w3;
	double baohe13 = 0.27;
	double baohe24 = 0.33;
	double s1=960,s2=1200,s3=960,s4=1200,hour=3600;

	c1 = 0.0;
	c2 = 0.0;
	for (int j=0;j<4;j++)
	{
		c1 += tempindividual.chrom[j] + li;
	}
	
	for (j=4;j<8;j++)
	{
		c2 += tempindividual.chrom[j] + li;
	}
	
	for (j=0;j<3;j++)
	{
		tempindividual.mdata[j]=0.0;
	}

	double x1 = tempindividual.chrom[0];
	double y1 = GetValue(forward , 0);
	y1 = (y1/100)/baohe13;
	y1 = y1*0.3;
	
	p1 = (1-4*li/c1)*(1-4*li/c1);
	p2 = 2*4/c1;
	p = p1/p2;
	
	double x2 = tempindividual.chrom[1];
	double y2 = GetValue(forward , 1);
	y2 = (y2/100)/baohe24;
	
	double x3 = tempindividual.chrom[2];
	double y3 = GetValue(forward , 2);
	y3 = (y3/100)/baohe13;
	y3 = y3*0.3;
	
	double x4 = cycle - x1-x2-x3;
	tempindividual.chrom[3] = x4;
	double y4 = GetValue(forward , 3);
	y4 = (y4/100)/baohe24;
	
	subtime1=y1+y2+y3+y4;
	
	if(subtime1>1.0)
	{
		tempindividual.value = 10000.0;
	}
	
	double x5 = tempindividual.chrom[4];
	double y5 = GetValue(forward , 4);
	y5 = (y5/100)/baohe13;
	y5 = y5*0.3;
	
	p3 = (1-4*li/c2)*(1-4*li/c2);
	p4 = 2*4/c2;
	pp = p3/p4;
	
	double x6 = tempindividual.chrom[5];
	double y6 = GetValue(forward , 5);
	y6 = (y6/100)/baohe24;
	
	double x7 = tempindividual.chrom[6];
	double y7 = GetValue(forward , 6);
	y7 = (y7/100)/baohe13;
	y7 = y7*0.3;
	
	double x8 = cycle - x5-x6-x7;
	tempindividual.chrom[7] = x8;
	double y8 = GetValue(forward , 7);
	y8 = (y8/100)/baohe24;
	
	subtime2=y5+y6+y7+y8;
	
	if(subtime2>1.0)
	{
		tempindividual.value = 10000.0;
	}
	
	w1=0.011;
	w2=0.866;
	w3=0.012;
	d1 = w1*(c1*(1.0-x1/c1)*(1.0-x1/c1))/(2*(1.0-y1)+p) + w2*fabs(0.9*(1.0-x1/c1)/(1.0-y1));
	d1 = d1 - w3*(x1/c1)*s1/hour;
	
	d2 = w1*(c1*(1.0-x2/c1)*(1.0-x2/c1))/(2*(1.0-y2)+p) + w2*fabs(0.9*(1.0-x2/c1)/(1.0-y2));
	d2 = d2 - w3*(x2/c1)*s2/hour;
	
	d3 = w1*(c1*(1.0-x3/c1)*(1.0-x3/c1))/(2*(1.0-y3)+p) + w2*fabs(0.9*(1.0-x3/c1)/(1.0-y3));
	d3 = d3 - w3*(x3/c1)*s3/hour;
	
	d4 = w1*(c1*(1.0-x4/c1)*(1.0-x4/c1))/(2*(1.0-y4)+p) + w2*fabs(0.9*(1.0-x4/c1)/(1.0-y4));
	d4 = d4 - w3*(x4/c1)*s4/hour;
	
	d5 = w1*(c2*(1.0-x5/c2)*(1.0-x5/c2))/(2*(1.0-y5)+pp) + w2*fabs(0.9*(1.0-x5/c2)/(1.0-y5));
	d5 = d5 - w3*(x5/c2)*s1/hour;
	
	d6 = w1*(c2*(1.0-x6/c2)*(1.0-x6/c2))/(2*(1.0-y6)+pp) + w2*fabs(0.9*(1.0-x6/c2)/(1.0-y6));
	d6 = d6 - w3*(x6/c2)*s2/hour;
	
	d7 = w1*(c2*(1.0-x7/c2)*(1.0-x7/c2))/(2*(1.0-y7)+pp) + w2*fabs(0.9*(1.0-x7/c2)/(1.0-y7));
	d7 = d7 - w3*(x7/c2)*s3/hour;
	
	d8 = w1*(c2*(1.0-x8/c2)*(1.0-x8/c2))/(2*(1.0-y8)+pp) + w2*fabs(0.9*(1.0-x8/c2)/(1.0-y8));
	d8 = d8 - w3*(x8/c2)*s4/hour;
	
	d = d1+d2+d3+d4+d5+d6+d7+d8;
	tempindividual.value = d;
	
	tempindividual.mdata[0] = subtime1;
	tempindividual.mdata[1] = subtime2;
	
	tempindividual.mdata[2] = 0.9*fabs((1.0-x1/c1)/(1.0-y1));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x2/c1)/(1.0-y2));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x3/c1)/(1.0-y3));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x4/c1)/(1.0-y4));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x5/c2)/(1.0-y5));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x6/c2)/(1.0-y6));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x7/c2)/(1.0-y7));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x8/c2)/(1.0-y8));
	
	tempindividual.y[0] = y1;
	tempindividual.y[1] = y2;
	tempindividual.y[2] = y3;
	tempindividual.y[3] = y4;
	tempindividual.y[4] = y5;
	tempindividual.y[5] = y6;
	tempindividual.y[6] = y7;
	tempindividual.y[7] = y8;
	
	return d;
}