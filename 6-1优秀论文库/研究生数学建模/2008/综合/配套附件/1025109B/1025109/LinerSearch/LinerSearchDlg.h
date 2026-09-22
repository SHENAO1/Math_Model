// LinerSearchDlg.h : header file
//

#if !defined(AFX_LINERSEARCHDLG_H__75C759AF_C8ED_4EAC_8DD8_A80D2347387E__INCLUDED_)
#define AFX_LINERSEARCHDLG_H__75C759AF_C8ED_4EAC_8DD8_A80D2347387E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define POPSIZE 500
const int chormlength = 8;
const double li = 1.0; 
const int m_count = 250;
static int forward[250];
const int m_sum = 10000; 

/////////////////////////////////////////////////////////////////////////////
// CLinerSearchDlg dialog

class CLinerSearchDlg : public CDialog
{
// Construction
private:
	void CrossoverOperatorCycle();
	void MakeSureCycle();
	void OutputTextReportCycle();
	void MutationOperatorCycle();
	void GenerateNextPopulationCycle();
	void GenerateInitialPopulationCycle();
	void CalculateObjectValueCycle();
	void EvaluatePopulationCycle();
	int GetValue(int forward[] , int i);
	double AverageRandom(double min,double max);
	void CreatePoisson(double d);
	void SelectOperator();
	void PerformeVolution();
	void FindBestAndWorstIndividual();
	int GetXulie(double *pdata, int n , double value);
	int jiecheng(int value);
public:
	
	CLinerSearchDlg(CWnd* pParent = NULL);
	
	double cycle;        //固定周期

	double pc;          //交叉率
	double pm;          //变异率
	double avgfitness;  //平均适应度值
	
	struct individual
	{
		double  chrom[chormlength+1];
		double value;         
		double fitness;//适应度
		double mdata[3];
		double y[8];
	};
	double GetObjectValue(individual tempindividual);

	int generation;      //世代数
	int best_index;
	int worst_index;
	int maxindex; //最优个体在种群中的序号
	
	struct individual maxindexindividual; //最早的最佳个体
	struct individual bestindividual;  //最佳个体
	struct individual worstindividual; //最差个体
	struct individual currentbest;
	struct individual population[POPSIZE];
	struct individual fatherbestindividual;//父代最佳个体

	// standard constructor

// Dialog Data
	//{{AFX_DATA(CLinerSearchDlg)
	enum { IDD = IDD_LINERSEARCH_DIALOG };
	CProgressCtrl	m_progress;
	double	m_h;
	int		m_maxgenindex;
	int		m_maxindex;
	double	m_min;
	int		m_popsize;
	double	m_sumtime1;
	double	m_sumtime2;
	double	m_t1;
	double	m_t2;
	double	m_t3;
	double	m_t4;
	double	m_t5;
	double	m_t6;
	double	m_t7;
	double	m_t8;
	double	m_y1;
	double	m_y2;
	double	m_y3;
	double	m_y4;
	double	m_y5;
	double	m_y6;
	double	m_y7;
	double	m_y8;
	int		m_maxgeneration;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLinerSearchDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CLinerSearchDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonStart();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LINERSEARCHDLG_H__75C759AF_C8ED_4EAC_8DD8_A80D2347387E__INCLUDED_)
