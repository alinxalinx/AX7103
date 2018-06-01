
// PCIEDlg.h : 头文件
//
#include "afxwin.h"
#define Len_PCIE_Single 10*1024*1024
#pragma once

#define WM_SEND_MSG WM_USER+100

UINT PCIe_SpeedThread(LPVOID lparam);
// CPCIEDlg 对话框
class CPCIEDlg : public CDialogEx
{
// 构造
public:
	CPCIEDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_PCIE_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持

public:
	int m_nBtnStatus;
       HANDLE hThread;
       unsigned nThreadID;

// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:

CWinThread *   m_PCIEThread; 
 afx_msg void OnBnClickedPctofpga();
 afx_msg void OnBnClickedFpgatopc();
 afx_msg void OnBnClickedBidir();

 afx_msg void OnBnClickedBtnAbout();
 UINT8 m_StatusSel;
 UINT8 m_InitPCIE;
 CString m_DataSnd;
 CString m_DataRcv;
 CString m_DataBir;
 afx_msg void OnBnClickedBtnStop();
 CEdit m_EditCtl_Snd;
 CEdit m_EditCtl_Rcv;
 CEdit m_EditCtl_Bir;
};
