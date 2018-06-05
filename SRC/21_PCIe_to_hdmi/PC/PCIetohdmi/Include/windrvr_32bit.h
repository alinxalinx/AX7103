#ifndef _WINDRVR_32BIT_H_
#define _WINDRVR_32BIT_H_

/* This header contains 32bit representations of structures which
 * are used internally and externally */

#include "wd_types.h"

#if defined(__cplusplus)
extern "C" {
#endif

#if defined(LINUX) || defined(APPLE)
   #if defined(PPC64)
        #pragma pack(push,1)
   #else
        #pragma pack(push,4)
   #endif
#endif

typedef u32 ptr32;
typedef u32 WD_BUS_TYPE_32B;

typedef struct
{
    WD_BUS_TYPE_32B dwBusType; /* Bus Type: ISA, EISA, PCI. */
    u32 dwBusNum;              /* Bus number. */
    u32 dwSlotFunc;            /* Slot number on Bus. */
} WD_BUS_V30_32B;

typedef struct
{
    u32 item; /* ITEM_TYPE */
    u32 fNotSharable;
    union
    {
        struct
        {                        /* ITEM_MEMORY */
            u64 pPhysicalAddr;   /* Physical address on card */
            u64 qwBytes;         /* Address range */
            u64 pTransAddr;      /* Returns the address to pass on to transfer
                                    commands */
            u32 pUserDirectAddr; /* Returns the address for direct user
                                    read/write */
            u32 dwBar;
            u32 dwOptions;       /* WD_ITEM_MEM_OPTIONS */
            u64 pReserved;
        } Mem;
        struct
        {                    /* ITEM_IO */
            u64 pAddr;       /* Beginning of I/O address */
            u32 dwBytes;     /* I/O range */
            u32 dwBar;
        } IO;
        struct
        {                    /* ITEM_INTERRUPT */
            u32 dwInterrupt; /* Number of interrupt to install */
            u32 dwOptions;   /* Interrupt options. For level sensitive
                                interrupts - set to: INTERRUPT_LEVEL_SENSITIVE
                                */
            u32 hInterrupt;  /* Returns the handle of the interrupt installed */
            u32 dwReserved1;
            u64 pReserved2;
        } Int;
        WD_BUS_V30_32B Bus;  /* ITEM_BUS */
    } I;
} WD_ITEMS_V118_32B;

typedef struct
{
    u32 dwItems;
    WD_ITEMS_V118_32B Item[WD_CARD_ITEMS];
} WD_CARD_V118_32B;

typedef struct
{
    u32 dwVendorId;
    u32 dwDeviceId;
} WD_PCI_ID_32B;

typedef struct
{
    u32 hKernelPlugIn;
    u32 dwMessage;
    ptr32 pData;
    u32 dwResult;
} WD_KERNEL_PLUGIN_CALL_V40_32B;

typedef struct
{
    u32 hInterrupt;                       // Handle of interrupt.
    u32 dwOptions;                        /* Interrupt options: can be
                                             INTERRUPT_CMD_COPY */

    u32 Cmd;                              // Commands to do on interrupt.
    u32 dwCmds;                           // Number of commands.

                                          // For WD_IntEnable():
    WD_KERNEL_PLUGIN_CALL_V40_32B kpCall; // Kernel PlugIn call.
    u32 fEnableOk;                        /* TRUE if interrupt was enabled
                                             (WD_IntEnable() succeed) */
                                          // For WD_IntWait() and WD_IntCount()
    u32 dwCounter;                        // Number of interrupts received.
    u32 dwLost;                           /* Number of interrupts not yet dealt
                                             with. */
    u32 fStopped;                         // Was interrupt disabled during wait.
    u32 dwLastMessage;                    /* Message data of the last received
                                             MSI/MSI-X (Windows Vista and
                                             higher); N/A to line-based
                                             interrupts) */
    u32 dwEnabledIntType;                 /* Interrupt type that was actually
                                             enabled */
} WD_INTERRUPT_V91_32B;

typedef struct
{
    WD_CARD_V118_32B Card;   // Card to register.
    u32 fCheckLockOnly;      /* Only check if card is lockable, return hCard=1
                             * if OK */
    u32 hCard;               // Handle of card.
    u32 dwOptions;           // Should be zero.
    CHAR cName[32];          // Name of card.
    CHAR cDescription[100];  // Description.
} WD_CARD_REGISTER_V118_32B;

typedef struct
{
    u32 hKernelPlugIn;
    ptr32 pcDriverName;
    ptr32 pcDriverPath;
    ptr32 pOpenData;
} WD_KERNEL_PLUGIN_V40_32B;

typedef struct
{
    u32 dwBus;
    u32 dwSlot;
    u32 dwFunction;
} WD_PCI_SLOT_32B;

typedef struct
{
    u32 hEvent;           // inout
    u32 dwEventType;      // in    WD_EVENT_TYPE

    u32 dwAction;         // in    WD_EVENT_ACTION
    u32 dwEventId;        // inout
    u32 hKernelPlugIn;    // in
    u32 dwOptions;        // inout WD_EVENT_OPTION
    union
    {
        struct
        {
            WD_PCI_ID_32B cardId;
            WD_PCI_SLOT_32B pciSlot;
        } Pci;
        struct
        {
            u32 dwUniqueID;
        } Usb;
        struct
        {
            u32 hIpc;
            u32 dwSubGroupID;
            u32 dwGroupID;

            u32 dwSenderUID;
            u32 dwMsgID;
            u64 qwMsgData;
        } Ipc;
    } u;                  // in
    u32 dwNumMatchTables; // in
    WDU_MATCH_TABLE matchTables[1]; // in
} WD_EVENT_V121_32B;

/* Only wdc_defs.h structures should be packed */
#if defined(WINNT)
    #include <pshpack1.h>
#endif

/* Address space information struct */
typedef struct {
    u32 dwAddrSpace;        /* Address space number */
    u32 fIsMemory;          /* TRUE: memory address space; FALSE: I/O */
    u32 dwItemIndex;        /* Index of address space in the
                             * pDev->cardReg.Card.Item array */
    u32 reserved;
    u64 qwBytes;            /* Size of address space */
    u64 pAddr;              /* I/O / Memory kernel mapped address -- for
                             * WD_Transfer(), WD_MultiTransfer(), or direct
                             * kernel access */
    u32 pUserDirectMemAddr; /* Memory address for direct user-mode access */
} WDC_ADDR_DESC_32B;

/* Device information struct */
typedef struct WDC_DEVICE_32B{
    WD_PCI_ID_32B               id;              /* PCI device ID */
    WD_PCI_SLOT_32B             slot;            /* PCI device slot
                                                  * location information */
    u32                         dwNumAddrSpaces; /* Total number of device's
                                                  * address spaces */
    ptr32                       pAddrDesc;       /* Array of device's address
                                                  * spaces information */
    WD_CARD_REGISTER_V118_32B   cardReg;         /* Device's resources
                                                  * information */
    WD_KERNEL_PLUGIN_V40_32B    kerPlug;         /* Kernel PlugIn information */

    WD_INTERRUPT_V91_32B        Int;             /* Interrupt information */
    u32                         hIntThread;

    WD_EVENT_V121_32B           Event;           /* Event information */
    u32                         hEvent;

    u32                         pCtx;            /* User-specific context */
} WDC_DEVICE_32B, *PWDC_DEVICE_32B;

#if defined(WINNT)
    #include <poppack.h>
#endif

#if defined(LINUX) || defined(APPLE)
    #pragma pack(pop)
#endif

#if defined(__cplusplus)
}
#endif

#endif /* _WINDRVR_32BIT_H_ */

