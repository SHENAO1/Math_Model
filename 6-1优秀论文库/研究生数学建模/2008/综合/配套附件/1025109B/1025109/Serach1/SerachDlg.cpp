// SerachDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Serach.h"
#include "SerachDlg.h"
#include <math.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

int forward[250];
int left[250];

 double mt1=22;
 double mt2=41;
 double mt3=34;
 double mt4=23,
 double mtA1=22;
 double mtA2=58;
 double mtA3=19;
 double mtA4=21;
 double mtB1=14;
 double mtB2=50;
 double mtB3=24;
 double mtB4=32;
 double mtC1=29;
 double mtC2=32;
 double mtC3=25;
 double mtC4=34;
 double mtD1=20;
 double mtD2=40;
 double mtD3=29;
 double mtD4=31;
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
// CSerachDlg dialog

CSerachDlg::CSerachDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSerachDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSerachDlg)
	m_min = _T("");
	m_t1 = _T("");
	m_t2 = _T("");
	m_t3 = _T("");
	m_t4 = _T("");
	m_x1 = _T("");
	m_x2 = _T("");
	m_x3 = _T("");
	m_x4 = _T("");
	m_x5 = _T("");
	m_x6 = _T("");
	m_x7 = _T("");
	m_x8 = _T("");
	m_num1 = _T("");
	m_num2 = _T("");
	m_num3 = _T("");
	m_num4 = _T("");
	m_num5 = _T("");
	m_num6 = _T("");
	m_num7 = _T("");
	m_num8 = _T("");
	m_ta1 = _T("");
	m_ta2 = _T("");
	m_ta3 = _T("");
	m_ta4 = _T("");
	m_tb1 = _T("");
	m_tb2 = _T("");
	m_tb3 = _T("");
	m_tb4 = _T("");
	m_tc1 = _T("");
	m_tc2 = _T("");
	m_tc3 = _T("");
	m_tc4 = _T("");
	m_td1 = _T("");
	m_td2 = _T("");
	m_td3 = _T("");
	m_td4 = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CSerachDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSerachDlg)
	DDX_Text(pDX, IDC_EDIT_NUM, m_min);
	DDX_Text(pDX, IDC_EDIT_T1, m_t1);
	DDX_Text(pDX, IDC_EDIT_T2, m_t2);
	DDX_Text(pDX, IDC_EDIT_T3, m_t3);
	DDX_Text(pDX, IDC_EDIT_T4, m_t4);
	DDX_Text(pDX, IDC_EDIT1, m_x1);
	DDX_Text(pDX, IDC_EDIT2, m_x2);
	DDX_Text(pDX, IDC_EDIT3, m_x3);
	DDX_Text(pDX, IDC_EDIT4, m_x4);
	DDX_Text(pDX, IDC_EDIT5, m_x5);
	DDX_Text(pDX, IDC_EDIT6, m_x6);
	DDX_Text(pDX, IDC_EDIT7, m_x7);
	DDX_Text(pDX, IDC_EDIT8, m_x8);
	DDX_Text(pDX, IDC_EDIT_11, m_num1);
	DDX_Text(pDX, IDC_EDIT_12, m_num2);
	DDX_Text(pDX, IDC_EDIT_13, m_num3);
	DDX_Text(pDX, IDC_EDIT_14, m_num4);
	DDX_Text(pDX, IDC_EDIT_15, m_num5);
	DDX_Text(pDX, IDC_EDIT_16, m_num6);
	DDX_Text(pDX, IDC_EDIT_17, m_num7);
	DDX_Text(pDX, IDC_EDIT_18, m_num8);
	DDX_Text(pDX, IDC_EDIT_TA1, m_ta1);
	DDX_Text(pDX, IDC_EDIT_TA2, m_ta2);
	DDX_Text(pDX, IDC_EDIT_TA3, m_ta3);
	DDX_Text(pDX, IDC_EDIT_TA4, m_ta4);
	DDX_Text(pDX, IDC_EDIT_TB1, m_tb1);
	DDX_Text(pDX, IDC_EDIT_TB2, m_tb2);
	DDX_Text(pDX, IDC_EDIT_TB3, m_tb3);
	DDX_Text(pDX, IDC_EDIT_TB4, m_tb4);
	DDX_Text(pDX, IDC_EDIT_TC1, m_tc1);
	DDX_Text(pDX, IDC_EDIT_TC2, m_tc2);
	DDX_Text(pDX, IDC_EDIT_TC3, m_tc3);
	DDX_Text(pDX, IDC_EDIT_TC4, m_tc4);
	DDX_Text(pDX, IDC_EDIT_TD1, m_td1);
	DDX_Text(pDX, IDC_EDIT_TD2, m_td2);
	DDX_Text(pDX, IDC_EDIT_TD3, m_td3);
	DDX_Text(pDX, IDC_EDIT_TD4, m_td4);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CSerachDlg, CDialog)
	//{{AFX_MSG_MAP(CSerachDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_START, OnButtonStart)
	ON_BN_CLICKED(IDC_BUTTON1, OnButton1)
	ON_BN_CLICKED(IDC_BUTTON2, OnButton2)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSerachDlg message handlers

BOOL CSerachDlg::OnInitDialog()
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

	streetstop[0] = 0;
	streetstop[1] = 0;
	streetstop[2] = 0;
	streetstop[3] = 0;
	streetstop[4] = 0;
	streetstop[5] = 0;
	streetstop[6] = 0;
	streetstop[7] = 0;

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CSerachDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CSerachDlg::OnPaint() 
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
HCURSOR CSerachDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CSerachDlg::OnButtonStart() 
{
     //NoneFixedCircle();

	 NetWorkRoad();

	 //FixedCircle();
	 //yanshi();
}

void CSerachDlg::CreatePoisson()
{
	/////////////产生直道poisson序列
	const int count = 20;
	double *data = new double[count];//k从0到20的poisson概率放在data数组中
	double pk = 0.0;
	double t = 1;
	double lamuda = 0.15;
	
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
	
	/////////////产生左道poisson序列
	lamuda = 0.06;
	double *leftdata = new double[count];//k从0到20的poisson概率放在data数组中
	
	sum = 0.0;
	for (i=0;i<count;i++)
	{
		pk = pow(lamuda*t , i)/jiecheng(i)*exp(-lamuda*t);//pk为poisson概率
		sum += pk;
		leftdata[i] = sum;
		if (sum > 0.99)
		{
			n=i;
			break;
		}
	}
	
	for (i=0; i<randcount; i++)
	{
		double temp = AverageRandom(0.0,1.0);
		p[i] = temp;
	}
	
	//static	int *left = new int[randcount];
	sequencevalue = 0;
	for (i=0; i<randcount; i++)
	{
		sequencevalue = GetXulie(leftdata , n , p[i]);
		left[i] = sequencevalue;
	}
	
	delete []data;
	delete []leftdata;
	delete []p;
}

int CSerachDlg::jiecheng(int value)
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

int CSerachDlg::GetXulie(double *pdata, int n , double value)
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

double CSerachDlg::AverageRandom(double min,double max)          
{  
	int minInteger = (int)(min*10000);
	
	int maxInteger = (int)(max*10000); 
	
	int randInteger = rand()*rand(); 
	
	int diffInteger = maxInteger - minInteger; 
	
	int resultInteger = randInteger % diffInteger + minInteger; 
	
	return resultInteger/10000.0;          
}

double CSerachDlg::GetInputFlow(int *forward , int start , int end)
{
	double sum = 0;
	for (int i=start;i<end;i++)
	{
		sum += forward[i];
	}
	return sum;
}

void CSerachDlg::FixedCircle()
{
/*	double starttime,endtime,sum,sum1,sum2,sum3,sum4,yellow,diff1,diff2;
	
	double minum=100000000,t1,t2,t3,t4,x1,x2,x3,x4,x5,x6,x7,x8;

	sum = 0.0;
	sum1 = 0.0;
	sum2 = 0.0;
	sum3 = 0.0;
	sum4 = 0.0;
	yellow = 0.0;
	diff1 = 0.0;
	diff2 = 0.0;

	starttime = 0;
	endtime = 0;
		
	CreatePoisson();

	for (res.t4=40;res.t4<60;res.t4++)
	{
		for (res.t3=19;res.t3<30;res.t3++)
		{
			for (res.t2=40;res.t2<60;res.t2++)
			{
				for (res.t1=19;res.t1<30;res.t1++)
				{
					for (int j=0;j<8;j++)
					{
						m_roadstreet[j].arrive=streetstop[j];
						m_roadstreet[j].output=0.0;
						m_roadstreet[j].stop=0.0;
					}
					
					res.x1 =  AverageRandom(0.5,0.51);
					res.x2 =  AverageRandom(0.5,0.51);
					res.x3 =  AverageRandom(0.5,0.51);
					res.x4 =  AverageRandom(0.5,0.51);
					res.x5 =  AverageRandom(0.5,0.51);
					res.x6 =  AverageRandom(0.5,0.51);
					res.x7 =  AverageRandom(0.5,0.51);
					res.x8 =  AverageRandom(0.5,0.51);
					
					///////第一相位
					starttime = 0;
					endtime =  res.t1;
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[0].output = res.x1*res.t1;
					m_roadstreet[0].stop = m_roadstreet[0].arrive - m_roadstreet[0].output;
					
					if (m_roadstreet[0].stop<0)
					{
						res.x1 = m_roadstreet[0].arrive/res.t1;
						m_roadstreet[0].stop = 0;
					}
					
					m_roadstreet[0].arrive = m_roadstreet[0].stop;
					
					m_roadstreet[1].arrive += GetInputFlow(left , starttime ,endtime);
					m_roadstreet[1].output = res.x2*res.t1;
					m_roadstreet[1].stop = m_roadstreet[1].arrive - m_roadstreet[1].output;
					
					if (m_roadstreet[1].stop<0)
					{
						res.x2 = m_roadstreet[1].arrive/res.t1;
						m_roadstreet[1].stop = 0;
					}
					
					m_roadstreet[1].arrive = m_roadstreet[1].stop;
					
					
					m_roadstreet[4].arrive += GetInputFlow(left , starttime , endtime);//left
					m_roadstreet[5].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[2].arrive += GetInputFlow(forward , starttime, endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward , starttime, endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime,endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward , starttime, endtime);
					
					starttime = res.t1;
					endtime = res.t1+3;
					
					//yellowtime
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward , starttime , endtime);
					
					sum1 = m_roadstreet[0].stop + m_roadstreet[1].stop;
					
					///////第二相位
					starttime = res.t1+3;
					endtime =  res.t1+3+res.t2;
					
					m_roadstreet[2].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[2].output = res.x3*res.t2;
					m_roadstreet[2].stop = m_roadstreet[2].arrive - m_roadstreet[2].output;
					
					if (m_roadstreet[2].stop < 0)
					{
						res.x3 = m_roadstreet[2].arrive/res.t2;
						m_roadstreet[2].stop = 0.0;
					}
					m_roadstreet[2].arrive = m_roadstreet[2].stop;
					
					
					m_roadstreet[3].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[3].output = res.x4*res.t2;
					m_roadstreet[3].stop = m_roadstreet[3].arrive - m_roadstreet[3].output;
					
					if (m_roadstreet[3].stop < 0)
					{
						res.x4 = m_roadstreet[3].arrive/res.t2;
						m_roadstreet[3].stop = 0.0;
					}
					m_roadstreet[3].arrive = m_roadstreet[3].stop;
					
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime );//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[7].arrive += GetInputFlow(forward ,starttime , endtime);
					
					//yellowtime
					starttime = res.t1+3+res.t2;
					endtime =  res.t1+3+res.t2+3;
					
					m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
					
					sum2 = m_roadstreet[2].stop + m_roadstreet[3].stop;
					
					
					///////第三相位
					starttime = res.t1+3+res.t2+3;
					endtime =  res.t1+3+res.t2+3+res.t3;
					
					m_roadstreet[4].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[4].output = res.x5*res.t3;
					m_roadstreet[4].stop = m_roadstreet[4].arrive - m_roadstreet[4].output;
					
					if (m_roadstreet[4].stop < 0)
					{
						res.x5 = m_roadstreet[4].arrive/res.t3;
						m_roadstreet[4].stop = 0.0;
					}
					m_roadstreet[4].arrive = m_roadstreet[4].stop;
					
					
					m_roadstreet[5].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[5].output = res.x6*res.t3;
					m_roadstreet[5].stop = m_roadstreet[5].arrive - m_roadstreet[5].output;
					
					if (m_roadstreet[5].stop < 0)
					{
						res.x6 = m_roadstreet[5].arrive/res.t3;
						m_roadstreet[5].stop = 0.0;
					}
					m_roadstreet[5].arrive = m_roadstreet[5].stop;
					
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime );//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[2].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[3].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[7].arrive += GetInputFlow(forward ,starttime , endtime);
					
					//yellowtime
					starttime = endtime;
					endtime =  endtime+3;
					
					m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
					
					sum3 = m_roadstreet[4].stop + m_roadstreet[5].stop;
					
					///////第四相位
					starttime = endtime;
					endtime =  endtime+res.t4;
					
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[6].output = res.x7*res.t4;
					m_roadstreet[6].stop = m_roadstreet[6].arrive - m_roadstreet[6].output;
					
					if (m_roadstreet[6].stop < 0)
					{
						res.x7 = m_roadstreet[6].arrive/res.t4;
						m_roadstreet[6].stop = 0.0;
					}
					m_roadstreet[6].arrive = m_roadstreet[6].stop;
					
					
					m_roadstreet[7].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[7].output = res.x8*res.t4;
					m_roadstreet[7].stop = m_roadstreet[7].arrive - m_roadstreet[7].output;
					
					if (m_roadstreet[7].stop < 0)
					{
						res.x8 = m_roadstreet[7].arrive/res.t4;
						m_roadstreet[7].stop = 0.0;
					}
					m_roadstreet[7].arrive = m_roadstreet[7].stop;
					
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime );//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[2].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[3].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[4].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[5].arrive += GetInputFlow(forward ,starttime , endtime);
					
					//yellowtime
					starttime = endtime;
					endtime =  endtime+3;
					
					m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
					
					sum4 = m_roadstreet[6].stop + m_roadstreet[7].stop;
					
					sum = sum1+sum2+sum3+sum4;
					
					if(minum>sum)
					{
						double d=0;
						
						for (int j=0;j<8;j++)
						{
						d+=streetstop[j];
						}
                 
						minum = sum;

						t1 = res.t1;
						t2 = res.t2;
						t3 = res.t3;
						t4 = res.t4;
						
						x1 = res.x1;
						x2 = res.x2;
						x3 = res.x3;
						x4 = res.x4;
						x5 = res.x5;
						x6 = res.x6;
						x7 = res.x7;
						x8 = res.x8;
					}
				}
			}
		}
	}
	
	CString smin,st1,st2,st3,st4,sx1,sx2,sx3,sx4,sx5,sx6,sx7,sx8,sn1,sn2,sn3,sn4,sn5,sn6,sn7,sn8;
	
    st1.Format("%f", t1);
	st2.Format("%f", t2);
	st3.Format("%f", t3);
	st4.Format("%f", t4);
	sx1.Format("%f", x1);
	sx2.Format("%f", x2);
	sx3.Format("%f", x3);
	sx4.Format("%f", x4);
	sx5.Format("%f", x5);
	sx6.Format("%f", x6);
	sx7.Format("%f", x7);
	sx8.Format("%f", x8);

	sn1.Format("%d", (int)(x1*t1));
	sn2.Format("%d", (int)(x2*t1));
	sn3.Format("%d", (int)(x3*t2));
	sn4.Format("%d", (int)(x4*t2));
	sn5.Format("%d", (int)(x5*t3));
	sn6.Format("%d", (int)(x6*t3));
	sn7.Format("%d", (int)(x7*t4));
	sn8.Format("%d", (int)(x8*t4));

	smin.Format("%f",minum);

	UpdateData(TRUE);
	
	m_t1=st1;
	m_t2=st2;
	m_t3=st3;
	m_t4=st4;
	
	m_x1=sx1;
	m_x2=sx2;
	m_x3=sx3;
	m_x4=sx4;
	
	m_x5=sx5;
	m_x6=sx6;
	m_x7=sx7;
	m_x8=sx8;

	m_num1=sn1;
	m_num2=sn2;
	m_num3=sn3;
	m_num4=sn4;
	
	m_num5=sn5;
	m_num6=sn6;
	m_num7=sn7;
	m_num8=sn8;

	m_min=smin;
	
	UpdateData(FALSE);
	
	streetstop[0] = m_roadstreet[0].arrive ;//left
	streetstop[1] = m_roadstreet[1].arrive;
	streetstop[4] = m_roadstreet[4].arrive;
	streetstop[5] = m_roadstreet[5].arrive;
	
	streetstop[2] = m_roadstreet[2].arrive;//forward
	streetstop[3] = m_roadstreet[3].arrive;
	streetstop[6] = m_roadstreet[6].arrive;
	streetstop[7] = m_roadstreet[7].arrive;*/
}

void CSerachDlg::NoneFixedCircle()
{
/*	double starttime,endtime,sum,sum1,sum2,sum3,sum4,yellow,diff1,diff2;
	
	double minum=100000000,t1,t2,t3,t4,x1,x2,x3,x4,x5,x6,x7,x8;

	sum = 0.0;
	sum1 = 0.0;
	sum2 = 0.0;
	sum3 = 0.0;
	sum4 = 0.0;
	yellow = 0.0;
	diff1 = 0.0;
	diff2 = 0.0;

	starttime = 0;
	endtime = 0;
		
	CreatePoisson();

	double T=100;
    double r1=0,r2=0,r3=0,r4=0;
    int i=0;

	for (r1=0.1;r1<1;)
	{
		res.t4=T*r1;
		
		for (r2=0.1;r2<1-r1-0.1;)
		{
			res.t3 =(T*r2);

			for (r3=0.1;r3<1-r1-r2-0.1;)
			{
				res.t2 =(T*r3);
				
				r4 = 1-r1-r2-r3;
				res.t1 =(T*r4);
			
				{
					for (int j=0;j<8;j++)
					{
						m_roadstreet[j].arrive=streetstop[j];
						m_roadstreet[j].output=0.0;
						m_roadstreet[j].stop=0.0;
					}
					
					res.x1 =  AverageRandom(0.62,0.64);
					res.x2 =  AverageRandom(0.62,0.64);
					res.x3 =  AverageRandom(0.62,0.64);
					res.x4 =  AverageRandom(0.62,0.64);
					res.x5 =  AverageRandom(0.62,0.64);
					res.x6 =  AverageRandom(0.62,0.64);
					res.x7 =  AverageRandom(0.62,0.64);
					res.x8 =  AverageRandom(0.62,0.64);
					
					///////第一相位
					starttime = 0;
					endtime =  res.t1;
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[0].output = res.x1*res.t1;
					m_roadstreet[0].stop = m_roadstreet[0].arrive - m_roadstreet[0].output;
					
					if (m_roadstreet[0].stop<0)
					{
						res.x1 = m_roadstreet[0].arrive/res.t1;
						m_roadstreet[0].stop = 0;
					}
					
					m_roadstreet[0].arrive = m_roadstreet[0].stop;
					
					m_roadstreet[1].arrive += GetInputFlow(left , starttime ,endtime);
					m_roadstreet[1].output = res.x2*res.t1;
					m_roadstreet[1].stop = m_roadstreet[1].arrive - m_roadstreet[1].output;
					
					if (m_roadstreet[1].stop<0)
					{
						res.x2 = m_roadstreet[1].arrive/res.t1;
						m_roadstreet[1].stop = 0;
					}
					
					m_roadstreet[1].arrive = m_roadstreet[1].stop;
					
					
					m_roadstreet[4].arrive += GetInputFlow(left , starttime , endtime);//left
					m_roadstreet[5].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[2].arrive += GetInputFlow(forward , starttime, endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward , starttime, endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime,endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward , starttime, endtime);
					
					starttime = res.t1;
					endtime = res.t1+3;
					
					//yellowtime
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward , starttime , endtime);
					
					sum1 = m_roadstreet[0].stop + m_roadstreet[1].stop;
					
					///////第二相位
					starttime = res.t1+3;
					endtime =  res.t1+3+res.t2;
					
					m_roadstreet[2].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[2].output = res.x3*res.t2;
					m_roadstreet[2].stop = m_roadstreet[2].arrive - m_roadstreet[2].output;
					
					if (m_roadstreet[2].stop < 0)
					{
						res.x3 = m_roadstreet[2].arrive/res.t2;
						m_roadstreet[2].stop = 0.0;
					}
					m_roadstreet[2].arrive = m_roadstreet[2].stop;
					
					
					m_roadstreet[3].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[3].output = res.x4*res.t2;
					m_roadstreet[3].stop = m_roadstreet[3].arrive - m_roadstreet[3].output;
					
					if (m_roadstreet[3].stop < 0)
					{
						res.x4 = m_roadstreet[3].arrive/res.t2;
						m_roadstreet[3].stop = 0.0;
					}
					m_roadstreet[3].arrive = m_roadstreet[3].stop;
					
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime );//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[7].arrive += GetInputFlow(forward ,starttime , endtime);
					
					//yellowtime
					starttime = res.t1+3+res.t2;
					endtime =  res.t1+3+res.t2+3;
					
					m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
					
					sum2 = m_roadstreet[2].stop + m_roadstreet[3].stop;
					
					
					///////第三相位
					starttime = res.t1+3+res.t2+3;
					endtime =  res.t1+3+res.t2+3+res.t3;
					
					m_roadstreet[4].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[4].output = res.x5*res.t3;
					m_roadstreet[4].stop = m_roadstreet[4].arrive - m_roadstreet[4].output;
					
					if (m_roadstreet[4].stop < 0)
					{
						res.x5 = m_roadstreet[4].arrive/res.t3;
						m_roadstreet[4].stop = 0.0;
					}
					m_roadstreet[4].arrive = m_roadstreet[4].stop;
					
					
					m_roadstreet[5].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[5].output = res.x6*res.t3;
					m_roadstreet[5].stop = m_roadstreet[5].arrive - m_roadstreet[5].output;
					
					if (m_roadstreet[5].stop < 0)
					{
						res.x6 = m_roadstreet[5].arrive/res.t3;
						m_roadstreet[5].stop = 0.0;
					}
					m_roadstreet[5].arrive = m_roadstreet[5].stop;
					
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime );//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[2].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[3].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[7].arrive += GetInputFlow(forward ,starttime , endtime);
					
					//yellowtime
					starttime = endtime;
					endtime =  endtime+3;
					
					m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
					
					sum3 = m_roadstreet[4].stop + m_roadstreet[5].stop;
					
					///////第四相位
					starttime = endtime;
					endtime =  endtime+res.t4;
					
					m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[6].output = res.x7*res.t4;
					m_roadstreet[6].stop = m_roadstreet[6].arrive - m_roadstreet[6].output;
					
					if (m_roadstreet[6].stop < 0)
					{
						res.x7 = m_roadstreet[6].arrive/res.t4;
						m_roadstreet[6].stop = 0.0;
					}
					m_roadstreet[6].arrive = m_roadstreet[6].stop;
					
					
					m_roadstreet[7].arrive += GetInputFlow(forward , starttime , endtime);
					m_roadstreet[7].output = res.x8*res.t4;
					m_roadstreet[7].stop = m_roadstreet[7].arrive - m_roadstreet[7].output;
					
					if (m_roadstreet[7].stop < 0)
					{
						res.x8 = m_roadstreet[7].arrive/res.t4;
						m_roadstreet[7].stop = 0.0;
					}
					m_roadstreet[7].arrive = m_roadstreet[7].stop;
					
					m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime );//left
					m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[2].arrive += GetInputFlow(left , starttime , endtime);
					m_roadstreet[3].arrive += GetInputFlow(left , starttime , endtime);
					
					m_roadstreet[4].arrive += GetInputFlow(forward , starttime , endtime);//forward
					m_roadstreet[5].arrive += GetInputFlow(forward ,starttime , endtime);
					
					//yellowtime
					starttime = endtime;
					endtime =  endtime+3;
					
					m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
					m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
					m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
					
					m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
					m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
					m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
					
					sum4 = m_roadstreet[6].stop + m_roadstreet[7].stop;
					
					sum = sum1+sum2+sum3+sum4;
					
					if(minum>sum)
					{
						double d=0;
						
				
						minum = sum;

						t1 = res.t1;
						t2 = res.t2;
						t3 = res.t3;
						t4 = res.t4;
						
						x1 = res.x1;
						x2 = res.x2;
						x3 = res.x3;
						x4 = res.x4;
						x5 = res.x5;
						x6 = res.x6;
						x7 = res.x7;
						x8 = res.x8;
					}
					 
				}

				 r3+=0.02;
			}

			 r2+=0.02;
		}

		r1+=0.02;
	}
	
	CString smin,st1,st2,st3,st4,sx1,sx2,sx3,sx4,sx5,sx6,sx7,sx8,sn1,sn2,sn3,sn4,sn5,sn6,sn7,sn8;
	
    st1.Format("%f", t1);
	st2.Format("%f", t2);
	st3.Format("%f", t3);
	st4.Format("%f", t4);
	sx1.Format("%f", x1);
	sx2.Format("%f", x2);
	sx3.Format("%f", x3);
	sx4.Format("%f", x4);
	sx5.Format("%f", x5);
	sx6.Format("%f", x6);
	sx7.Format("%f", x7);
	sx8.Format("%f", x8);

	sn1.Format("%d", (int)(x1*t1));
	sn2.Format("%d", (int)(x2*t1));
	sn3.Format("%d", (int)(x3*t2));
	sn4.Format("%d", (int)(x4*t2));
	sn5.Format("%d", (int)(x5*t3));
	sn6.Format("%d", (int)(x6*t3));
	sn7.Format("%d", (int)(x7*t4));
	sn8.Format("%d", (int)(x8*t4));

	smin.Format("%f",minum);

	UpdateData(TRUE);
	
	m_t1=st1;
	m_t2=st2;
	m_t3=st3;
	m_t4=st4;
	
	m_x1=sx1;
	m_x2=sx2;
	m_x3=sx3;
	m_x4=sx4;
	
	m_x5=sx5;
	m_x6=sx6;
	m_x7=sx7;
	m_x8=sx8;

	m_num1=sn1;
	m_num2=sn2;
	m_num3=sn3;
	m_num4=sn4;
	
	m_num5=sn5;
	m_num6=sn6;
	m_num7=sn7;
	m_num8=sn8;

	m_min=smin;
	
	UpdateData(FALSE);
	
	streetstop[0] = m_roadstreet[0].arrive ;//left
	streetstop[1] = m_roadstreet[1].arrive;
	streetstop[4] = m_roadstreet[4].arrive;
	streetstop[5] = m_roadstreet[5].arrive;
	
	streetstop[2] = m_roadstreet[2].arrive;//forward
	streetstop[3] = m_roadstreet[3].arrive;
	streetstop[6] = m_roadstreet[6].arrive;
	streetstop[7] = m_roadstreet[7].arrive;*/
}

void CSerachDlg::yanshi()
{
	double minum=100000000,t1,t2,t3,t4;
	double c=0.0;
	double d , d1 , d2,d3,d4 , p1 , p2 ,p;
	double baohe13 = 0.27;
	double baohe24 = 0.33;
	double li=1.0;

	for (res.t4=10;res.t4<50;res.t4++)
	{
		for (res.t3=10;res.t3<100;res.t3++)
		{
			for (res.t2=10;res.t2<50;res.t2++)
			{
				for (res.t1=10;res.t1<100;res.t1++)
				{
					c = 0.0;
					
					c = res.t1+res.t3+res.t2+res.t4;
					
				
					//int x1 = 48;
					/*double y1 = GetInputFlow(forward , 0 , x1);
					y1  = (y1/x1)/baohe13;
					y1 = y1*0.3;*/
					double y1=0.12;
					
					p1 = (1-4*li/c)*(1-4*li/c);
					
					p2 = 2*4/c;
					
					p = p1/p2;
					
					d1 = (c*(1.0-res.t1/c)*(1.0-res.t1/c))/(2*(1.0-y1)+p);
					
					//int x2 = 25;
					/*double y2 = GetInputFlow(forward , x1+1 , x1+x2+1);
					y2  = (y2/x2)/baohe24;*/
					double y2 = 0.28;
					
					d2 = (c*(1.0-res.t2/c)*(1.0-res.t2/c))/(2*(1.0-y2)+p);
					
					//int x3 = 50;
					/*double y3 = GetInputFlow(forward , x1+x2+1+1 , x1+x2+1+1+x3);
					y3  = (y3/x3)/baohe13;
					y3 = y3*0.3;*/
					double y3 = 0.135;
					
					d3 = (c*(1.0-res.t3/c)*(1.0-res.t3/c))/(2*(1.0-y3)+p);
					
					//int x4=27;
					/*double y4 = GetInputFlow(forward , x1+x2+1+1+x3+1 , x1+1+x2+1+x3+1+x4);
					y4  = (y4/x4)/baohe24;*/
					
					double y4=0.315;
					d4 = (c*(1.0-res.t4/c)*(1.0-res.t4/c))/(2*(1.0-y4)+p);
					
					d = d1+d2+d3+d4;
					
					if(minum>d)
					{
					
						
					/*	for (int j=0;j<8;j++)
						{
						d+=streetstop[j];
						}
                    */
						minum = d;

						t1 = res.t1;
						t2 = res.t2;
						t3 = res.t3;
						t4 = res.t4;
						
					}
				}
			}
		}
	}


	CString smin,st1,st2,st3,st4,sx1,sx2,sx3,sx4,sx5,sx6,sx7,sx8,sn1,sn2,sn3,sn4,sn5,sn6,sn7,sn8;
	
    st1.Format("%f", t1);
	st2.Format("%f", t2);
	st3.Format("%f", t3);
	st4.Format("%f", t4);

	smin.Format("%f",minum);
	
	UpdateData(TRUE);
	
	m_t1=st1;
	m_t2=st2;
	m_t3=st3;
	m_t4=st4;
	
	m_min=smin;
	
	UpdateData(FALSE);
}

double CSerachDlg::StreetStop(double t1, double t2, double t3, double t4,
							  double tA1, double tA2, double tA3, double tA4,
							  double tB1, double tB2, double tB3, double tB4,
							  double tC1, double tC2, double tC3, double tC4,
							  double tD1, double tD2, double tD3, double tD4)
{
	double starttime,endtime,sum,sum1,sum2,sum3,sum4,yellow,diff1,diff2;
	
	double minum=100000000,x1,x2,x3,x4,x5,x6,x7,x8;
	
	sum = 0.0;
	sum1 = 0.0;
	sum2 = 0.0;
	sum3 = 0.0;
	sum4 = 0.0;
	yellow = 0.0;
	diff1 = 0.0;
	diff2 = 0.0;
	
	starttime = 0;
	endtime = 0;
	
	for (int j=0;j<8;j++)
	{
		m_roadstreet[0][j].arrive=streetstop[j];
		m_roadstreet[0][j].output=0.0;
		m_roadstreet[0][j].stop=0.0;
	}

//	CreatePoisson();

	res.x1 =  AverageRandom(2.1,2.3);
	res.x2 =  AverageRandom(2.1,2.3);
	res.x3 =  AverageRandom(2.1,2.3);
	res.x4 =  AverageRandom(2.1,2.3);
	res.x5 =  AverageRandom(2.1,2.3);
	res.x6 =  AverageRandom(2.1,2.3);
	res.x7 =  AverageRandom(2.1,2.3);
	res.x8 =  AverageRandom(2.1,2.3);
	
	///////第一相位
	starttime = 0;
	endtime = t1;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;
	m_roadstreet[0][0].output = res.x1*t1;
	m_roadstreet[0][0].stop = m_roadstreet[0][0].arrive - m_roadstreet[0][0].output;
	
	if (m_roadstreet[0][0].stop<0)
	{
		res.x1 = m_roadstreet[0][0].arrive/t1;
		m_roadstreet[0][0].stop = 0;
	}
	
	m_roadstreet[0][0].arrive = m_roadstreet[0][0].stop;
	
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][1].output = res.x2*t1;
	m_roadstreet[0][1].stop = m_roadstreet[0][1].arrive - m_roadstreet[0][1].output;
	
	if (m_roadstreet[0][1].stop<0)
	{
		res.x2 = m_roadstreet[0][1].arrive/t1;
		m_roadstreet[0][1].stop = 0;
	}
	
	m_roadstreet[0][1].arrive = m_roadstreet[0][1].stop;
	

	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;//forward
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	
	/*starttime = t1;
	endtime = t1+3;
	
	  //yellowtime
	  m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime);//left
	  m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
	  m_roadstreet[4].arrive += GetInputFlow(left , starttime , endtime);
	  m_roadstreet[5].arrive += GetInputFlow(left , starttime , endtime);
	  
		m_roadstreet[2].arrive += GetInputFlow(forward , starttime , endtime);//forward
		m_roadstreet[3].arrive += GetInputFlow(forward , starttime , endtime);
		m_roadstreet[6].arrive += GetInputFlow(forward , starttime , endtime);
		m_roadstreet[7].arrive += GetInputFlow(forward , starttime , endtime);
	*/	
	sum1 = m_roadstreet[0][0].stop + m_roadstreet[0][1].stop;
	
	///////第二相位
	starttime = t1+3;
	endtime =  t1+3+t2;
	
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][2].output = res.x3*t2;
	m_roadstreet[0][2].stop = m_roadstreet[0][2].arrive - m_roadstreet[0][2].output;
	
	if (m_roadstreet[0][2].stop < 0)
	{
		res.x3 = m_roadstreet[0][2].arrive/t2;
		m_roadstreet[0][2].stop = 0.0;
	}
	m_roadstreet[0][2].arrive = m_roadstreet[0][2].stop;
	
	
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][3].output = res.x4*t2;
	m_roadstreet[0][3].stop = m_roadstreet[0][3].arrive - m_roadstreet[0][3].output;
	
	if (m_roadstreet[0][3].stop < 0)
	{
		res.x4 = m_roadstreet[0][3].arrive/t2;
		m_roadstreet[0][3].stop = 0.0;
	}
	m_roadstreet[0][3].arrive = m_roadstreet[0][3].stop;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	
	//yellowtime
/*	starttime = res.t1+3+res.t2;
	endtime =  res.t1+3+res.t2+3;
	
	m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
	m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
	
	m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
	m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
*/	
	sum2 = m_roadstreet[0][2].stop + m_roadstreet[0][3].stop;
	
	
	///////第三相位
	starttime = t1+3+t2+3;
	endtime =  t1+3+t2+3+t3;
	
	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68 ;//left
	m_roadstreet[0][4].output = res.x5*t3;
	m_roadstreet[0][4].stop = m_roadstreet[0][4].arrive - m_roadstreet[0][4].output;
	
	if (m_roadstreet[0][4].stop < 0)
	{
		res.x5 = m_roadstreet[0][4].arrive/t3;
		m_roadstreet[0][4].stop = 0.0;
	}
	m_roadstreet[0][4].arrive = m_roadstreet[0][4].stop;
	
	
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	m_roadstreet[0][5].output = res.x6*t3;
	m_roadstreet[0][5].stop = m_roadstreet[0][5].arrive - m_roadstreet[0][5].output;
	
	if (m_roadstreet[0][5].stop < 0)
	{
		res.x6 = m_roadstreet[0][5].arrive/t3;
		m_roadstreet[0][5].stop = 0.0;
	}
	m_roadstreet[0][5].arrive = m_roadstreet[0][5].stop;
	
    m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;//forward
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	
	//yellowtime
/*	starttime = endtime;
	endtime =  endtime+3;
	
	m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
	m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
	
	m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
	m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
	*/
	sum3 = m_roadstreet[0][4].stop + m_roadstreet[0][5].stop;
	
	///////第四相位
	starttime = endtime;
	endtime =  endtime+t4;
	
	m_roadstreet[0][6].arrive += tC2*0.5*0.68+tC1*0.5*0.68;
	m_roadstreet[0][6].output = res.x7*t4;
	m_roadstreet[0][6].stop = m_roadstreet[0][6].arrive - m_roadstreet[0][6].output;
	
	if (m_roadstreet[0][6].stop < 0)
	{
		res.x7 = m_roadstreet[0][6].arrive/t4;
		m_roadstreet[0][6].stop = 0.0;
	}
	m_roadstreet[0][6].arrive = m_roadstreet[0][6].stop;
	
	m_roadstreet[0][7].arrive += tD2*0.5*0.69+tD1*0.5*0.69;
	m_roadstreet[0][7].output = res.x8*t4;
	m_roadstreet[0][7].stop = m_roadstreet[0][7].arrive - m_roadstreet[0][7].output;
	
	if (m_roadstreet[0][7].stop < 0)
	{
		res.x8 = m_roadstreet[0][7].arrive/t4;
		m_roadstreet[0][7].stop = 0.0;
	}
	m_roadstreet[0][7].arrive = m_roadstreet[0][7].stop;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][4].arrive += tC2*0.2*0.68+tC1*0.2*0.68;//left
	m_roadstreet[0][5].arrive += tD2*0.2*0.69+tD1*0.2*0.69;
	
	//yellowtime
	/*	starttime = endtime;
	endtime =  endtime+3;
	
	m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
	m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[4].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[5].arrive += GetInputFlow(left ,  starttime , endtime);
	
	m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
	m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[7].arrive += GetInputFlow(forward ,  starttime , endtime);
*/	
	sum4 = m_roadstreet[0][6].stop + m_roadstreet[0][7].stop;
	
	sum = sum1+sum2+sum3+sum4;

	return sum;
}

void CSerachDlg::NetWorkRoad()
{
	    double t1=22, double t2=41, double t3=34, double t4=23,
		double tA1=22, double tA2=58, double tA3=19, double tA4=21,
		double tB1=14, double tB2=50, double tB3=24, double tB4=32,
		double tC1=29, double tC2=32, double tC3=25, double tC4=34,
		double tD1=20, double tD2=40, double tD3=29, double tD4=31;

		double sum=0;

		double minum=10000;
	
		for (t1=mt1;t1<mt1+3;t1++)
		{
			for (t2=mt2; t2<mt2+3; t2++)
			{
				for (t3=mt3;t3<mt3+2;t3++)
				{
					t4 = 120-t3-t2-t1;
					
					for (tA1=mtA1;tA1<mtA1+4;tA1++)
					{
						for (tA2=mtA2; tA2<mtA2+4;tA2++)
						{
							for (tA3=mtA3;tA3<mtA3+4;tA3++)
							{
								tA4 = 120-tA3-tA2-tA1;
								
								for (tB1=mtB1-2;tB1<mtB1+2;tB1++)
								{
									for (tB2=mtB2-2; tB2<mtB2+2;tB2++)
									{
										for (tB3=mtB3-2;tB3<mtB3+2;tB3++)
										{
											tB4 = 120-tB3-tB2-tB1;
											
										 /*   for (tC1=mtC1-2;tC1<mtC1+2;tC1++)
											{
											//	for (tC2=mtC2; tC2<mtC2+1;tC2++)
											//	{
											//		for (tC3=mtC3-2;tC3<mtC3+2;tC3++)
											//		{
														tC4 = 120-tC3-tC2-tC1;
														
												//		for (tD1=mtD1-2;tD1<mtD1+2;tD1++)
												//		{
															for (tD2=mtD2-2; tD2<mtD2+2;tD2++)
															{
																for (tD3=mtD3-2;tD3<mtD3+2;tD3++)
																{
																	tD4 = 120-tD3-tD2-tD1;
															*/		
																	sum =LineStop(t1, t2, t3, t4, 
																		tA1,  tA2,  tA3,  tA4,
																		tB1,  tB2,  tB3,  tB4 
																	//	tC1,  tC2,  tC3,  tC4,
																	//	tD1,  tD2,  tD3,  tD4
																	);
																	
																	if(minum>sum)
																	{
																		minum = sum;
																		
																		rt1 = t1;
																		rt2 = t2;
																		rt3 = t3;
																		rt4 = t4;
																		rtA1 = tA1;
																		rtA2 = tA2;
																		rtA3 = tA3;
																		rtA4 = tA4;
																		rtB1 = tB1;
																		rtB2 = tB2; 
																		rtB3 = tB3;
																		rtB4 = tB4;
																	/*	rtC1 = tC1;
																		rtC2 = tC2;
																		rtC3 = tC3;
																		rtC4 = tC4;
																		rtD1 = tD1;
																		rtD2 = tD2;
																		rtD3 = tD3;
																		rtD4 = tD4;*/
																	}
																}
															}//2
													//	}
												//	}
											//	}//5
											}
										}
									}
							//	}
						//	}//10
						}
					}
				//}
			}
		}//15
		
		CString smin,st1,st2,st3,st4,sx1,sx2,sx3,sx4,sx5,sx6,sx7,sx8,sx11,sx12,sx13,sx14,sx15,sx16,sx17,sx18,sn1,sn2,sn3,sn4,sn5,sn6,sn7,sn8;
		
		st1.Format("%f", t1);
		st2.Format("%f", t2);
		st3.Format("%f", t3);
		st4.Format("%f", t4);
		sx1.Format("%f", tA1);
		sx2.Format("%f", tA2);
		sx3.Format("%f", tA3);
		sx4.Format("%f", tA4);
		sx5.Format("%f", tB1);
		sx6.Format("%f", tB2);
		sx7.Format("%f", tB3);
		sx8.Format("%f", tB4);
	/*	sx11.Format("%f", tC1);
		sx12.Format("%f", tC2);
		sx13.Format("%f", tC3);
		sx14.Format("%f", tC4);
		sx15.Format("%f", tD1);
		sx16.Format("%f", tD2);
		sx17.Format("%f", tD3);
		sx18.Format("%f", tD4);
	*/	
		smin.Format("%f",minum);
		
		UpdateData(TRUE);
		
		m_t1=st1;
		m_t2=st2;
		m_t3=st3;
		m_t4=st4;
		
		m_ta1=sx1;
		m_ta2=sx2;
		m_ta3=sx3;
		m_ta4=sx4;
		
		m_tb1=sx5;
		m_tb2=sx6;
		m_tb3=sx7;
		m_tb4=sx8;
		
	/*	m_tc1=sx11;
		m_tc2=sx12;
		m_tc3=sx13;
		m_tc4=sx14;
		
		m_td1=sx15;
		m_td2=sx16;
		m_td3=sx17;
		m_td4=sx18;*/
		
		m_min=smin;
		
	    UpdateData(FALSE);

		streetstop[0] = m_roadstreet[0][0].arrive ;//left
		streetstop[1] = m_roadstreet[0][1].arrive;
		streetstop[4] = m_roadstreet[0][4].arrive;
		streetstop[5] = m_roadstreet[0][5].arrive;
		
		streetstop[2] = m_roadstreet[0][2].arrive;//forward
		streetstop[3] = m_roadstreet[0][3].arrive;
		streetstop[6] = m_roadstreet[0][6].arrive;
		streetstop[7] = m_roadstreet[0][7].arrive;
		
		CanculateA1(tA1,tA2,tA3,tA4);
		CanculateA2(tB1,tB2,tB3,tB4);
}

void CSerachDlg::CreatePop(int num)
{

	for (int i=0;i<num;i++)
	{
		population[i].t4=0;
        population[i].tA4=0;
		population[i].tB4=0;

		while(population[i].t4 < 30)
		{
		population[i].t1 =  AverageRandom(15,30);
		population[i].t2 =  AverageRandom(30,45);
		population[i].t3 =  AverageRandom(10,40);
		population[i].t4 =  120-population[i].t1-population[i].t2-population[i].t3;
		}

		while(population[i].tA4 < 30)
		{
		population[i].tA1 = AverageRandom(10,30);
		population[i].tA2 = AverageRandom(40,70);
		population[i].tA3 = AverageRandom(15,30);
		population[i].tA4 = 120 - population[i].tA1-population[i].tA2-population[i].tA3;
		}

		while(population[i].tB4 < 30)
		{
		population[i].tB1 = AverageRandom(10,30);
		population[i].tB2 = AverageRandom(30,60);
		population[i].tB3 = AverageRandom(10,40);
		population[i].tB4 = 120 - population[i].tB1-population[i].tB2-population[i].tB3;
		}

	/*	while(population[i].tC4 < 20)
		{
		population[i].tC1 = AverageRandom(20,40);
		population[i].tC2 = AverageRandom(20,40);
		population[i].tC3 = AverageRandom(20,40);
		population[i].tC4 = 120 - population[i].tC1-population[i].tC2-population[i].tC3;
		}
		
		while(population[i].tD4 < 20)
		{
		population[i].tD1 = AverageRandom(20,45);
		population[i].tD2 = AverageRandom(20,45);
		population[i].tD3 = AverageRandom(20,45);
		population[i].tD4 = 120 - population[i].tD1-population[i].tD2-population[i].tD3;
	
		}*/
	}
}

void CSerachDlg::OnButton1() 
{
	double t1=22, double t2=41, double t3=34, double t4=23,
	double tA1=22, double tA2=58, double tA3=19, double tA4=21,
	double tB1=14, double tB2=50, double tB3=24, double tB4=32,
	double tC1=29, double tC2=32, double tC3=25, double tC4=34,
	double tD1=20, double tD2=40, double tD3=29, double tD4=31;

	double sum=0;

	CreatePop(2000);
	
	double minum=1000000;
	
	for (int i=0;i<2000;i++)
	{
		t1=population[i].t1 ;
		t2=population[i].t2 ;
		t3=population[i].t3 ;
		t4=population[i].t4 ;
		tA1=population[i].tA1 ;
		tA2=population[i].tA2 ;
		tA3=population[i].tA3 ;
		tA4=population[i].tA4 ;
		tB1=population[i].tB1 ;
		tB2=population[i].tB2 ;
		tB3=population[i].tB3 ;
		tB4=population[i].tB4 ;
	/*	tC1=population[i].tC1 ;
		tC2=population[i].tC2 ;
		tC3=population[i].tC3;
		tC4=population[i].tC4 ;
		tD1=population[i].tD1 ;
		tD2=population[i].tD2 ;
		tD3=population[i].tD3 ;
		tD4=population[i].tD4 ;*/
		
	//	sum = StreetStop(t1, t2, t3, t4, tA1,  tA2,  tA3,  tA4,
	//		tB1, tB2,  tB3,  tB4, tC1,  tC2,  tC3,  tC4,tD1, tD2,  tD3, tD4);

		sum = LineStop(t1, t2, t3, t4, tA1,  tA2,  tA3,  tA4,
	              		tB1, tB2,  tB3,  tB4);
		
		if(minum>=sum){
			minum=sum;
			mt1=population[i].t1 ;
			mt2=population[i].t2 ;
			mt3=population[i].t3 ;
			mt4=population[i].t4 ;
			mtA1=population[i].tA1 ;
			mtA2=population[i].tA2 ;
			mtA3=population[i].tA3 ;
			mtA4=population[i].tA4 ;
			mtB1=population[i].tB1 ;
			mtB2=population[i].tB2 ;
			mtB3=population[i].tB3 ;
			mtB4=population[i].tB4 ;
		/*	mtC1=population[i].tC1 ;
			mtC2=population[i].tC2 ;
			mtC3=population[i].tC3;
			mtC4=population[i].tC4 ;
			mtD1=population[i].tD1 ;
			mtD2=population[i].tD2 ;
			mtD3=population[i].tD3 ;
			mtD4=population[i].tD4 ;*/
		}
	}
	
		double nn=minum;
}

void CSerachDlg::CanculateA1(double tA1,double tA2,double tA3,double tA4)
{
	CreatePoisson();

	//1
	double starttime = 0;
	double endtime =  tA1;

	m_roadstreet[1][2].arrive +=  GetInputFlow(left , starttime , endtime);
	m_roadstreet[1][5].arrive +=  GetInputFlow(forward , starttime , endtime);
	
	//2
	starttime = tA1;
	endtime =  endtime+tA2;
	
	m_roadstreet[1][5].arrive += GetInputFlow(forward , starttime , endtime);
	m_roadstreet[1][5].output = 0.651*tA2;
	m_roadstreet[1][5].stop = m_roadstreet[1][5].arrive - m_roadstreet[1][5].output;
	
	if (m_roadstreet[1][5].stop < 0)
	{
		//res.x7 = m_roadstreet[6].arrive/res.t4;
		m_roadstreet[1][5].stop = 0.0;
	}
	m_roadstreet[1][5].arrive = m_roadstreet[1][5].stop;
	
	m_roadstreet[1][2].arrive +=  GetInputFlow(left , starttime , endtime);
	
	//3
	starttime = endtime;
	endtime =  endtime+tA3;

	m_roadstreet[1][2].arrive += GetInputFlow(left , starttime , endtime);
	m_roadstreet[1][2].output = 0.65*tA3;
	m_roadstreet[1][2].stop = m_roadstreet[1][2].arrive - m_roadstreet[1][2].output;
	
	if (m_roadstreet[1][2].stop < 0)
	{
		//res.x8 = m_roadstreet[7].arrive/res.t4;
		m_roadstreet[1][2].stop = 0.0;
	}
	m_roadstreet[1][2].arrive = m_roadstreet[1][2].stop;

	m_roadstreet[1][5].arrive +=  GetInputFlow(forward , starttime , endtime);
	
	//4
	starttime = endtime;
	endtime =  endtime+tA4 ;
	
	m_roadstreet[1][2].arrive +=  GetInputFlow(left , starttime , endtime);
	m_roadstreet[1][5].arrive +=  GetInputFlow(forward , starttime , endtime);

	CString str;
	str.Format("left:%f,forward:%f",m_roadstreet[1][2].stop,m_roadstreet[1][5].stop);
	
    MessageBox(str);

}

void CSerachDlg::CanculateA2(double tB1,double tB2,double tB3,double tB4)
{
	CreatePoisson();
	
	//1
	double starttime = 0;
	double endtime =  tB1;
	
	m_roadstreet[2][1].arrive +=  GetInputFlow(left , starttime , endtime);
	m_roadstreet[2][6].arrive +=  GetInputFlow(forward , starttime , endtime);
	
	//2
	starttime = tB1;
	endtime =  endtime+tB2;
	
	m_roadstreet[2][1].arrive += GetInputFlow(forward , starttime , endtime);
	m_roadstreet[2][1].output = 0.651*tB2;
	m_roadstreet[2][1].stop = m_roadstreet[2][1].arrive - m_roadstreet[2][1].output;
	
	if (m_roadstreet[2][1].stop < 0)
	{
		//res.x7 = m_roadstreet[6].arrive/res.t4;
		m_roadstreet[2][1].stop = 0.0;
	}
	m_roadstreet[2][1].arrive = m_roadstreet[2][1].stop;
	
	m_roadstreet[2][6].arrive +=  GetInputFlow(left , starttime , endtime);
	
	//3
	starttime = endtime;
	endtime =  endtime+tB3;
	
	m_roadstreet[2][6].arrive += GetInputFlow(left , starttime , endtime);
	m_roadstreet[2][6].output = 0.65*tB3;
	m_roadstreet[2][6].stop = m_roadstreet[2][6].arrive - m_roadstreet[2][6].output;
	
	if (m_roadstreet[2][6].stop < 0)
	{
		//res.x8 = m_roadstreet[7].arrive/res.t4;
		m_roadstreet[2][6].stop = 0.0;
	}
	m_roadstreet[2][6].arrive = m_roadstreet[2][6].stop;
	
	m_roadstreet[2][1].arrive +=  GetInputFlow(forward , starttime , endtime);
	
	//4
	starttime = endtime;
	endtime =  endtime+tB4 ;
	
	m_roadstreet[2][6].arrive +=  GetInputFlow(left , starttime , endtime);
	m_roadstreet[2][1].arrive +=  GetInputFlow(forward , starttime , endtime);

    CString str;
	str.Format("left:%f,forward:%f",m_roadstreet[2][6].stop,m_roadstreet[2][1].stop);

    MessageBox(str);
}

void CSerachDlg::CanculateA4()
{

}

void CSerachDlg::CanculateA3()
{

}

double CSerachDlg::LineStop(double t1, double t2, double t3, double t4,
							double tA1, double tA2, double tA3, double tA4,
							  double tB1, double tB2, double tB3, double tB4)
{
	double starttime,endtime,sum,sum1,sum2,sum3,sum4,yellow,diff1,diff2;
	
	double minum=100000000,x1,x2,x3,x4,x5,x6,x7,x8;
	
	sum = 0.0;
	sum1 = 0.0;
	sum2 = 0.0;
	sum3 = 0.0;
	sum4 = 0.0;
	yellow = 0.0;
	diff1 = 0.0;
	diff2 = 0.0;
	
	starttime = 0;
	endtime = 0;
	
	for (int j=0;j<8;j++)
	{
		m_roadstreet[0][j].arrive=streetstop[j];
		m_roadstreet[0][j].output=0.0;
		m_roadstreet[0][j].stop=0.0;
	}

//	CreatePoisson();

	double sd = 0.65;
	double sd1 = 1.26;
	res.x1 =  AverageRandom(sd1,sd1+0.02);
	res.x2 =  AverageRandom(sd1,sd1+0.02);
	res.x3 =  AverageRandom(sd1,sd1+0.02);
	res.x4 =  AverageRandom(sd1,sd1+0.02);
	res.x5 =  AverageRandom(sd,sd+0.01);
	res.x6 =  AverageRandom(sd,sd+0.01);
	res.x7 =  AverageRandom(sd,sd+0.01);
	res.x8 =  AverageRandom(sd,sd+0.01);
	
	///////第一相位
	starttime = 0;
	endtime = t1;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;
	m_roadstreet[0][0].output = res.x1*t1;
	m_roadstreet[0][0].stop = m_roadstreet[0][0].arrive - m_roadstreet[0][0].output;
	
	if (m_roadstreet[0][0].stop<0)
	{
		res.x1 = m_roadstreet[0][0].arrive/t1;
		m_roadstreet[0][0].stop = 0;
	}
	
	m_roadstreet[0][0].arrive = m_roadstreet[0][0].stop;
	
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][1].output = res.x2*t1;
	m_roadstreet[0][1].stop = m_roadstreet[0][1].arrive - m_roadstreet[0][1].output;
	
	if (m_roadstreet[0][1].stop<0)
	{
		res.x2 = m_roadstreet[0][1].arrive/t1;
		m_roadstreet[0][1].stop = 0;
	}
	
	m_roadstreet[0][1].arrive = m_roadstreet[0][1].stop;
	

	m_roadstreet[0][4].arrive += GetInputFlow(left , starttime , endtime) ;//left
	m_roadstreet[0][5].arrive += GetInputFlow(left , starttime , endtime);
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][6].arrive += GetInputFlow(forward , starttime , endtime);//forward
	m_roadstreet[0][7].arrive += GetInputFlow(forward , starttime , endtime);
	
	starttime = t1;
	endtime = t1+3;
	
	  //yellowtime
	//  m_roadstreet[0].arrive += GetInputFlow(left , starttime , endtime);//left
	 // m_roadstreet[1].arrive += GetInputFlow(left , starttime , endtime);
	  m_roadstreet[0][4].arrive += GetInputFlow(left , starttime , endtime);
	  m_roadstreet[0][5].arrive += GetInputFlow(left , starttime , endtime);
	  
	//	m_roadstreet[2].arrive += GetInputFlow(forward , starttime , endtime);//forward
	//	m_roadstreet[3].arrive += GetInputFlow(forward , starttime , endtime);
		m_roadstreet[0][6].arrive += GetInputFlow(forward , starttime , endtime);
		m_roadstreet[0][7].arrive += GetInputFlow(forward , starttime , endtime);
		
	sum1 = m_roadstreet[0][0].stop + m_roadstreet[0][1].stop;
	
	///////第二相位
	starttime = t1+3;
	endtime =  t1+3+t2;
	
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][2].output = res.x3*t2;
	m_roadstreet[0][2].stop = m_roadstreet[0][2].arrive - m_roadstreet[0][2].output;
	
	if (m_roadstreet[0][2].stop < 0)
	{
		res.x3 = m_roadstreet[0][2].arrive/t2;
		m_roadstreet[0][2].stop = 0.0;
	}
	m_roadstreet[0][2].arrive = m_roadstreet[0][2].stop;
	
	
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][3].output = res.x4*t2;
	m_roadstreet[0][3].stop = m_roadstreet[0][3].arrive - m_roadstreet[0][3].output;
	
	if (m_roadstreet[0][3].stop < 0)
	{
		res.x4 = m_roadstreet[0][3].arrive/t2;
		m_roadstreet[0][3].stop = 0.0;
	}
	m_roadstreet[0][3].arrive = m_roadstreet[0][3].stop;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][4].arrive += GetInputFlow(left ,  starttime , endtime) ;//left
	m_roadstreet[0][5].arrive += GetInputFlow(left ,  starttime , endtime);;
	m_roadstreet[0][6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][7].arrive += GetInputFlow(forward ,  starttime , endtime);
	
	//yellowtime
	starttime = res.t1+3+res.t2;
	endtime =  res.t1+3+res.t2+3;
	
	//m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
	//m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[0][4].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[0][5].arrive += GetInputFlow(left ,  starttime , endtime);
	
	//m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
	//m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][7].arrive += GetInputFlow(forward ,  starttime , endtime);
	
	sum2 = m_roadstreet[0][2].stop + m_roadstreet[0][3].stop;
	
	
	///////第三相位
	starttime = t1+3+t2+3;
	endtime =  t1+3+t2+3+t3;
	
	m_roadstreet[0][4].arrive += GetInputFlow(left ,  starttime , endtime);//left
	m_roadstreet[0][4].output = res.x5*t3;
	m_roadstreet[0][4].stop = m_roadstreet[0][4].arrive - m_roadstreet[0][4].output;
	
	if (m_roadstreet[0][4].stop < 0)
	{
		res.x5 = m_roadstreet[0][4].arrive/t3;
		m_roadstreet[0][4].stop = 0.0;
	}
	m_roadstreet[0][4].arrive = m_roadstreet[0][4].stop;
	
	
	m_roadstreet[0][5].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[0][5].output = res.x6*t3;
	m_roadstreet[0][5].stop = m_roadstreet[0][5].arrive - m_roadstreet[0][5].output;
	
	if (m_roadstreet[0][5].stop < 0)
	{
		res.x6 = m_roadstreet[0][5].arrive/t3;
		m_roadstreet[0][5].stop = 0.0;
	}
	m_roadstreet[0][5].arrive = m_roadstreet[0][5].stop;
	
    m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;//forward
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][7].arrive += GetInputFlow(forward ,  starttime , endtime);
	
	//yellowtime
	starttime = endtime;
	endtime =  endtime+3;
	
	//m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
	//m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[0][4].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[0][5].arrive += GetInputFlow(left ,  starttime , endtime);
	
	//m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
	//m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][7].arrive += GetInputFlow(forward ,  starttime , endtime);
	
	sum3 = m_roadstreet[0][4].stop + m_roadstreet[0][5].stop;
	
	///////第四相位
	starttime = endtime;
	endtime =  endtime+t4;
	
	m_roadstreet[0][6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][6].output = res.x7*t4;
	m_roadstreet[0][6].stop = m_roadstreet[0][6].arrive - m_roadstreet[0][6].output;
	
	if (m_roadstreet[0][6].stop < 0)
	{
		res.x7 = m_roadstreet[0][6].arrive/t4;
		m_roadstreet[0][6].stop = 0.0;
	}
	m_roadstreet[0][6].arrive = m_roadstreet[0][6].stop;
	
	m_roadstreet[0][7].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][7].output = res.x8*t4;
	m_roadstreet[0][7].stop = m_roadstreet[0][7].arrive - m_roadstreet[0][7].output;
	
	if (m_roadstreet[0][7].stop < 0)
	{
		res.x8 = m_roadstreet[0][7].arrive/t4;
		m_roadstreet[0][7].stop = 0.0;
	}
	m_roadstreet[0][7].arrive = m_roadstreet[0][7].stop;
	
	m_roadstreet[0][0].arrive += tB4*0.2*0.651+tB3*0.2*0.651;//left
	m_roadstreet[0][1].arrive += tA4*0.2*0.65+tA3*0.2*0.65;
	m_roadstreet[0][2].arrive += tB4*0.5*0.651+tB3*0.5*0.651;
	m_roadstreet[0][3].arrive += tA4*0.5*0.65+tA3*0.5*0.65;
	m_roadstreet[0][4].arrive += GetInputFlow(left ,  starttime , endtime);//left
	m_roadstreet[0][5].arrive += GetInputFlow(left ,  starttime , endtime);
	
	//yellowtime
	starttime = endtime;
	endtime =  endtime+3;
	
//	m_roadstreet[0].arrive += GetInputFlow(left ,  starttime , endtime);//left
//	m_roadstreet[1].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[0][4].arrive += GetInputFlow(left ,  starttime , endtime);
	m_roadstreet[0][5].arrive += GetInputFlow(left ,  starttime , endtime);
	
//	m_roadstreet[2].arrive += GetInputFlow(forward ,  starttime , endtime);//forward
//	m_roadstreet[3].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][6].arrive += GetInputFlow(forward ,  starttime , endtime);
	m_roadstreet[0][7].arrive += GetInputFlow(forward ,  starttime , endtime);
	
	sum4 = m_roadstreet[0][6].stop + m_roadstreet[0][7].stop;
	
	sum = sum1+sum2+sum3+sum4;

	return sum;
}

void CSerachDlg::OnButton2() 
{
	// TODO: Add your control notification handler code here
	
}
