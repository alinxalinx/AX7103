
// PCIEDlg.h : 头文件
//

#pragma once
UINT PCIe_GetScreen(LPVOID lparam);
struct tagScreenSettings
{
	int nLeft;        // 桌面扩展 左偏移
	int nTop;         // 桌面扩展 顶偏移
	int nWidth;       // 屏幕分辨率 宽度
	int nHeight;      // 屏幕分辨率 高度
	int nBitsPerPel;  // 颜色质量
};
// CPCIEDlg 对话框
#define WM_SHOWTASK WM_USER+1
class CPCIEDlg : public CDialogEx
{
// 构造
public:
	CPCIEDlg(CWnd* pParent = NULL);	// 标准构造函数
	NOTIFYICONDATA m_nid;
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
	tagScreenSettings m_Settings;  // 屏幕设置
	CWinThread *   m_PCIEThread; 
	BYTE *lpbuf;
 unsigned char n_StExe;
 void SC_Aqure(void);
 afx_msg void OnBnClickedBtnAbout();
 afx_msg void OnDestroy();
 afx_msg void OnClose();
 afx_msg LRESULT OnShowTask(WPARAM wParam,LPARAM lParam);
 afx_msg void OnSize(UINT nType, int cx, int cy);
};
