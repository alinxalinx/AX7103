
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
/******************************************************/
BYTE* bufinout = new BYTE[1024*1024*60];
BYTE* lpbuf = new BYTE[1024*1024*60];
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
//	afx_msg void OnEnChangeNetaddress1();
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
//	ON_EN_CHANGE(IDC_NETADDRESS1, &CAboutDlg::OnEnChangeNetaddress1)
ON_BN_CLICKED(IDC_MFCLINK1, &CAboutDlg::OnBnClickedMfclink1)
END_MESSAGE_MAP()


// CPCIEDlg 对话框



CPCIEDlg::CPCIEDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CPCIEDlg::IDD, pParent)
	, m_Path_Snd(_T(""))
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CPCIEDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT_PATH, m_Path_Snd);
}

BEGIN_MESSAGE_MAP(CPCIEDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_PCIE_SND, &CPCIEDlg::OnBnClickedButtonPcieSnd)
	ON_BN_CLICKED(IDC_BUTTON_BROWSE, &CPCIEDlg::OnBnClickedButtonBrowse)
	ON_BN_CLICKED(IDC_BTN_ABOUT, &CPCIEDlg::OnBnClickedBtnAbout)
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

	// TODO: 在此添加额外的初始化代码
	memset(bufinout, 0, sizeof(BYTE)*1024*1024*60);
	//memset(lpbuf, 0, sizeof(BYTE)*1024*1024*60);
	bi.biSizeImage=0x1000;
	hDev = NULL;
	flagOpen=0;
	UpdateData(FALSE);
	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
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
void CPCIEDlg::Pic_Show_Snd(void)
{
	CWnd *pWnd=GetDlgItem(IDC_PICTURE);//获得pictrue控件窗口的句柄
	CRect rect;
	pWnd->GetClientRect(&rect);//获得pictrue控件所在的举行区域
	CDC *pDC=pWnd->GetDC();//获得pictrue控件的DC

	IStream *pStm=NULL;
	CFileStatus fstatus;
	CFile file;
	LONG cb;

	IPicture *pPic;//定义显示图片的接口（可显示jpg格式图片）
	CString m_sPath=m_Path_Snd;//设置想要显示的图片
	//打开图象文件，获取文件字节数
	if(file.Open(m_sPath,CFile::modeRead) && file.GetStatus(m_sPath,fstatus) 
		&& ((cb=fstatus.m_size)!=-1))
	{
	 //分配全局存储空间
     HGLOBAL hGlobal=GlobalAlloc(GMEM_MOVEABLE,cb);
	 LPVOID pvData=NULL;
	 if(hGlobal!=NULL)
	 {
	  //锁定分配内存块
      if((pvData=GlobalLock(hGlobal))!=NULL)
	  {
	   //读入文件到内存缓冲区
       file.Read(pvData,cb);
	   GlobalUnlock(hGlobal);
	   CreateStreamOnHGlobal(hGlobal,true,&pStm);
	  }
	 }
	 UpdateData(FALSE);
	}

	//装载图象文件
	if(SUCCEEDED(OleLoadPicture(pStm,fstatus.m_size,TRUE,IID_IPicture,(LPVOID*)&pPic)))
	{
     OLE_XSIZE_HIMETRIC hmWidth;
     OLE_XSIZE_HIMETRIC hmHeight;
	 pPic->get_Width(&hmWidth);//获得图象真实宽度
	 pPic->get_Height(&hmHeight);//获得图象真实高度
	 //在控件上显示图片	
	 pPic->Render(*pDC,0,0,rect.Width(),rect.Height(),0,hmHeight,hmWidth,-hmHeight,NULL);
     pPic->Release();
	}
}
void CPCIEDlg::Pic_Show_Rev(void)
{
	CWnd *pWnd=GetDlgItem(IDC_PICTURE_REV);//获得pictrue控件窗口的句柄
	CRect rect;
	pWnd->GetClientRect(&rect);//获得pictrue控件所在的举行区域
	CDC *pDC=pWnd->GetDC();//获得pictrue控件的DC

	IStream *pStm=NULL;
	CFileStatus fstatus;
	CFile file;
	LONG cb;

	IPicture *pPic;//定义显示图片的接口（可显示jpg格式图片）
	CString m_sPath=m_Path_Rev;//设置想要显示的图片
	//打开图象文件，获取文件字节数
	if(file.Open(m_sPath,CFile::modeRead) && file.GetStatus(m_sPath,fstatus) 
		&& ((cb=fstatus.m_size)!=-1))
	{
	 //分配全局存储空间
     HGLOBAL hGlobal=GlobalAlloc(GMEM_MOVEABLE,cb);
	 LPVOID pvData=NULL;
	 if(hGlobal!=NULL)
	 {
	  //锁定分配内存块
      if((pvData=GlobalLock(hGlobal))!=NULL)
	  {
	   //读入文件到内存缓冲区
       file.Read(pvData,cb);
	   GlobalUnlock(hGlobal);
	   CreateStreamOnHGlobal(hGlobal,true,&pStm);
	  }
	 }
	}

	//装载图象文件
	if(SUCCEEDED(OleLoadPicture(pStm,fstatus.m_size,TRUE,IID_IPicture,(LPVOID*)&pPic)))
	{
     OLE_XSIZE_HIMETRIC hmWidth;
     OLE_XSIZE_HIMETRIC hmHeight;
	 pPic->get_Width(&hmWidth);//获得图象真实宽度
	 pPic->get_Height(&hmHeight);//获得图象真实高度
	 //在控件上显示图片	
	 pPic->Render(*pDC,0,0,rect.Width(),rect.Height(),0,hmHeight,hmWidth,-hmHeight,NULL);
     pPic->Release();
	}
}
// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CPCIEDlg::OnPaint()
{
	Pic_Show_Snd();
	Pic_Show_Rev();
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
  
 
void CPCIEDlg::OnBnClickedButtonBrowse()
{
// TODO: 在此添加控件通知处理程序代码
CFileDialog dlg( TRUE, "", NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, "bmp文件(*.bmp)|*.bmp|所有文件(*.*)|*.*||" );
dlg.m_ofn.lpstrTitle = "打开文件";

CFile file;
//打开文件对话框
if(dlg.DoModal()==IDOK)
{
m_Path_Snd=dlg.GetPathName();

if(file.Open(m_Path_Snd,CFile::modeRead|CFile::shareDenyNone,NULL)==0)
{
//读取文件失败
AfxMessageBox("读取文件失败");
return;
}
//读取文件头
file.Read(&bf,sizeof(bf));
//判断是否是BMP 文件
if(bf.bfType!=0x4d42)//'BM'
{
AfxMessageBox("非BMP 文件！");
return;
}
//判断文件是否损坏
if(file.GetLength()!=bf.bfSize)
{
AfxMessageBox("文件已损坏");
return;
}
//读文件信息头
file.Read(&bi,sizeof(bi));
//计算调色板数目
numquad=0;
if(bi.biBitCount<24)
{
numquad=1<<bi.biBitCount;
}
//为图像信息pbi 申请空间
pbi=(BITMAPINFO*)HeapAlloc(GetProcessHeap(),0,sizeof(BITMAPINFOHEADER)+numquad*sizeof(RGBQUAD));
memcpy(pbi,&bi,sizeof(bi));
quad=(RGBQUAD*)((BYTE*)pbi+sizeof(BITMAPINFOHEADER));
//读取调色板
if(numquad!=0)
{
file.Read(quad,sizeof(RGBQUAD)*numquad);
}
//为图像数据申请空间
bi.biSizeImage=bf.bfSize-bf.bfOffBits;
lpbuf=(BYTE*)HeapAlloc(GetProcessHeap(),0,bi.biSizeImage);
//读取图像数据
file.Read(lpbuf,bi.biSizeImage);
//图像读取完毕，关闭文件，设置标志
DWORD i;
//for(i=1000;i<7500000;i++)
//lpbuf[i]=0x00;
memset(bufinout, 0, sizeof(BYTE)*1024*1024*60);
file.Close();
flagOpen=1;
}
Pic_Show_Snd();
}

void CPCIEDlg::OnBnClickedButtonPcieSnd()
{
	// TODO: 在此添加控件通知处理程序代码
	
	if(!flagOpen)
	{
		AfxMessageBox("先选择bmp图片");
	}
	else{
	pcie_inital();
	writetofpga (hDev,lpbuf,0x00,bi.biSizeImage);

	writetoPC(hDev,lpbuf,0x00,bi.biSizeImage);
    PCIEClose(hDev);
	int nPt = m_Path_Snd.ReverseFind('.');
	CString file_L = m_Path_Snd.Left(nPt);
	CString file_R = m_Path_Snd.Right( m_Path_Snd.GetLength() - nPt);
	file_L += _T("-pcie.bmp");
m_Path_Rev=file_L;
CFile file;
CFileException fe;

if (!file.Open(m_Path_Rev, CFile::modeCreate | CFile::modeReadWrite |
CFile::shareExclusive, &fe))
{
// 失败
	AfxMessageBox("保存失败");
return;
}

file.SeekToBegin();
file.Write(&bf,sizeof(bf));
file.Write(&bi,sizeof(bi));
if(numquad!=0)
{
file.Write(quad,sizeof(RGBQUAD)*numquad);
}
file.Write(lpbuf,bi.biSizeImage);
file.Close();
Pic_Show_Rev();
	flagOpen=0;
}
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
