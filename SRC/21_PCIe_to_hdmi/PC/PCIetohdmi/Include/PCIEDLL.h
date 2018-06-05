#ifdef PCIEDLL_EXPORTS
#define PCIEDLL_API __declspec(dllexport)
#else
#define PCIEDLL_API __declspec(dllimport)
#endif
#include "wdc_lib.h"
 PCIEDLL_API WDC_DEVICE_HANDLE hDev;//PCIE设备句柄
 PCIEDLL_API DWORD pcie_inital(void);//返回值0：成功
 PCIEDLL_API double sP_buf[2];//sP_buf[0]：PC机写入AX7103的PCIE的速度值，sP_buf[1]：PC机读取AX7103的PCIE的速度值。
//PCIEDLL_API void DeviceClose(WDC_DEVICE_HANDLE hDev);
PCIEDLL_API DWORD PCIEClose(WDC_DEVICE_HANDLE hDev);//关闭PCIE设备 返回值0：成功
PCIEDLL_API DWORD PCIE_LibUninit(void);//Uninitialize WDC libraries 返回值0：成功
/***************************************************************************************************
PCIEDLL_API DWORD writetofpga ( WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 u64Offset,UINT32 Totalnum)
功能：写入到AX7103的PCIE数据
返回值0：成功
hDev:PCIE设备句柄
buf:存储需写入数据的缓冲区
u64Offset：写入首地址偏移量
Totalnum:需写入的字节数
******************************************************************************************************/
PCIEDLL_API DWORD writetofpga ( WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 u64Offset,UINT32 Totalnum);
/***************************************************************************************************
PCIEDLL_API DWORD writetoPC( WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 u64Offset,UINT32 Totalnum)
功能：读出AX7103的PCIE数据到PC
返回值0：成功
hDev:PCIE设备句柄
buf:存储需读出数据的缓冲区
u64Offset：读出数据的首地址偏移量
Totalnum:需读出的字节数
******************************************************************************************************/
PCIEDLL_API DWORD writetoPC ( WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 u64Offset,UINT32 Totalnum);
/***************************************************************************************************
PCIEDLL_API void PCIEspeed_DmaPerformance(WDC_DEVICE_HANDLE hDev, DWORD dwOption,DWORD dwBytes, BOOL fPolling,UINT64 u64Offset,DWORD dwSeconds)
功能：AX7103的PCIE测速函数
返回值：无
hDev:PCIE设备句柄
dwOption:1:写入AX7103,2:读取AX7103，3：双向
dwBytes:写入/读取的字节数
fPolling:1有效，其它无效(备用)
u64Offset：写入/读出数据的首地址偏移量
dwSeconds:读取或写入时间设置单位（秒)
******************************************************************************************************/
PCIEDLL_API void PCIEspeed_DmaPerformance(WDC_DEVICE_HANDLE hDev, DWORD dwOption,DWORD dwBytes, BOOL fPolling,UINT64 u64Offset,DWORD dwSeconds);
/***************************************************************************************************
PCIEDLL_API DWORD UserIntInit(WDC_DEVICE_HANDLE hDev)
功能：初始化中断
返回值：PCIE设备对应地址空间
******************************************************************************************************/
 PCIEDLL_API DWORD UserIntInit(WDC_DEVICE_HANDLE hDev);
 /***************************************************************************************************
 PCIEDLL_API DWORD ReadUserInt_reg(WDC_DEVICE_HANDLE hDev,DWORD dwAddrSpace)
功能：读取中断返回值
返回值：中断值
hDev:PCIE设备句柄
dwAddrSpace:PCIE设备对应地址空间
******************************************************************************************************/
 PCIEDLL_API DWORD ReadUserInt_reg(WDC_DEVICE_HANDLE hDev,DWORD dwAddrSpace);

  /***************************************************************************************************
PCIEDLL_API DWORD ReadFrame1080ptoPC(WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 Addr_FPGA)
功能：读取1帧1080p图像
返回值：0:成功
hDev:PCIE设备句柄
bufin:存储需读出数据的缓冲区
Addr_FPGA:FPGA中DDR3的地址
******************************************************************************************************/
PCIEDLL_API DWORD ReadFrame1080ptoPC(WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 Addr_FPGA);
  /***************************************************************************************************
PCIEDLL_API DWORD WriteFrame1080ptofpga(WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 Addr_FPGA)
功能：写1帧1080p图像
返回值：0:成功
hDev:PCIE设备句柄
bufin:存储需写入数据的缓冲区
Addr_FPGA:FPGA中DDR3的地址
******************************************************************************************************/
PCIEDLL_API DWORD WriteFrame1080ptofpga(WDC_DEVICE_HANDLE hDev,BYTE *bufin,UINT64 Addr_FPGA);
