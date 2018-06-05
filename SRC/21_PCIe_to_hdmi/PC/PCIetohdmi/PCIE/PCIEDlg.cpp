
// PCIEDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "PCIE.h"
#include "PCIEDlg.h"
#include "afxdialogex.h"
#include "PCIEDLL.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif
// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
protected:
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedMfclink1();
};

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
	ON_BN_CLICKED(IDOK, &CAboutDlg::OnBnClickedOk)
ON_BN_CLICKED(IDC_MFCLINK1, &CAboutDlg::OnBnClickedMfclink1)
END_MESSAGE_MAP()


// CPCIEDlg 对话框



CPCIEDlg::CPCIEDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CPCIEDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CPCIEDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CPCIEDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BTN_ABOUT, &CPCIEDlg::OnBnClickedBtnAbout)
	ON_WM_DESTROY()
	ON_WM_CLOSE()
	ON_MESSAGE(WM_SHOWTASK,OnShowTask)//此处为添加部分
	ON_WM_SIZE()
	ON_WM_SIZE()
END_MESSAGE_MAP()


// CPCIEDlg 消息处理程序

BOOL CPCIEDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标


	 //---------------------------托盘显示---------------------------------//
    m_nid.cbSize  = (DWORD)sizeof(NOTIFYICONDATA);
    m_nid.hWnd    = this->m_hWnd;

    m_nid.uID     = IDR_MAINFRAME;
    m_nid.uFlags  = NIF_ICON | NIF_MESSAGE | NIF_TIP ;
    m_nid.uCallbackMessage = WM_SHOWTASK;             // 自定义的消息名称
    m_nid.hIcon   = LoadIcon(AfxGetInstanceHandle(),MAKEINTRESOURCE(IDR_MAINFRAME));
    strcpy_s(m_nid.szTip, "Pcie to hdmi");                
    Shell_NotifyIcon(NIM_ADD, &m_nid);                // 在托盘区添加图标
		lpbuf=(BYTE*)HeapAlloc(GetProcessHeap(),0,8294454);
		//pcie_inital();
		n_StExe=0;
		m_PCIEThread =::AfxBeginThread(PCIe_GetScreen,this, THREAD_PRIORITY_NORMAL);
	   return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

LRESULT CPCIEDlg::OnShowTask(WPARAM wParam, LPARAM lParam)
{
     if(wParam != IDR_MAINFRAME) return 1;
 
     switch(lParam)
     {
     case WM_RBUTTONUP:               //右键起来时弹出菜单
         {
              LPPOINT lpoint = new tagPOINT;
              ::GetCursorPos(lpoint);                    // 得到鼠标位置
              CMenu menu;
              menu.CreatePopupMenu();                    // 声明一个弹出式菜单
              menu.AppendMenu(MF_STRING, WM_DESTROY, "退出");//Appends a new item to the end ofthis menu         
              menu.TrackPopupMenu(TPM_LEFTALIGN, lpoint->x ,lpoint->y,this);
              HMENU hmenu = menu.Detach();
              menu.DestroyMenu();
              delete lpoint;
              break;
         }
     case WM_LBUTTONDBLCLK:                            // 双击左键的处理
         this->ShowWindow(SW_SHOWNORMAL);         // 显示主窗口 
         break;
     }
 
     return 0;
}

void CPCIEDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}
// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CPCIEDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CPCIEDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}
void CAboutDlg::OnBnClickedOk()
{
	// TODO: 在此添加控件通知处理程序代码
	CDialogEx::OnOK();
}


void CPCIEDlg::OnBnClickedBtnAbout()
{
	// TODO: 在此添加控件通知处理程序代码
	CAboutDlg dlg;
	 dlg.DoModal();

}




void CAboutDlg::OnBnClickedMfclink1()
{
	// TODO: 在此添加控件通知处理程序代码
}


void CPCIEDlg::OnDestroy()
{
	 n_StExe=1;	
	 m_nid.cbSize  = (DWORD)sizeof(NOTIFYICONDATA);
    m_nid.hWnd    = this->m_hWnd;
    m_nid.uID     = IDR_MAINFRAME;
    m_nid.uFlags  = NIF_ICON | NIF_MESSAGE | NIF_TIP ;
    m_nid.uCallbackMessage = WM_SHOWTASK;             // 自定义的消息名称
    m_nid.hIcon   = LoadIcon(AfxGetInstanceHandle(),MAKEINTRESOURCE(IDR_MAINFRAME));
   // strcpy(m_nid.szTip, " PCIE");                // 
    Shell_NotifyIcon(NIM_DELETE,&m_nid); //在托盘区删除图标, &m_nid);                // 在托盘区添加图标
	Sleep(1000);
	CDialogEx::OnDestroy();

}

void CPCIEDlg::OnClose()
{
	// TODO: 在此添加消息处理程序代码和/或调用默认值
	n_StExe=1;
	CDialogEx::OnClose();
}


void CPCIEDlg::SC_Aqure(void)
{
	HCURSOR hCursor;
	POINT ptCursor;
	int xHotspot, yHotspot;
	 
int width=GetSystemMetrics(SM_CXSCREEN);
 int height=GetSystemMetrics(SM_CYSCREEN);
CDC *pdeskdc = GetDesktopWindow()->GetDC();    
CRect re;  
//获取窗口的大小  
GetDesktopWindow()->GetClientRect(&re);  
CBitmap bmp;  
bmp.CreateCompatibleBitmap(pdeskdc , re.Width() , re.Height());  
//创建一个兼容的内存画板 
CDC memorydc;  
memorydc.CreateCompatibleDC(pdeskdc);
while(1)
	{
CBitmap *pold = memorydc.SelectObject(&bmp);  
//绘制图像  
memorydc.BitBlt(0,0,re.Width() ,re.Height(), pdeskdc , 0,0,SRCCOPY | CAPTUREBLT) ;

 CURSORINFO CursorInfo;
	CursorInfo.cbSize = sizeof(CursorInfo);
	if (! ::GetCursorInfo(& CursorInfo))
	{
		//AfxMessageBox("error1");
		;
	}
	hCursor = CursorInfo.hCursor;
	ptCursor = CursorInfo.ptScreenPos;

	// 获取光标的图标数据
	ICONINFO IconInfo;
	if (! ::GetIconInfo(hCursor, & IconInfo))
		if (! ::GetCursorInfo(& CursorInfo))
	{
		//AfxMessageBox("error2");
		;
	}
	xHotspot = (LONG)IconInfo.xHotspot;
	yHotspot = (LONG)IconInfo.yHotspot;

	if (IconInfo.hbmMask)
		::DeleteObject(IconInfo.hbmMask);
	if (IconInfo.hbmColor)
		::DeleteObject(IconInfo.hbmColor);

		DEVMODEA mode;
	memset(& mode, 0, sizeof(mode));
	mode.dmSize = sizeof(mode);
	m_Settings.nLeft   = mode.dmPosition.x;
	m_Settings.nTop    = mode.dmPosition.y;
	m_Settings.nWidth  = mode.dmPelsWidth;
	m_Settings.nHeight = mode.dmPelsHeight;
	m_Settings.nBitsPerPel = mode.dmBitsPerPel;
	int xLeft = ptCursor.x - xHotspot - m_Settings.nLeft;
		int yTop  = ptCursor.y - yHotspot - m_Settings.nTop;
	::DrawIconEx(memorydc, xLeft, yTop, hCursor, 0, 0, 0, NULL, DI_NORMAL | DI_COMPAT);
    memorydc.SelectObject(pold);  

	 BITMAP bit;  
    bmp.GetBitmap(&bit);  
  
    //定义 图像大小（单位：byte）  
    DWORD size = bit.bmWidthBytes * bit.bmHeight ; 
	::GetBitmapBits(bmp, size,lpbuf); 
	WriteFrame1080ptofpga(hDev,lpbuf,66355200);
	 if(n_StExe==1)
		{
		  break;
		}
}//while

}

UINT PCIe_GetScreen(LPVOID lparam)
{   
	CString strStatus; 
	CPCIEDlg* PCIE_Test = (CPCIEDlg*)lparam;
	if (PCIE_Test == NULL)
	{
		return 0;
	}
	    pcie_inital();
	while(1)

	 {

		  if(PCIE_Test->n_StExe==1)
		   {
			   //
			   PCIEClose(hDev);
			   HeapFree(GetProcessHeap(), 0, PCIE_Test->lpbuf);
			 break;
		   } 
		   PCIE_Test->SC_Aqure();
		
	 }
	return 0;
}


void CPCIEDlg::OnSize(UINT nType, int cx, int cy)
{
	CDialogEx::OnSize(nType, cx, cy);

	// TODO: 在此处添加消息处理程序代码
	  if (nType == SIZE_MINIMIZED)
     {
         ShowWindow(SW_HIDE);//隐藏最小化到任务栏的图标
     }
}
