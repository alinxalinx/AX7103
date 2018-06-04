
// PCIEDlg.h : 头文件
//

#pragma once
int refresh_video(void *opaque);
UINT PCIe_video(LPVOID lparam);
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
	CWinThread *   m_PCIEThread; 
	BYTE *lpbuf;
	void SDL_video(void);
 CRect m_rect_PICURE_CONTROL;            //播放区域初始化的位置
int m_width_PICURE_CONTROL;             //播放区域的宽
int m_height_PICURE_CONTROL;            //播放区域的高
 unsigned char n_StExe;
 afx_msg void OnBnClickedBtnAbout();
 afx_msg void OnDestroy();
 afx_msg void OnClose();
};
