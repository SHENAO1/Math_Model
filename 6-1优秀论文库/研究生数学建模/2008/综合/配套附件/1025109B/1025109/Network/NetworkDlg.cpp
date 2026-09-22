// NetworkDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Network.h"
#include "NetworkDlg.h"
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
// CNetworkDlg dialog

CNetworkDlg::CNetworkDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CNetworkDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CNetworkDlg)
	m_maxgeneration = 1000;
	m_maxgenindex = 0;
	m_popsize = 1000;
	m_maxindex = 0;
	m_t1 = 0.0;
	m_t2 = 0.0;
	m_t3 = 0.0;
	m_t4 = 0.0;
	m_ta1 = 0.0;
	m_ta2 = 0.0;
	m_ta3 = 0.0;
	m_ta4 = 0.0;
	m_tb1 = 0.0;
	m_tb2 = 0.0;
	m_tb3 = 0.0;
	m_tb4 = 0.0;
	m_tc1 = 0.0;
	m_tc2 = 0.0;
	m_tc3 = 0.0;
	m_tc4 = 0.0;
	m_td1 = 0.0;
	m_td2 = 0.0;
	m_td3 = 0.0;
	m_td4 = 0.0;
	m_min = 0.0;
	m_othermin = 0.0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CNetworkDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CNetworkDlg)
	DDX_Control(pDX, IDC_PROGRESS1, m_progress);
	DDX_Text(pDX, IDC_EDIT_MAXGEN, m_maxgeneration);
	DDX_Text(pDX, IDC_EDIT_MAXINDEX, m_maxgenindex);
	DDX_Text(pDX, IDC_EDIT_POPSIZE, m_popsize);
	DDX_Text(pDX, IDC_EDIT_BESTINDEX, m_maxindex);
	DDX_Text(pDX, IDC_EDIT1, m_t1);
	DDX_Text(pDX, IDC_EDIT2, m_t2);
	DDX_Text(pDX, IDC_EDIT3, m_t3);
	DDX_Text(pDX, IDC_EDIT4, m_t4);
	DDX_Text(pDX, IDC_EDIT5, m_ta1);
	DDX_Text(pDX, IDC_EDIT6, m_ta2);
	DDX_Text(pDX, IDC_EDIT7, m_ta3);
	DDX_Text(pDX, IDC_EDIT8, m_ta4);
	DDX_Text(pDX, IDC_EDIT9, m_tb1);
	DDX_Text(pDX, IDC_EDIT10, m_tb2);
	DDX_Text(pDX, IDC_EDIT11, m_tb3);
	DDX_Text(pDX, IDC_EDIT12, m_tb4);
	DDX_Text(pDX, IDC_EDIT13, m_tc1);
	DDX_Text(pDX, IDC_EDIT14, m_tc2);
	DDX_Text(pDX, IDC_EDIT15, m_tc3);
	DDX_Text(pDX, IDC_EDIT16, m_tc4);
	DDX_Text(pDX, IDC_EDIT17, m_td1);
	DDX_Text(pDX, IDC_EDIT18, m_td2);
	DDX_Text(pDX, IDC_EDIT19, m_td3);
	DDX_Text(pDX, IDC_EDIT20, m_td4);
	DDX_Text(pDX, IDC_EDIT_MIN, m_min);
	DDX_Text(pDX, IDC_EDIT_OTHERSTOP, m_othermin);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CNetworkDlg, CDialog)
	//{{AFX_MSG_MAP(CNetworkDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_START, OnButtonStart)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNetworkDlg message handlers

BOOL CNetworkDlg::OnInitDialog()
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

	for (int i=0;i<8;i++)
	{
		streetstop[i]=0.0;
	}
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CNetworkDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CNetworkDlg::OnPaint() 
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
HCURSOR CNetworkDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CNetworkDlg::OnButtonStart() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	
	m_progress.SetRange(0 , m_maxgeneration);
	m_progress.SetPos(0);
	
	double yuzhi = 1.70;
	
	generation=0;
	
	GenerateInitialPopulationCycle();
	EvaluatePopulationCycle();
	//double diff = population[generation].value - yuzhi;
	while((generation<m_maxgeneration)/*&&(diff>0)*/)
	{
		generation++;
		//diff = population[generation].value - yuzhi;
		GenerateNextPopulationCycle();
		EvaluatePopulationCycle();
		PerformeVolution();
		
		m_progress.SetPos(generation);
	}
	OutputTextReportCycle();
}



int CNetworkDlg::jiecheng(int value)
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

int CNetworkDlg::GetXulie(double *pdata, int n , double value)
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


void CNetworkDlg::FindBestAndWorstIndividual()
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
        
		//sum+=population[i].value;
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

void CNetworkDlg::PerformeVolution()//最优个体保存策略
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

void CNetworkDlg::SelectOperator()
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


double CNetworkDlg::AverageRandom(double min, double max)
{
	int minInteger = (int)(min*10000);
	
	int maxInteger = (int)(max*10000); 
	
	int randInteger = rand()*rand(); 
	
	int diffInteger = maxInteger - minInteger; 
	
	int resultInteger = randInteger % diffInteger + minInteger; 
	
	return resultInteger/10000.0;     
}


void CNetworkDlg::EvaluatePopulationCycle()
{
	CalculateObjectValueCycle();
	FindBestAndWorstIndividual();
}

void CNetworkDlg::CalculateObjectValueCycle()
{
	double starttime,endtime,sum,sum1,sum2,sum3,sum4;
	
	double x1,x2,x3,x4,x5,x6,x7,x8;

	for (int i=0; i<m_popsize;i++)
	{
		sum = 0.0;
		sum1 = 0.0;
		sum2 = 0.0;
		sum3 = 0.0;
		sum4 = 0.0;
		
		starttime = 0;
		endtime = 0;
		
		for (int j=0;j<8;j++)
		{
			m_roadstreet[0][j].arrive=streetstop[j];
			m_roadstreet[0][j].output=0.0;
			m_roadstreet[0][j].stop=0.0;
		}
		double low = 1.8 , up = 1.9;
		x1 =  AverageRandom(low,up);//xi表示速度
		x2 =  AverageRandom(low,up);
		x3 =  AverageRandom(low,up);
		x4 =  AverageRandom(low,up);
		x5 =  AverageRandom(low,up);
		x6 =  AverageRandom(low,up);
		x7 =  AverageRandom(low,up);
		x8 =  AverageRandom(low,up);

		double t1 = population[i].chrom[0];
		double t2 = population[i].chrom[1];
		double t3 = population[i].chrom[2];
		double t4 = population[i].chrom[3];

		double tA1 = population[i].chrom[4];
		double tA2 = population[i].chrom[5];
		double tA3 = population[i].chrom[6];
		double tA4 = population[i].chrom[7];

		double tB1 = population[i].chrom[8];
		double tB2 = population[i].chrom[9];
		double tB3 = population[i].chrom[10];
		double tB4 = population[i].chrom[11];

		double tC1 = population[i].chrom[12];
		double tC2 = population[i].chrom[13];
		double tC3 = population[i].chrom[14];
		double tC4 = population[i].chrom[15];

		double tD1 = population[i].chrom[16];
		double tD2 = population[i].chrom[17];
		double tD3 = population[i].chrom[18];
		double tD4 = population[i].chrom[19];

		///////第一相位
		starttime = 0;
		endtime = t1;
		
		m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;
		m_roadstreet[0][0].output = x1*t1;
		m_roadstreet[0][0].stop = m_roadstreet[0][0].arrive - m_roadstreet[0][0].output;
		
		if (m_roadstreet[0][0].stop<0)
		{
			x1 = m_roadstreet[0][0].arrive/t1;
			m_roadstreet[0][0].stop = 0;
		}
		
		m_roadstreet[0][0].arrive = m_roadstreet[0][0].stop;
		
		m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
		m_roadstreet[0][1].output = x2*t1;
		m_roadstreet[0][1].stop = m_roadstreet[0][1].arrive - m_roadstreet[0][1].output;
		
		if (m_roadstreet[0][1].stop<0)
		{
			x2 = m_roadstreet[0][1].arrive/t1;
			m_roadstreet[0][1].stop = 0;
		}
		
		m_roadstreet[0][1].arrive = m_roadstreet[0][1].stop;
		
		
		m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
		m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
		m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
		m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
		m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;//forward
		m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
		
		sum1 = m_roadstreet[0][0].stop + m_roadstreet[0][1].stop;
		
		///////第二相位
		starttime = t1+3;
		endtime =  t1+3+t2;
		
		m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
		m_roadstreet[0][2].output = x3*t2;
		m_roadstreet[0][2].stop = m_roadstreet[0][2].arrive - m_roadstreet[0][2].output;
		
		if (m_roadstreet[0][2].stop < 0)
		{
			x3 = m_roadstreet[0][2].arrive/t2;
			m_roadstreet[0][2].stop = 0.0;
		}
		m_roadstreet[0][2].arrive = m_roadstreet[0][2].stop;
		
		
		m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
		m_roadstreet[0][3].output = x4*t2;
		m_roadstreet[0][3].stop = m_roadstreet[0][3].arrive - m_roadstreet[0][3].output;
		
		if (m_roadstreet[0][3].stop < 0)
		{
			x4 = m_roadstreet[0][3].arrive/t2;
			m_roadstreet[0][3].stop = 0.0;
		}
		m_roadstreet[0][3].arrive = m_roadstreet[0][3].stop;
		
		m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
		m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
		m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
		m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
		m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
		m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
		
		sum2 = m_roadstreet[0][2].stop + m_roadstreet[0][3].stop;
		
		
		///////第三相位
		starttime = t1+3+t2+3;
		endtime =  t1+3+t2+3+t3;
		
		m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
		m_roadstreet[0][4].output = x5*t3;
		m_roadstreet[0][4].stop = m_roadstreet[0][4].arrive - m_roadstreet[0][4].output;
		
		if (m_roadstreet[0][4].stop < 0)
		{
			x5 = m_roadstreet[0][4].arrive/t3;
			m_roadstreet[0][4].stop = 0.0;
		}
		m_roadstreet[0][4].arrive = m_roadstreet[0][4].stop;
		
		
		m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
		m_roadstreet[0][5].output = x6*t3;
		m_roadstreet[0][5].stop = m_roadstreet[0][5].arrive - m_roadstreet[0][5].output;
		
		if (m_roadstreet[0][5].stop < 0)
		{
			x6 = m_roadstreet[0][5].arrive/t3;
			m_roadstreet[0][5].stop = 0.0;
		}
		m_roadstreet[0][5].arrive = m_roadstreet[0][5].stop;
		
		m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
		m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
		m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;//forward
		m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
		m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
		m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
		
		sum3 = m_roadstreet[0][4].stop + m_roadstreet[0][5].stop;
		
		///////第四相位
		starttime = endtime;
		endtime =  endtime+t4;
		
		m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
		m_roadstreet[0][6].output = x7*t4;
		m_roadstreet[0][6].stop = m_roadstreet[0][6].arrive - m_roadstreet[0][6].output;
		
		if (m_roadstreet[0][6].stop < 0)
		{
			x7 = m_roadstreet[0][6].arrive/t4;
			m_roadstreet[0][6].stop = 0.0;
		}
		m_roadstreet[0][6].arrive = m_roadstreet[0][6].stop;
		
		m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
		m_roadstreet[0][7].output = x8*t4;
		m_roadstreet[0][7].stop = m_roadstreet[0][7].arrive - m_roadstreet[0][7].output;
		
		if (m_roadstreet[0][7].stop < 0)
		{
			x8 = m_roadstreet[0][7].arrive/t4;
			m_roadstreet[0][7].stop = 0.0;
		}
		m_roadstreet[0][7].arrive = m_roadstreet[0][7].stop;
		
		m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
		m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
		m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
		m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
		m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68;//left
		m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
		
		sum4 = m_roadstreet[0][6].stop + m_roadstreet[0][7].stop;
		
		sum = sum1+sum2+sum3+sum4;

		population[i].value = sum;

		population[i].stop[0] = m_roadstreet[0][0].arrive;
		population[i].stop[1] = m_roadstreet[0][1].arrive;
		population[i].stop[2] = m_roadstreet[0][2].arrive;
		population[i].stop[3] = m_roadstreet[0][3].arrive;
		population[i].stop[4] = m_roadstreet[0][4].arrive;
		population[i].stop[5] = m_roadstreet[0][5].arrive;
		population[i].stop[6] = m_roadstreet[0][6].arrive;
		population[i].stop[7] = m_roadstreet[0][7].arrive;
	}
}

void CNetworkDlg::GenerateInitialPopulationCycle()
{
	for (int i=0;i<m_popsize;i++)
	{
		while(population[i].t[3] < 20)
		{
			population[i].t[0] =  AverageRandom(15,30);
			population[i].t[1] =  AverageRandom(30,45);
			population[i].t[2] =  AverageRandom(30,45);
			population[i].t[3] =  cycle-population[i].t[0]-population[i].t[1]-population[i].t[2];
		}
		population[i].chrom[0] = population[i].t[0];
		population[i].chrom[1] = population[i].t[1];
		population[i].chrom[2] = population[i].t[2];
		population[i].chrom[3] = population[i].t[3];

		while(population[i].tA[3] < 20)
		{
			population[i].tA[0] = AverageRandom(5,30);
			population[i].tA[1] = AverageRandom(40,70);
			population[i].tA[2] = AverageRandom(15,30);
			population[i].tA[3] = cycle - population[i].tA[0]-population[i].tA[1]-population[i].tA[2];
		}
		population[i].chrom[4] = population[i].tA[0];
		population[i].chrom[5] = population[i].tA[1];
		population[i].chrom[6] = population[i].tA[2];
		population[i].chrom[7] = population[i].tA[3];

		while(population[i].tB[3] < 20)
		{
			population[i].tB[0] = AverageRandom(10,30);
			population[i].tB[1] = AverageRandom(30,60);
			population[i].tB[2] = AverageRandom(20,40);
			population[i].tB[3] = cycle - population[i].tB[0]-population[i].tB[1]-population[i].tB[2];
		}
		population[i].chrom[8] = population[i].tB[0];
		population[i].chrom[9] = population[i].tB[1];
		population[i].chrom[10] = population[i].tB[2];
		population[i].chrom[11] = population[i].tB[3];

		while(population[i].tC[3] < 20)
		{
			population[i].tC[0] = AverageRandom(20,40);
			population[i].tC[1] = AverageRandom(20,40);
			population[i].tC[2] = AverageRandom(20,40);
			population[i].tC[3] = cycle - population[i].tC[0]-population[i].tC[1]-population[i].tC[2];
		}
		population[i].chrom[12] = population[i].tC[0];
		population[i].chrom[13] = population[i].tC[1];
		population[i].chrom[14] = population[i].tC[2];
		population[i].chrom[15] = population[i].tC[3];

		while(population[i].tD[3] < 20)
		{
			population[i].tD[0] = AverageRandom(20,45);
			population[i].tD[1] = AverageRandom(20,45);
			population[i].tD[2] = AverageRandom(20,45);
			population[i].tD[3] = cycle - population[i].tD[0]-population[i].tD[1]-population[i].tD[2];			
		}
		population[i].chrom[16] = population[i].tD[0];
		population[i].chrom[17] = population[i].tD[1];
		population[i].chrom[18] = population[i].tD[2];
		population[i].chrom[19] = population[i].tD[3];

		population[i].chrom[chormlength]='\0';
	}
}

void CNetworkDlg::GenerateNextPopulationCycle()
{
	SelectOperator();
	CrossoverOperatorCycle();
	MutationOperatorCycle();
}

void CNetworkDlg::MutationOperatorCycle()
{
	int point = 0;
	double p = 0.0;
	double newvalue = 0.0;
	
	struct individual tempindividual;

	for (int i=0; i<m_popsize; i++)
	{
		tempindividual = population[i];
		p=rand()%1000/1000.0;
		point=rand()%chormlength;
		for (int j=point;j>0;j--)
		{
			pm=((double)j)/chormlength;
			if (p < pm)
			{
				newvalue = GetMutationValue(point , i);	
				if (newvalue != population[i].chrom[point])
				{
					population[i].chrom[point] = newvalue;
				}
				if (population[i].value < tempindividual.value)
				{
					break;
				}
			}	
			
		}
		if (GetNewIndividualValue(population[i]) == tempindividual.value)
		{
			p=rand()%1000/1000.0;
			pm = 1.0/chormlength;
			if (p < pm)
			{
				point=rand()%chormlength;
				newvalue = GetMutationValue(point , i);			
				if (newvalue != population[i].chrom[point])
				{
					population[i].chrom[point] = newvalue;
				}	
			}
		}

		for (int k=3;k<chormlength;k+=4)
		{
			population[i].chrom[k]=cycle-population[i].chrom[k-1];
			population[i].chrom[k]-=population[i].chrom[k-2];
			population[i].chrom[k]-=population[i].chrom[k-3];
		}
	}
}



void CNetworkDlg::OutputTextReportCycle()
{
	m_t1 = currentbest.chrom[0];
	m_t2 = currentbest.chrom[1];
	m_t3 = currentbest.chrom[2];
	m_t4 = currentbest.chrom[3];

	m_ta1 = currentbest.chrom[4];
	m_ta2 = currentbest.chrom[5];
	m_ta3 = currentbest.chrom[6];
	m_ta4 = currentbest.chrom[7];

	m_tb1 = currentbest.chrom[8];
	m_tb2 = currentbest.chrom[9];
	m_tb3 = currentbest.chrom[10];
	m_tb4 = currentbest.chrom[11];

	m_tc1 = currentbest.chrom[12];
	m_tc2 = currentbest.chrom[13];
	m_tc3 = currentbest.chrom[14];
	m_tc4 = currentbest.chrom[15];

	m_td1 = currentbest.chrom[16];
	m_td2 = currentbest.chrom[17];
	m_td3 = currentbest.chrom[18];
	m_td4 = currentbest.chrom[19];

	m_min = currentbest.value;

	streetstop[0] = currentbest.stop[0];
	streetstop[1] = currentbest.stop[1];
	streetstop[2] = currentbest.stop[2];
	streetstop[3] = currentbest.stop[3];
	streetstop[4] = currentbest.stop[4];
	streetstop[5] = currentbest.stop[5];
	streetstop[6] = currentbest.stop[6];
	streetstop[7] = currentbest.stop[7];

	m_othermin  = GetOtherMinStop(currentbest);
	UpdateData(FALSE);
}


void CNetworkDlg::CrossoverOperatorCycle()
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

			for (j=3;j<chormlength;j+=4)
			{
				population[index[i]].chrom[j]=cycle-population[index[i]].chrom[j-1];
				population[index[i]].chrom[j]-=population[index[i]].chrom[j-2];
				population[index[i]].chrom[j]-=population[index[i]].chrom[j-3];

				population[index[i+1]].chrom[j]=cycle-population[index[i+1]].chrom[j-1];
				population[index[i+1]].chrom[j]-=population[index[i+1]].chrom[j-2];
				population[index[i+1]].chrom[j]-=population[index[i+1]].chrom[j-3];
			}

		}
	}
	
	delete []index;
}

double CNetworkDlg::GetNewIndividualValue(individual tempindividual)
{
	double starttime,endtime,sum,sum1,sum2,sum3,sum4;
	
	double x1,x2,x3,x4,x5,x6,x7,x8;


	sum = 0.0;
	sum1 = 0.0;
	sum2 = 0.0;
	sum3 = 0.0;
	sum4 = 0.0;
	
	starttime = 0;
	endtime = 0;
	
	for (int j=0;j<8;j++)
	{
		m_roadstreet[0][j].arrive=streetstop[j];
		m_roadstreet[0][j].output=0.0;
		m_roadstreet[0][j].stop=0.0;
	}
	x1 =  AverageRandom(2.1,2.3);//xi表示速度
	x2 =  AverageRandom(2.1,2.3);
	x3 =  AverageRandom(2.1,2.3);
	x4 =  AverageRandom(2.1,2.3);
	x5 =  AverageRandom(2.1,2.3);
	x6 =  AverageRandom(2.1,2.3);
	x7 =  AverageRandom(2.1,2.3);
	x8 =  AverageRandom(2.1,2.3);
	
	double t1 = tempindividual.chrom[0];
	double t2 = tempindividual.chrom[1];
	double t3 = tempindividual.chrom[2];
	double t4 = tempindividual.chrom[3];
	
	double tA1 = tempindividual.chrom[4];
	double tA2 = tempindividual.chrom[5];
	double tA3 = tempindividual.chrom[6];
	double tA4 = tempindividual.chrom[7];
	
	double tB1 = tempindividual.chrom[8];
	double tB2 = tempindividual.chrom[9];
	double tB3 = tempindividual.chrom[10];
	double tB4 = tempindividual.chrom[11];
	
	double tC1 = tempindividual.chrom[12];
	double tC2 = tempindividual.chrom[13];
	double tC3 = tempindividual.chrom[14];
	double tC4 = tempindividual.chrom[15];
	
	double tD1 = tempindividual.chrom[16];
	double tD2 = tempindividual.chrom[17];
	double tD3 = tempindividual.chrom[18];
	double tD4 = tempindividual.chrom[19];
	
	///////第一相位
	starttime = 0;
	endtime = t1;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;
	m_roadstreet[0][0].output = x1*t1;
	m_roadstreet[0][0].stop = m_roadstreet[0][0].arrive - m_roadstreet[0][0].output;
	
	if (m_roadstreet[0][0].stop<0)
	{
		x1 = m_roadstreet[0][0].arrive/t1;
		m_roadstreet[0][0].stop = 0;
	}
	
	m_roadstreet[0][0].arrive = m_roadstreet[0][0].stop;
	
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][1].output = x2*t1;
	m_roadstreet[0][1].stop = m_roadstreet[0][1].arrive - m_roadstreet[0][1].output;
	
	if (m_roadstreet[0][1].stop<0)
	{
		x2 = m_roadstreet[0][1].arrive/t1;
		m_roadstreet[0][1].stop = 0;
	}
	
	m_roadstreet[0][1].arrive = m_roadstreet[0][1].stop;
	
	
	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;//forward
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	
	sum1 = m_roadstreet[0][0].stop + m_roadstreet[0][1].stop;
	
	///////第二相位
	starttime = t1+3;
	endtime =  t1+3+t2;
	
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][2].output = x3*t2;
	m_roadstreet[0][2].stop = m_roadstreet[0][2].arrive - m_roadstreet[0][2].output;
	
	if (m_roadstreet[0][2].stop < 0)
	{
		x3 = m_roadstreet[0][2].arrive/t2;
		m_roadstreet[0][2].stop = 0.0;
	}
	m_roadstreet[0][2].arrive = m_roadstreet[0][2].stop;
	
	
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][3].output = x4*t2;
	m_roadstreet[0][3].stop = m_roadstreet[0][3].arrive - m_roadstreet[0][3].output;
	
	if (m_roadstreet[0][3].stop < 0)
	{
		x4 = m_roadstreet[0][3].arrive/t2;
		m_roadstreet[0][3].stop = 0.0;
	}
	m_roadstreet[0][3].arrive = m_roadstreet[0][3].stop;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	
	sum2 = m_roadstreet[0][2].stop + m_roadstreet[0][3].stop;
	
	
	///////第三相位
	starttime = t1+3+t2+3;
	endtime =  t1+3+t2+3+t3;
	
	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
	m_roadstreet[0][4].output = x5*t3;
	m_roadstreet[0][4].stop = m_roadstreet[0][4].arrive - m_roadstreet[0][4].output;
	
	if (m_roadstreet[0][4].stop < 0)
	{
		x5 = m_roadstreet[0][4].arrive/t3;
		m_roadstreet[0][4].stop = 0.0;
	}
	m_roadstreet[0][4].arrive = m_roadstreet[0][4].stop;
	
	
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	m_roadstreet[0][5].output = x6*t3;
	m_roadstreet[0][5].stop = m_roadstreet[0][5].arrive - m_roadstreet[0][5].output;
	
	if (m_roadstreet[0][5].stop < 0)
	{
		x6 = m_roadstreet[0][5].arrive/t3;
		m_roadstreet[0][5].stop = 0.0;
	}
	m_roadstreet[0][5].arrive = m_roadstreet[0][5].stop;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;//forward
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	
	sum3 = m_roadstreet[0][4].stop + m_roadstreet[0][5].stop;
	
	///////第四相位
	starttime = endtime;
	endtime =  endtime+t4;
	
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
	m_roadstreet[0][6].output = x7*t4;
	m_roadstreet[0][6].stop = m_roadstreet[0][6].arrive - m_roadstreet[0][6].output;
	
	if (m_roadstreet[0][6].stop < 0)
	{
		x7 = m_roadstreet[0][6].arrive/t4;
		m_roadstreet[0][6].stop = 0.0;
	}
	m_roadstreet[0][6].arrive = m_roadstreet[0][6].stop;
	
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	m_roadstreet[0][7].output = x8*t4;
	m_roadstreet[0][7].stop = m_roadstreet[0][7].arrive - m_roadstreet[0][7].output;
	
	if (m_roadstreet[0][7].stop < 0)
	{
		x8 = m_roadstreet[0][7].arrive/t4;
		m_roadstreet[0][7].stop = 0.0;
	}
	m_roadstreet[0][7].arrive = m_roadstreet[0][7].stop;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68;//left
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	
	sum4 = m_roadstreet[0][6].stop + m_roadstreet[0][7].stop;
	
	sum = sum1+sum2+sum3+sum4;

	return sum;
}

double CNetworkDlg::GetMutationValue(int pos , int i)
{
	double newvalue = 0.0;
	switch (pos)
	{
	case 0: newvalue = AverageRandom(15.0,30.0);
			break;
	case 1: newvalue = AverageRandom(30.0,45.0);
			break;
	case 2: newvalue = AverageRandom(30.0,45.0);
			break;
	case 3: newvalue = population[i].chrom[3];
			break;
	case 4: newvalue = AverageRandom(5.0,30.0);
			break;
	case 5: newvalue = AverageRandom(40.0,70.0);
			break;
	case 6: newvalue = AverageRandom(15.0,30.0);
			break;
	case 7: newvalue = population[i].chrom[7];
			break;
	case 8: newvalue = AverageRandom(10.0,30.0);
			break;
	case 9: newvalue = AverageRandom(30.0,60.0);
			break;
	case 10: newvalue = AverageRandom(20.0,40.0);
			break;
	case 11: newvalue = population[i].chrom[11];
			break;
	case 12: newvalue = AverageRandom(20.0,40.0);
			break;
	case 13: newvalue = AverageRandom(20.0,40.0);
			break;
	case 14: newvalue = AverageRandom(20.0,40.0);
			break;
	case 15: newvalue = population[i].chrom[15];
			break;
	case 16: newvalue = AverageRandom(20.0,45.0);
			break;
	case 17: newvalue = AverageRandom(20.0,45.0);
			break;
	case 18: newvalue = AverageRandom(20.0,45.0);
			break;
	case 19: newvalue = population[i].chrom[15];
			break;
	}
	return newvalue;
}

double CNetworkDlg::GetOtherMinStop(individual tempindividual)
{
	double othermin = 0.0;
	
	CreatePoisson(0.1);

	double t1 = tempindividual.chrom[0];
	double t2 = tempindividual.chrom[1];
	double t3 = tempindividual.chrom[2];
	double t4 = tempindividual.chrom[3];
	
	double tA1 = tempindividual.chrom[4];
	double tA2 = tempindividual.chrom[5];
	double tA3 = tempindividual.chrom[6];
	double tA4 = tempindividual.chrom[7];
	
	double tB1 = tempindividual.chrom[8];
	double tB2 = tempindividual.chrom[9];
	double tB3 = tempindividual.chrom[10];
	double tB4 = tempindividual.chrom[11];
	
	double tC1 = tempindividual.chrom[12];
	double tC2 = tempindividual.chrom[13];
	double tC3 = tempindividual.chrom[14];
	double tC4 = tempindividual.chrom[15];
	
	double tD1 = tempindividual.chrom[16];
	double tD2 = tempindividual.chrom[17];
	double tD3 = tempindividual.chrom[18];
	double tD4 = tempindividual.chrom[19];

	int start = 0 , end = 0;
	//左边路口
	start = (int)tA1+3+(int)tA2+3;
	end = (int)tA1+3+(int)tA2+3+(int)tA3;
	m_otherstreet[0].arrive += GetInputFlow(forward , start , end);

	m_otherstreet[0].output = 0;
	m_otherstreet[0].stop = m_otherstreet[0].arrive-m_otherstreet[0].output;
	
	start = (int)tA1+3;
	end = (int)tA1+3+(int)tA2;
	m_otherstreet[1].arrive += GetInputFlow(forward , start , end);
	m_otherstreet[1].output = tA2*0.5*0.68;
	m_otherstreet[1].stop = m_otherstreet[1].arrive-m_otherstreet[1].output;

	//右边路口
	start = (int)tB1+3+(int)tB2+3+(int)tB3+3;
	end = (int)tB1+3+(int)tB2+3+(int)tB3+3+(int)tB4;
	m_otherstreet[2].arrive += GetInputFlow(forward , start , end);
	m_otherstreet[2].output = 0;
	m_otherstreet[2].stop = m_otherstreet[2].arrive-m_otherstreet[2].output;

	start =(int)tB1+3;
	end = (int)tB1+3+(int)(tB2);
	m_otherstreet[3].arrive += GetInputFlow(forward , start , end);
	m_otherstreet[3].output = tB2*0.5*0.68;
	m_otherstreet[3].stop = m_otherstreet[3].arrive-m_otherstreet[3].output;

	//上面路口
	start = (int)tC1+3+(int)tC2+3;
	end = start + (int)tC3;
	m_otherstreet[4].arrive += GetInputFlow(forward , start , end);
	m_otherstreet[4].output = 0;
	m_otherstreet[4].stop = m_otherstreet[4].arrive-m_otherstreet[4].output;
	
	start = (int)tC1+3+(int)tC2+3+(int)tC3+3;
	end = start+(int)tC4;
	m_otherstreet[5].arrive += GetInputFlow(forward , start , end);
	m_otherstreet[5].output = tC4*0.5*0.68;
	m_otherstreet[5].stop = m_otherstreet[5].arrive-m_otherstreet[5].output;
	
	//下面路口
	start = (int)tD1+3+(int)tD2+3;
	end = start+(int)tD3;
	m_otherstreet[6].arrive += GetInputFlow(forward , start , end);
	m_otherstreet[6].output = 0;
	m_otherstreet[6].stop = m_otherstreet[6].arrive-m_otherstreet[6].output;
	
	start = (int)tD1+3+(int)tD2+3+(int)tD3+3;
	end = start + (int)tD4;
	m_otherstreet[7].arrive += GetInputFlow(forward , start , end);
	m_otherstreet[7].output = tD4*0.5*0.68;
	m_otherstreet[7].stop = m_otherstreet[7].arrive-m_otherstreet[7].output;

	for (int i=0;i<8;i++)
	{
		if (m_otherstreet[i].stop<0)
		{
			m_otherstreet[i].stop=0.0;
		}
		m_otherstreet[i].arrive = m_otherstreet[i].stop;
	}

	for (i=0;i<8;i++)
	{
		othermin += m_otherstreet[i].arrive;
	}

	return othermin;
}

void CNetworkDlg::CreatePoisson(double lamuda)
{
	/////////////产生直道poisson序列
	const int count = 20;
	double *data = new double[count];//k从0到20的poisson概率放在data数组中
	double pk = 0.0;
	double t = 1;
	//double lamuda = 0.133*4;
	
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

int CNetworkDlg::GetInputFlow(int *forward, int start, int end)
{
	int sum = 0;
	for (int i=start;i<end;i++)
	{
		sum += forward[i];
	}
	return sum;
}
