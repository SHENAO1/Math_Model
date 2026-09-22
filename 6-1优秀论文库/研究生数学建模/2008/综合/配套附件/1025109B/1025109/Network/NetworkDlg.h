// NetworkDlg.h : header file
//

#if !defined(AFX_NETWORKDLG_H__2148FE33_D704_47E7_AA5B_006A8A2F2B81__INCLUDED_)
#define AFX_NETWORKDLG_H__2148FE33_D704_47E7_AA5B_006A8A2F2B81__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define POPSIZE 1000
const int chormlength = 20;
const int cycle = 120; 
const double li = 1.0; 
static int forward[250];
/////////////////////////////////////////////////////////////////////////////
// CNetworkDlg dialog
#include "Road.h"
class CNetworkDlg : public CDialog
{
// Construction
private:
	int GetInputFlow(int *forward , int start , int end);
	
	double GetMutationValue(int pos , int i);
	void CreatePoisson(double lamuda);
	void CrossoverOperatorCycle();
	void OutputTextReportCycle();
	void MutationOperatorCycle();
	void GenerateNextPopulationCycle();
	void GenerateInitialPopulationCycle();
	void CalculateObjectValueCycle();
	void EvaluatePopulationCycle();
	double AverageRandom(double min,double max);
	void SelectOperator();
	void PerformeVolution();
	void FindBestAndWorstIndividual();
	int GetXulie(double *pdata, int n , double value);
	int jiecheng(int value);

public:
	CNetworkDlg(CWnd* pParent = NULL);	// standard constructor
	Road m_roadstreet[5][8];
	double streetstop[8];
	Road m_otherstreet[8];

	double pc;          //交叉率
	double pm;          //变异率
	double avgfitness;  //平均适应度值
	
	struct individual
	{
		double  chrom[chormlength+1];
		double value;         
		double fitness;//适应度
		double t[4];
		double tA[4];
		double tB[4];
		double tC[4];
		double tD[4];
		double stop[8];
	};
	
	double GetNewIndividualValue(individual tempindividual);
	double GetOtherMinStop(individual tempindividual);

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
	//{{AFX_DATA(CNetworkDlg)
	enum { IDD = IDD_NETWORK_DIALOG };
	CProgressCtrl	m_progress;
	int		m_maxgeneration;
	int		m_maxgenindex;
	int		m_popsize;
	int		m_maxindex;
	double	m_t1;
	double	m_t2;
	double	m_t3;
	double	m_t4;
	double	m_ta1;
	double	m_ta2;
	double	m_ta3;
	double	m_ta4;
	double	m_tb1;
	double	m_tb2;
	double	m_tb3;
	double	m_tb4;
	double	m_tc1;
	double	m_tc2;
	double	m_tc3;
	double	m_tc4;
	double	m_td1;
	double	m_td2;
	double	m_td3;
	double	m_td4;
	double	m_min;
	double	m_othermin;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CNetworkDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CNetworkDlg)
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

#endif // !defined(AFX_NETWORKDLG_H__2148FE33_D704_47E7_AA5B_006A8A2F2B81__INCLUDED_)
