// SearchCycleDlg.h : header file
//

#if !defined(AFX_SEARCHCYCLEDLG_H__1F5DE185_8679_43AD_BD1A_EDB0B53379FC__INCLUDED_)
#define AFX_SEARCHCYCLEDLG_H__1F5DE185_8679_43AD_BD1A_EDB0B53379FC__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define POPSIZE 500
const int chormlength = 4;
const double li = 1.0; 
const int m_count = 250;
static int forward[250];
const double m_sum = 10000;

const double m_cycle = 100.0;
/////////////////////////////////////////////////////////////////////////////
// CSearchCycleDlg dialog

class CSearchCycleDlg : public CDialog
{
// Construction
private:
	
	void CrossoverOperatorCycle();
	void OutputTextReportCycle();
	void MutationOperatorCycle();
	void GenerateNextPopulationCycle();
	void GenerateInitialPopulationCycle();
	void CalculateObjectValueCycle();
	void EvaluatePopulationCycle();
	int GetValue(int forward[] , int i);
	double AverageRandom(double min,double max);
	void CreatePoisson();
	void OutputTextReport();
	void MutationOperator();
	void CrossoverOperator();
	void SelectOperator();
	void PerformeVolution();
	void FindBestAndWorstIndividual();
	void CalculateFitnessValue();
	void CalculateObjectValue();
	void EvaluatePopulation();
	void GenerateNextPopulation();
	void GenerateInitialPopulation();
	int GetXulie(double *pdata, int n , double value);
	int jiecheng(int value);
	double GetInputFlow(int forward[] , int start , int end);
public:
	void OutputTxtFile(int forward[], CString path , int count);
	CSearchCycleDlg(CWnd* pParent = NULL);	// standard constructor



	double pc;          //交叉率
	double pm;          //变异率
	double avgfitness;  //平均适应度值
	
	struct individual
	{
		double  chrom[chormlength+1];
		double value;         
		double fitness;//适应度
		double mdata[4];
		double y[4];
	};
	
	double GetObjectValue(struct individual tempindividual);

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

// Dialog Data
	//{{AFX_DATA(CSearchCycleDlg)
	enum { IDD = IDD_SEARCHCYCLE_DIALOG };
	CProgressCtrl	m_progress;
	double	m_mincycle;
	double	m_x1;
	double	m_x2;
	double	m_x3;
	double	m_x4;
	int		m_maxgeneration;
	int		m_popsize;
	int		m_maxgenindex;
	int		m_maxindex;
	double	m_d;
	double	m_h;
	double	m_q;
	double	m_y;
	double	m_y1;
	double	m_y2;
	double	m_y3;
	double	m_y4;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSearchCycleDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CSearchCycleDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonStart();
	virtual void OnOK();
	afx_msg void OnButtonCycle();
	afx_msg void OnButtonTime();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SEARCHCYCLEDLG_H__1F5DE185_8679_43AD_BD1A_EDB0B53379FC__INCLUDED_)
