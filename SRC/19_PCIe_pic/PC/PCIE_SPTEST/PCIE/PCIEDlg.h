
// PCIEDlg.h : 头文件
//

#pragma once

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
	CString m_Path_Snd;
	CString m_Path_Rev;;
	void Pic_Show_Snd(void);
	void Pic_Show_Rev(void);
	int numquad; //调色板数
 int flagOpen; //标志是否打开bmp
 BITMAPINFO* pbi; //记录图像细节
 BYTE* lpbuf; //图像数据
 
 RGBQUAD* quad; //调色板
 BITMAPFILEHEADER bf;//文件头
 BITMAPINFOHEADER bi; //信息头
 CBitmap m_bmp;
 afx_msg void OnBnClickedButtonPcieSnd();
 afx_msg void OnBnClickedButtonBrowse();
 afx_msg void OnBnClickedBtnAbout();
};
