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
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CSerachDlg, CDialog)
	//{{AFX_MSG_MAP(CSerachDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_START, OnButtonStart)
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

	 GudingPeishi();

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
	double lamuda = 0.14;
	
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
	lamuda = 0.05;
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
	double starttime,endtime,sum,sum1,sum2,sum3,sum4,yellow,diff1,diff2;
	
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
						
					/*	for (int j=0;j<8;j++)
						{
						d+=streetstop[j];
						}
                    */
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
	streetstop[7] = m_roadstreet[7].arrive;
}

void CSerachDlg::NoneFixedCircle()
{
	double starttime,endtime,sum,sum1,sum2,sum3,sum4,yellow,diff1,diff2;
	
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
						
					/*	for (int j=0;j<8;j++)
						{
						d+=streetstop[j];
						}
                    */
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
	streetstop[7] = m_roadstreet[7].arrive;
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

void CSerachDlg::GudingPeishi()
{
	double starttime,endtime,sum,sum1,sum2,sum3,sum4,yellow,diff1,diff2;
	
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

	res.t1 = 29;
	res.t2 = 17;
    res.t3 = 30;
	res.t4 = 15;


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
						
					/*	for (int j=0;j<8;j++)
						{
						d+=streetstop[j];
						}
                    */
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
	streetstop[7] = m_roadstreet[7].arrive;
}
