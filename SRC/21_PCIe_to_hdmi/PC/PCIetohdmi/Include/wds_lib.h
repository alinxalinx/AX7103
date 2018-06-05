/* Jungo Connectivity Confidential. Copyright (c) 2017 Jungo Connectivity Ltd.  http://www.jungo.com */

#ifndef _WDS_LIB_H_
#define _WDS_LIB_H_

/*********************************************************************
*  File: wds_lib.h - WD Shared (WDS) library header.                 *
*                    This file defines the WDS library's high-level  *
*                    interface                                       *
**********************************************************************/

#if defined(__KERNEL__)
    #include "kpstdlib.h"
#endif

#include "windrvr.h"
#include "wdc_lib.h"

#ifdef __cplusplus
    extern "C" {
#endif

/**************************************************************
  General definitions
 **************************************************************/

/* -------------------------------------------------------------------------
    IPC
   ------------------------------------------------------------------------- */
/* IPC API functions are not part of the standard WinDriver API, and not
 * included in the standard version of WinDriver. The functions are part of
 * "WinDriver for Server" API and require "WinDriver for Server" license.
 * Note that "WinDriver for Server" APIs are included in WinDriver evaluation
 * version. */

/* IPC scan processes results */
typedef struct {
    DWORD          dwNumProcs; /* Number of matching processes */
    WD_IPC_PROCESS procInfo[WD_IPC_MAX_PROCS]; /* Array of processes info */
} WDS_IPC_SCAN_RESULT;

/* IPC message received */
typedef struct {
    DWORD   dwSenderUID;
    DWORD   dwMsgID;
    UINT64  qwMsgData;
} WDS_IPC_MSG_RX;

typedef void (*IPC_MSG_RX_HANDLER)(WDS_IPC_MSG_RX *pIpcRxMsg, void *pData);

BOOL DLLCALLCONV WDS_IsIpcRegistered(void);
DWORD DLLCALLCONV WDS_IpcRegister(const CHAR *pcProcessName, DWORD dwGroupID,
    DWORD dwSubGroupID, DWORD dwAction, IPC_MSG_RX_HANDLER pFunc, void *pData);
void DLLCALLCONV WDS_IpcUnRegister(void);

DWORD DLLCALLCONV WDS_IpcScanProcs(WDS_IPC_SCAN_RESULT *pIpcScanResult);

DWORD DLLCALLCONV WDS_IpcUidUnicast(DWORD dwRecipientUID, DWORD dwMsgID,
    UINT64 qwMsgData);
DWORD DLLCALLCONV WDS_IpcSubGroupMulticast(DWORD dwRecipientSubGroupID,
    DWORD dwMsgID, UINT64 qwMsgData);
DWORD DLLCALLCONV WDS_IpcMulticast(DWORD dwMsgID, UINT64 qwMsgData);

/* -------------------------------------------------------------------------
    Shared Buffers (User-Mode <-> Kernel Mode) / (User-Mode <-> User-Mode)
   ------------------------------------------------------------------------- */
/*
 * Kernel buffers can be used to share data between:
 * 1) User-mode application and a Kernel PlugIn driver.
 * 2) Multiple user-mode applications.
 */

/* Allocate a shared kernel buffer.
 * Notice the resulting buffer is not DMA capable */
DWORD DLLCALLCONV WDS_SharedBufferAlloc(UINT64 qwBytes, DWORD dwOptions,
    WD_KERNEL_BUFFER **ppKerBuf);

/* Get kernel buffer global handle */
#define WDS_SharedBufferGetGlobalHandle(pKerBuf) ((pKerBuf)->hKerBuf)

/* Get a shared kernel buffer.
 * This API function is not part of the standard WinDriver API, and not included
 * in the standard version of WinDriver. It is part of
 * "WinDriver for Server" API and requires "WinDriver for Server" license. Note
 * that "WinDriver for Server" APIs are included in WinDriver evaluation
 * version. */
DWORD DLLCALLCONV WDS_SharedBufferGet(DWORD hKerBuf,
    WD_KERNEL_BUFFER **ppKerBuf);

/* Free a shared kernel buffer */
DWORD DLLCALLCONV WDS_SharedBufferFree(WD_KERNEL_BUFFER *pKerBuf);

#ifdef __cplusplus
}
#endif

#endif /* _WDS_LIB_H_ */

