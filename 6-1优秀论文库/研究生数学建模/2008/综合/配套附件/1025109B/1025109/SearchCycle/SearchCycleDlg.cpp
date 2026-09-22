// SearchCycleDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SearchCycle.h"
#include "SearchCycleDlg.h"
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
// CSearchCycleDlg dialog

CSearchCycleDlg::CSearchCycleDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSearchCycleDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSearchCycleDlg)
	m_mincycle = 0.0;
	m_x1 = 0.0;
	m_x2 = 0.0;
	m_x3 = 0.0;
	m_x4 = 0.0;
	m_maxgeneration = 300;
	m_popsize = 400;
	m_maxgenindex = 0;
	m_maxindex = 0;
	m_d = 0.0;
	m_h = 0.0;
	m_q = 0.0;
	m_y = 0.0;
	m_y1 = 0.0;
	m_y2 = 0.0;
	m_y3 = 0.0;
	m_y4 = 0.0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CSearchCycleDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSearchCycleDlg)
	DDX_Control(pDX, IDC_PROGRESS1, m_progress);
	DDX_Text(pDX, IDC_EDIT_MINCYCLE, m_mincycle);
	DDX_Text(pDX, IDC_EDIT_TIME1, m_x1);
	DDX_Text(pDX, IDC_EDIT_TIME2, m_x2);
	DDX_Text(pDX, IDC_EDIT_TIME3, m_x3);
	DDX_Text(pDX, IDC_EDIT_TIME4, m_x4);
	DDX_Text(pDX, IDC_EDIT_MAXGEN, m_maxgeneration);
	DDX_Text(pDX, IDC_EDIT_POPSIZE, m_popsize);
	DDX_Text(pDX, IDC_EDIT_MAXGENINDEX, m_maxgenindex);
	DDX_Text(pDX, IDC_EDIT_BESTINDEX, m_maxindex);
	DDX_Text(pDX, IDC_EDIT_D, m_d);
	DDX_Text(pDX, IDC_EDIT_H, m_h);
	DDX_Text(pDX, IDC_EDIT_Q, m_q);
	DDX_Text(pDX, IDC_EDIT_Y, m_y);
	DDX_Text(pDX, IDC_EDIT_TIME5, m_y1);
	DDX_Text(pDX, IDC_EDIT_TIME6, m_y2);
	DDX_Text(pDX, IDC_EDIT_TIME7, m_y3);
	DDX_Text(pDX, IDC_EDIT_TIME8, m_y4);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CSearchCycleDlg, CDialog)
	//{{AFX_MSG_MAP(CSearchCycleDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_START, OnButtonStart)
	ON_BN_CLICKED(IDC_BUTTON_CYCLE, OnButtonCycle)
	ON_BN_CLICKED(IDC_BUTTON_TIME, OnButtonTime)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSearchCycleDlg message handlers

BOOL CSearchCycleDlg::OnInitDialog()
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
	
	pc = 0.8;
	pm = 0.5;
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CSearchCycleDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CSearchCycleDlg::OnPaint() 
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
HCURSOR CSearchCycleDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CSearchCycleDlg::OnButtonStart() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	
	m_progress.SetRange(0 , m_maxgeneration);
	m_progress.SetPos(0);
	
	CreatePoisson();
	
	generation=0;
	
	GenerateInitialPopulation();
	EvaluatePopulation();
	while(generation<m_maxgeneration)
	{
		generation++;
		if (generation==300)
		{
			int a=0;
		}
		GenerateNextPopulation();
		EvaluatePopulation();
		PerformeVolution();
		
		m_progress.SetPos(generation);
	}
	OutputTextReport();
}

void CSearchCycleDlg::CreatePoisson()
{
	const int count = 20;
	double *data = new double[count];//k从0到20的poisson概率放在data数组中
	double pk = 0.0;
	double t = 100;
	double lamuda = 0.07*2;
	
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

int CSearchCycleDlg::jiecheng(int value)
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

int CSearchCycleDlg::GetXulie(double *pdata, int n , double value)
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

double CSearchCycleDlg::GetInputFlow(int forward[] , int start , int end)
{
	double sum = 0;
	for (int i=start;i<end;i++)
	{
		sum += forward[i];
	}
	return sum;
}

void CSearchCycleDlg::GenerateInitialPopulation()
{
	double p = 0.0;
	double temp = 0.0;
	int i=0 , j=0;
	for (i=0;i<m_popsize;i++)
	{
		for (j=0;j<chormlength;j++)
		{
			double p = AverageRandom(20.0 , 60.0);
			population[i].chrom[j] = p;
		}
		population[i].chrom[chormlength] = '\0';
	}
}

void CSearchCycleDlg::GenerateNextPopulation()
{
	SelectOperator();
	CrossoverOperator();
	MutationOperator();
}

void CSearchCycleDlg::EvaluatePopulation()
{
	CalculateObjectValue();
	//CalculateFitnessValue();
	FindBestAndWorstIndividual();
}

void CSearchCycleDlg::CalculateObjectValue()
{
	double c=0.0;
	double d , d1 , d2,d3,d4 , p1 , p2 ,p , y;
	double w1,w2,w3;
	double baohe13 = 0.27;
	double baohe24 = 0.33;
	double s1=960,s2=1200,s3=960,s4=1200,hour=3600;

	for (int i=0;i<m_popsize;i++)
	{
		c = 0.0;
		for (int j=0;j<chormlength;j++)
		{
			c += population[i].chrom[j] + li;
		}

		for (j=0;j<4;j++)
		{
			population[i].mdata[j]=0.0;
			population[i].y[j]=0.0;
		}

		if (i==44)
		{
			int a=0;
		}
		//int x1 = (int)population[i].chrom[0];
		double x1 = population[i].chrom[0];
		double y1 = GetValue(forward , 0);
		y1 = (y1/100)/baohe13;
		y1 = y1*0.3;

		p1 = (1-4*li/c)*(1-4*li/c);
		p2 = 2*4/c;
		p = p1/p2;


		//int x2 = (int)population[i].chrom[1];
		double x2 = population[i].chrom[1];
		double y2 = GetValue(forward , 1);
		y2 = (y2/100)/baohe24;

		//int x3 = (int)population[i].chrom[2];
		double x3 = population[i].chrom[2];
		double y3 = GetValue(forward , 2);
		y3 = (y3/100)/baohe13;
		y3 = y3*0.3;

		//int x4 = (int)population[i].chrom[3];
		double x4 = population[i].chrom[3];
		double y4 = GetValue(forward , 3);
		y4 = (y4/100)/baohe24;

		y=y1+y2+y3+y4;
		if(y>1.0)
		{
			population[i].value = 10000.0;
			continue;
		}

		/*w1 = 2*s1*y1*(1.0-y)/hour;
		w2 = 1.1*s1*y1*(1.0-y)*c/hour;
		w3 = (2/c)*y;*/
    	w1=0.011;
		w2=0.866;
		w3=0.012;
		d1 = w1*(c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p) + w2*fabs(0.9*(1.0-x1/c)/(1.0-y1));
		d1 = d1 - w3*(x1/c)*s1/hour;

		/*w1 = 2*s2*y2*(1.0-y)/hour;
		w2 = 1.1*s2*y2*(1.0-y)*c/hour;
		w3 = (2/c)*y;*/
 		w1=0.011;
		w2=0.866;
		w3=0.012;
		d2 = w1*(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p) + w2*fabs(0.9*(1.0-x2/c)/(1.0-y2));
		d2 = d2 - w3*(x2/c)*s2/hour;

		/*w1 = 2*s3*y3*(1.0-y)/hour;
		w2 = 1.1*s3*y3*(1.0-y)*c/hour;
		w3 = (2/c)*y;*/
    	w1=0.011;
		w2=0.866;
		w3=0.012;
		d3 = w1*(c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p) + w2*fabs(0.9*(1.0-x3/c)/(1.0-y3));
		d3 = d3 - w3*(x3/c)*s3/hour;

		/*w1 = 2*s4*y4*(1.0-y)/hour;
		w2 = 1.1*s4*y4*(1.0-y)*c/hour;
		w3 = (2/c)*y;*/
    	w1=0.011;
		w2=0.866;
		w3=0.012;
		d4 = w1*(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p) + w2*fabs(0.9*(1.0-x4/c)/(1.0-y4));
		d4 = d4 - w3*(x4/c)*s4/hour;

		d = d1+d2+d3+d4;
		population[i].value = d;

		population[i].mdata[0] = y;

		population[i].mdata[1] = (c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p)+(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p);
		population[i].mdata[1] += (c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p)+(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p);

		population[i].mdata[2] = 0.9*fabs((1.0-x1/c)/(1.0-y1));
		population[i].mdata[2] += 0.9*fabs((1.0-x2/c)/(1.0-y2));
		population[i].mdata[2] += 0.9*fabs((1.0-x3/c)/(1.0-y3));
		population[i].mdata[2] += 0.9*fabs((1.0-x4/c)/(1.0-y4));

		population[i].mdata[3] = (x1/c)*s1/hour+(x2/c)*s2/hour+(x3/c)*s3/hour+(x4/c)*s4/hour;

		population[i].y[0] = y1;
		population[i].y[1] = y2;
		population[i].y[2] = y3;
		population[i].y[3] = y4;

	}

}

void CSearchCycleDlg::CalculateFitnessValue()
{
	for (int i=0;i<m_popsize;i++)
	{
		double p = population[i].value;
		if (population[i].value < m_sum)
		{
			population[i].fitness = m_sum - population[i].value;	
		}
		else
		{
			population[i].fitness = 0;
		}
	}
}

void CSearchCycleDlg::FindBestAndWorstIndividual()
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

void CSearchCycleDlg::PerformeVolution()//最优个体保存策略
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

void CSearchCycleDlg::SelectOperator()
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

void CSearchCycleDlg::CrossoverOperator()
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
			point=rand()%chormlength;
			for (j=point; j<chormlength;j++)
			{
				temp=population[index[i]].chrom[j];
				population[index[i]].chrom[j]=population[index[i+1]].chrom[j];
				population[index[i+1]].chrom[j]=temp;
			}
		}
	}

	delete []index;
}

void CSearchCycleDlg::MutationOperator()
{
	int point = 0;
	double p = 0.0;
	double newvalue = 0.0;

	const double start = 20.0;
	const double  end = 60.0;

	for (int i=0; i<m_popsize; i++)
	{
		p=rand()%1000/1000.0;
		if (p < pm)
		{
			point=rand()%chormlength;
			newvalue = AverageRandom(start , end);		
			if (newvalue != population[i].chrom[point])
			{
				population[i].chrom[point] = newvalue;
			}
			
			population[i].chrom[chormlength-1] = m_cycle-population[i].chrom[0];
			population[i].chrom[chormlength-1] -= population[i].chrom[1];
			population[i].chrom[chormlength-1] -= population[i].chrom[2];
		}
	}
	}
}

void CSearchCycleDlg::OutputTextReport()
{
	m_x1 = currentbest.chrom[0];
	m_x2 = currentbest.chrom[1];
	m_x3 = currentbest.chrom[2];
	m_x4 = currentbest.chrom[3];

	m_y = currentbest.mdata[0];
	m_d = currentbest.mdata[1];
	m_h = currentbest.mdata[2];
	m_q = currentbest.mdata[3];

	m_y1 = currentbest.y[0];
	m_y2 = currentbest.y[1];
	m_y3 = currentbest.y[2];
	m_y4 = currentbest.y[3];

	m_mincycle = currentbest.value;
	UpdateData(FALSE);
}

double CSearchCycleDlg::AverageRandom(double min, double max)
{
	int minInteger = (int)(min*10000);
	
	int maxInteger = (int)(max*10000); 
	
	int randInteger = rand()*rand(); 
	
	int diffInteger = maxInteger - minInteger; 
	
	int resultInteger = randInteger % diffInteger + minInteger; 
	
	return resultInteger/10000.0;     
}

void CSearchCycleDlg::OutputTxtFile(int forward[], CString path, int count)
{
	CString m_filepath = path;////输出txt文件路径
	
	CFile file(m_filepath , CFile::modeCreate | CFile::modeWrite);
	
	CString temp = "";
	CString stringvalue = "";
	
	int i=0;
	for (i=0;i<count;i++)
	{
		temp.Format("%d" , forward[i]);
		stringvalue += temp;
		if (i != count-1)
		{
			stringvalue += ",";
		}		
	}
	stringvalue += "\r\n";
	
	file.Write(stringvalue , strlen(stringvalue));
}

void CSearchCycleDlg::OnOK() //产生poisson序列
{
	const int count = 2000;
	double *data = new double[count];//k从0到20的poisson概率放在data数组中
	double pk = 0.0;
	double t = 100;
	double lamuda = 0.07;
	
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

	OutputTxtFile(forward , "D:\\forward.txt" , randcount);
	AfxMessageBox("输出poisson序列完成!");

	delete []data;
	delete []p;
}

int CSearchCycleDlg::GetValue(int forward[], int i)
{
	return forward[i];
}



void CSearchCycleDlg::EvaluatePopulationCycle()
{
	CalculateObjectValueCycle();
	//CalculateFitnessValue();
	FindBestAndWorstIndividual();
}

void CSearchCycleDlg::CalculateObjectValueCycle()
{
	double c=0.0;
	double d , d1 , d2,d3,d4 , p1 , p2 ,p , y;
	double w1,w2,w3;
	double baohe13 = 0.27;
	double baohe24 = 0.33;
	double s1=960,s2=1200,s3=960,s4=1200,hour=3600;

	for (int i=0;i<m_popsize;i++)
	{
		c = 0.0;
		for (int j=0;j<chormlength;j++)
		{
			c += population[i].chrom[j] + li;
		}

		for (j=0;j<4;j++)
		{
			population[i].mdata[j]=0.0;
		}

		if (i==44)
		{
			int a=0;
		}

		double x1 = population[i].chrom[0];
		double y1 = GetValue(forward , 0);
		y1 = (y1/100)/baohe13;
		y1 = y1*0.3;

		p1 = (1-4*li/c)*(1-4*li/c);
		p2 = 2*4/c;
		p = p1/p2;

		double x2 = population[i].chrom[1];
		double y2 = GetValue(forward , 1);
		y2 = (y2/100)/baohe24;

		double x3 = population[i].chrom[2];
		double y3 = GetValue(forward , 2);
		y3 = (y3/100)/baohe13;
		y3 = y3*0.3;

		double x4 = 100 - x1-x2-x3;
		population[i].chrom[3] = x4;

		double y4 = GetValue(forward , 3);
		y4 = (y4/100)/baohe24;

		y=y1+y2+y3+y4;
		if(y>1.0)
		{
			population[i].value = 10000.0;
			continue;
		}

    	w1=0.011;
		w2=0.866;
		w3=0.012;
		d1 = w1*(c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p) + w2*fabs(0.9*(1.0-x1/c)/(1.0-y1));
		d1 = d1 - w3*(x1/c)*s1/hour;

		d2 = w1*(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p) + w2*fabs(0.9*(1.0-x2/c)/(1.0-y2));
		d2 = d2 - w3*(x2/c)*s2/hour;

		d3 = w1*(c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p) + w2*fabs(0.9*(1.0-x3/c)/(1.0-y3));
		d3 = d3 - w3*(x3/c)*s3/hour;

		d4 = w1*(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p) + w2*fabs(0.9*(1.0-x4/c)/(1.0-y4));
		d4 = d4 - w3*(x4/c)*s4/hour;

		d = d1+d2+d3+d4;
		population[i].value = d;

		population[i].mdata[0] = y;

		population[i].mdata[1] = (c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p)+(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p);
		population[i].mdata[1] += (c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p)+(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p);

		population[i].mdata[2] = 0.9*fabs((1.0-x1/c)/(1.0-y1));
		population[i].mdata[2] += 0.9*fabs((1.0-x2/c)/(1.0-y2));
		population[i].mdata[2] += 0.9*fabs((1.0-x3/c)/(1.0-y3));
		population[i].mdata[2] += 0.9*fabs((1.0-x4/c)/(1.0-y4));

		population[i].mdata[3] = (x1/c)*s1/hour+(x2/c)*s2/hour+(x3/c)*s3/hour+(x4/c)*s4/hour;

		population[i].y[0] = y1;
		population[i].y[1] = y2;
		population[i].y[2] = y3;
		population[i].y[3] = y4;
	}
}

void CSearchCycleDlg::GenerateInitialPopulationCycle()
{
	double p = 0.0;
	double sum = 0.0;
	int i=0 , j=0;
	for (i=0;i<m_popsize;i++)
	{

		double p = AverageRandom(20.0 , 60.0);
		population[i].chrom[0] = p;

		p = AverageRandom(20.0 , 100-population[i].chrom[0]);
		population[i].chrom[1] = p;

		p = AverageRandom(20.0 , (100-population[i].chrom[0]-population[i].chrom[1]));
		population[i].chrom[2] = p;

		sum = population[i].chrom[0]+population[i].chrom[1] + population[i].chrom[2];
		population[i].chrom[chormlength-1] = m_cycle-sum;
		population[i].chrom[chormlength] = '\0';
	}
}

void CSearchCycleDlg::GenerateNextPopulationCycle()
{
	SelectOperator();
	CrossoverOperatorCycle();
	MutationOperatorCycle();
}

void CSearchCycleDlg::MutationOperatorCycle()
{
	int point = 0;
	double p = 0.0;
	double newvalue = 0.0;
	
	const double start = 20.0;
	const double  end = 60.0;

	for (int i=0; i<m_popsize; i++)
	{
		p=rand()%1000/1000.0;
		if (p < pm)
		{
			point=rand()%(chormlength-1);//流出量变异
			newvalue = AverageRandom(start , end);		
			if (newvalue != population[i].chrom[point])
			{
				population[i].chrom[point] = newvalue;
			}		
			population[i].chrom[chormlength-1] = m_cycle-population[i].chrom[0];
			population[i].chrom[chormlength-1] -= population[i].chrom[1];
			population[i].chrom[chormlength-1] -= population[i].chrom[2];
		}		
	}
}

void CSearchCycleDlg::OnButtonCycle() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	
	m_progress.SetRange(0 , m_maxgeneration);
	m_progress.SetPos(0);
	
	CreatePoisson();
	
	generation=0;
	
	GenerateInitialPopulationCycle();
	EvaluatePopulationCycle();
	while(generation<m_maxgeneration)
	{
		generation++;
		if (generation==300)
		{
			int a=0;
		}
		GenerateNextPopulationCycle();
		EvaluatePopulationCycle();
		PerformeVolution();
		
		m_progress.SetPos(generation);
	}
	OutputTextReportCycle();
}

void CSearchCycleDlg::OutputTextReportCycle()
{
	m_x1 = currentbest.chrom[0];
	m_x2 = currentbest.chrom[1];
	m_x3 = currentbest.chrom[2];
	m_x4 = 100-m_x1-m_x2-m_x3;
	
	m_y = currentbest.mdata[0];
	m_d = currentbest.mdata[1];
	m_h = currentbest.mdata[2];
	m_q = currentbest.mdata[3];

	m_y1 = currentbest.y[0];
	m_y2 = currentbest.y[1];
	m_y3 = currentbest.y[2];
	m_y4 = currentbest.y[3];

	m_mincycle = currentbest.value;
	UpdateData(FALSE);
}

void CSearchCycleDlg::OnButtonTime() 
{
	// TODO: Add your control notification handler code here

	CreatePoisson();

	double c=0.0;
	double d , d1 , d2,d3,d4 , p1 , p2 ,p , y;
	double w1,w2,w3;
	double baohe13 = 0.27;
	double baohe24 = 0.33;
	double s1=960,s2=1200,s3=960,s4=1200,hour=3600;

	int x1=29,x2=17,x3=30,x4=15;
	c = x1+x2+x3+x4;
	
	double y1 = GetValue(forward , 0);
	y1 = (y1/100)/baohe13;
	y1 = y1*0.3;
	
	p1 = (1-4*li/c)*(1-4*li/c);
	p2 = 2*4/c;
	p = p1/p2;
	
	
	double y2 = GetValue(forward , 1);
	y2 = (y2/100)/baohe24;
	
	double y3 = GetValue(forward , 2);
	y3 = (y3/100)/baohe13;
	y3 = y3*0.3;
	
	double y4 = GetValue(forward , 3);
	y4 = (y4/100)/baohe24;
	
	y=y1+y2+y3+y4;
	m_y = y;
		
	w1=0.011;
	w2=0.866;
	w3=0.012;
	d1 = w1*(c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p) + w2*fabs(0.9*(1.0-x1/c)/(1.0-y1));
	d1 = d1 - w3*(x1/c)*s1/hour;
	
	d2 = w1*(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p) + w2*fabs(0.9*(1.0-x2/c)/(1.0-y2));
	d2 = d2 - w3*(x2/c)*s2/hour;
	
	d3 = w1*(c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p) + w2*fabs(0.9*(1.0-x3/c)/(1.0-y3));
	d3 = d3 - w3*(x3/c)*s3/hour;
	
	d4 = w1*(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p) + w2*fabs(0.9*(1.0-x4/c)/(1.0-y4));
	d4 = d4 - w3*(x4/c)*s4/hour;
	
	d = d1+d2+d3+d4;
	m_mincycle = d;
	
	m_y = y;
	
	m_d = (c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p)+(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p);
	m_d += (c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p)+(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p);
	
	m_h = 0.9*fabs((1.0-x1/c)/(1.0-y1));
	m_h += 0.9*fabs((1.0-x2/c)/(1.0-y2));
	m_h += 0.9*fabs((1.0-x3/c)/(1.0-y3));
	m_h += 0.9*fabs((1.0-x4/c)/(1.0-y4));
	
	m_q = (x1/c)*s1/hour+(x2/c)*s2/hour+(x3/c)*s3/hour+(x4/c)*s4/hour;
	
	m_y1 = y1;
	m_y2 = y2;
	m_y3 = y3;
	m_y4 = y4;

	m_x1 = x1;
	m_x2 = x2;
	m_x3 = x3;
	m_x4 = x4;

	UpdateData(FALSE);
}

void CSearchCycleDlg::CrossoverOperatorCycle()
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
			point=rand()%(chormlength-1);
			for (j=point; j<chormlength-1;j++)
			{
				temp=population[index[i]].chrom[j];
				population[index[i]].chrom[j]=population[index[i+1]].chrom[j];
				population[index[i+1]].chrom[j]=temp;
			}
			population[index[i]].chrom[chormlength-1]=m_cycle-population[index[i]].chrom[0];
			population[index[i]].chrom[chormlength-1]-=m_cycle-population[index[i]].chrom[1];
			population[index[i]].chrom[chormlength-1]-=m_cycle-population[index[i]].chrom[2];

			population[index[i+1]].chrom[chormlength-1]=m_cycle-population[index[i]].chrom[0];
			population[index[i+1]].chrom[chormlength-1]-=m_cycle-population[index[i]].chrom[1];
			population[index[i+1]].chrom[chormlength-1]-=m_cycle-population[index[i]].chrom[2];
		}
	}
	
	delete []index;
}

double CSearchCycleDlg::GetObjectValue(individual tempindividual)
{
	double c=0.0;
	double d , d1 , d2,d3,d4 , p1 , p2 ,p , y;
	double w1,w2,w3;
	double baohe13 = 0.27;
	double baohe24 = 0.33;
	double s1=960,s2=1200,s3=960,s4=1200,hour=3600;
	
	c = 0.0;
	for (int j=0;j<chormlength;j++)
	{
		c += tempindividual.chrom[j] + li;
	}
	
	for (j=0;j<4;j++)
	{
		tempindividual.mdata[j]=0.0;
	}
	
	double x1 = tempindividual.chrom[0];
	double y1 = GetValue(forward , 0);
	y1 = (y1/100)/baohe13;
	y1 = y1*0.3;
	
	p1 = (1-4*li/c)*(1-4*li/c);
	p2 = 2*4/c;
	p = p1/p2;
	
	double x2 = tempindividual.chrom[1];
	double y2 = GetValue(forward , 1);
	y2 = (y2/100)/baohe24;
	
	double x3 = tempindividual.chrom[2];
	double y3 = GetValue(forward , 2);
	y3 = (y3/100)/baohe13;
	y3 = y3*0.3;
	
	double x4 = 100 - x1-x2-x3;
	tempindividual.chrom[3] = x4;
	
	double y4 = GetValue(forward , 3);
	y4 = (y4/100)/baohe24;
	
	y=y1+y2+y3+y4;
	if(y>1.0)
	{
		tempindividual.value = 10000.0;
	}
	
	w1=0.011;
	w2=0.866;
	w3=0.012;
	d1 = w1*(c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p) + w2*fabs(0.9*(1.0-x1/c)/(1.0-y1));
	d1 = d1 - w3*(x1/c)*s1/hour;
	
	d2 = w1*(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p) + w2*fabs(0.9*(1.0-x2/c)/(1.0-y2));
	d2 = d2 - w3*(x2/c)*s2/hour;
	
	d3 = w1*(c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p) + w2*fabs(0.9*(1.0-x3/c)/(1.0-y3));
	d3 = d3 - w3*(x3/c)*s3/hour;
	
	d4 = w1*(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p) + w2*fabs(0.9*(1.0-x4/c)/(1.0-y4));
	d4 = d4 - w3*(x4/c)*s4/hour;
	
	d = d1+d2+d3+d4;
	tempindividual.value = d;
	
	tempindividual.mdata[0] = y;
	
	tempindividual.mdata[1] = (c*(1.0-x1/c)*(1.0-x1/c))/(2*(1.0-y1)+p)+(c*(1.0-x2/c)*(1.0-x2/c))/(2*(1.0-y2)+p);
	tempindividual.mdata[1] += (c*(1.0-x3/c)*(1.0-x3/c))/(2*(1.0-y3)+p)+(c*(1.0-x4/c)*(1.0-x4/c))/(2*(1.0-y4)+p);
	
	tempindividual.mdata[2] = 0.9*fabs((1.0-x1/c)/(1.0-y1));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x2/c)/(1.0-y2));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x3/c)/(1.0-y3));
	tempindividual.mdata[2] += 0.9*fabs((1.0-x4/c)/(1.0-y4));
	
	tempindividual.mdata[3] = (x1/c)*s1/hour+(x2/c)*s2/hour+(x3/c)*s3/hour+(x4/c)*s4/hour;
	
	tempindividual.y[0] = y1;
	tempindividual.y[1] = y2;
	tempindividual.y[2] = y3;
	tempindividual.y[3] = y4;

	return d;
}
