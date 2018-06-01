/* Jungo Connectivity Confidential. Copyright (c) 2017 Jungo Connectivity Ltd.  http://www.jungo.com */

#ifndef _PCI_REGS_H_
#define _PCI_REGS_H_

/*****************************************************************************
* File - pci_regs.h - PCI configuration space and address spaces definitions *
******************************************************************************/

/* -----------------------------------------------
    PCI configuration registers offsets
   ----------------------------------------------- */
enum {
    PCI_VID   = 0x00, /* Vendor ID */
    PCI_DID   = 0x02, /* Device ID */
    PCI_CR    = 0x04, /* Command register */
    PCI_SR    = 0x06, /* Status register */
    PCI_REV   = 0x08, /* Revision ID */
    PCI_CCR   = 0x09, /* Class code */
    PCI_CCSC  = 0x0a, /* Sub class code */
    PCI_CCBC  = 0x0b, /* Base class code */
    PCI_CLSR  = 0x0c, /* Cache line size */
    PCI_LTR   = 0x0d, /* Latency timer */
    PCI_HDR   = 0x0e, /* Header type */
    PCI_BISTR = 0x0f, /* Built-in self test */
    PCI_BAR0  = 0x10, /* Base address register */
    PCI_BAR1  = 0x14, /* Base address register */
    PCI_BAR2  = 0x18, /* Base address register */
    PCI_BAR3  = 0x1c, /* Base address register */
    PCI_BAR4  = 0x20, /* Base address register */
    PCI_BAR5  = 0x24, /* Base address register */
    PCI_CIS   = 0x28, /* CardBus CIS pointer */
    PCI_SVID  = 0x2c, /* Sub-system vendor ID */
    PCI_SDID  = 0x2e, /* Sub-system device ID */
    PCI_EROM  = 0x30, /* Expansion ROM base address */
    PCI_CAP   = 0x34, /* New capability pointer */
    PCI_ILR   = 0x3c, /* Interrupt line */
    PCI_IPR   = 0x3d, /* Interrupt pin */
    PCI_MGR   = 0x3e, /* Minimum required burst period */
    PCI_MLR   = 0x3f  /* Maximum latency - How often device must gain PCI bus
                       * access */
};

#define PCI_HEADER_TYPE     0x0e    /* 8 bits */
#define  PCI_HEADER_TYPE_NORMAL  0
#define  PCI_HEADER_TYPE_BRIDGE  1
#define  PCI_HEADER_TYPE_CARDBUS 2

#define PCI_SR_CAP_LIST_BIT 0x00000010

/* PCI base address spaces (BARs) */
enum {
    AD_PCI_BAR0 = 0,
    AD_PCI_BAR1 = 1,
    AD_PCI_BAR2 = 2,
    AD_PCI_BAR3 = 3,
    AD_PCI_BAR4 = 4,
    AD_PCI_BAR5 = 5,
    AD_PCI_BARS = 6
};

/* PCI basic and extended capability lists last updated from-
 *     PCI Code and ID Assignment Specification Revision 1.5 */
/* Some of the following strings and macros are taken from
 * include/uapi/linux/pci_regs.h in Linux Kernel source */
/* Capability lists */
#define  PCI_CAP_LIST_ID    0     /* Capability ID */
#define  PCI_CAP_ID_PM      0x01  /* Power Management */
#define  PCI_CAP_ID_AGP     0x02  /* Accelerated Graphics Port */
#define  PCI_CAP_ID_VPD     0x03  /* Vital Product Data */
#define  PCI_CAP_ID_SLOTID  0x04  /* Slot Identification */
#define  PCI_CAP_ID_MSI     0x05  /* Message Signalled Interrupts */
#define  PCI_CAP_ID_CHSWP   0x06  /* CompactPCI HotSwap */
#define  PCI_CAP_ID_PCIX    0x07  /* PCI-X */
#define  PCI_CAP_ID_HT      0x08  /* HyperTransport */
#define  PCI_CAP_ID_VNDR    0x09  /* Vendor-Specific */
#define  PCI_CAP_ID_DBG     0x0A  /* Debug port */
#define  PCI_CAP_ID_CCRC    0x0B  /* CompactPCI Central Resource Control */
#define  PCI_CAP_ID_SHPC    0x0C  /* PCI Standard Hot-Plug Controller */
#define  PCI_CAP_ID_SSVID   0x0D  /* Bridge subsystem vendor/device ID */
#define  PCI_CAP_ID_AGP3    0x0E  /* AGP Target PCI-PCI bridge */
#define  PCI_CAP_ID_SECDEV  0x0F  /* Secure Device */
#define  PCI_CAP_ID_EXP     0x10  /* PCI Express */
#define  PCI_CAP_ID_MSIX    0x11  /* MSI-X */
#define  PCI_CAP_ID_SATA    0x12  /* SATA Data/Index Conf. */
#define  PCI_CAP_ID_AF      0x13  /* PCI Advanced Features */
#define  PCI_CAP_LIST_NEXT  1     /* Next capability in the list */

/* Extended Capabilities (PCI-X 2.0 and Express) */
#define PCI_EXT_CAP_ID(header)          (header & 0x0000ffff)
#define PCI_EXT_CAP_VER(header)         ((header >> 16) & 0xf)
#define PCI_EXT_CAP_NEXT(header)        ((header >> 20) & 0xffc)

#define PCI_EXT_CAP_ID_ERR      0x0001  /* Advanced Error Reporting */
#define PCI_EXT_CAP_ID_VC       0x0002  /* Virtual Channel Capability */
#define PCI_EXT_CAP_ID_DSN      0x0003  /* Device Serial Number */
#define PCI_EXT_CAP_ID_PWR      0x0004  /* Power Budgeting */
#define PCI_EXT_CAP_ID_RCLD     0x0005  /* Root Complex Link Declaration */
#define PCI_EXT_CAP_ID_RCILC    0x0006  /* Root Complex Internal Link Control */
#define PCI_EXT_CAP_ID_RCEC     0x0007  /* Root Complex Event Collector */
#define PCI_EXT_CAP_ID_MFVC     0x0008  /* Multi-Function VC Capability */
#define PCI_EXT_CAP_ID_VC9      0x0009  /* same as _VC */
#define PCI_EXT_CAP_ID_RCRB     0x000A  /* Root Complex RB? */
#define PCI_EXT_CAP_ID_VNDR     0x000B  /* Vendor-Specific */
#define PCI_EXT_CAP_ID_CAC      0x000C  /* Config Access - obsolete */
#define PCI_EXT_CAP_ID_ACS      0x000D  /* Access Control Services */
#define PCI_EXT_CAP_ID_ARI      0x000E  /* Alternate Routing ID */
#define PCI_EXT_CAP_ID_ATS      0x000F  /* Address Translation Services */
#define PCI_EXT_CAP_ID_SRIOV    0x0010  /* Single Root I/O Virtualization */
#define PCI_EXT_CAP_ID_MRIOV    0x0011  /* Multi Root I/O Virtualization */
#define PCI_EXT_CAP_ID_MCAST    0x0012  /* Multicast */
#define PCI_EXT_CAP_ID_PRI      0x0013  /* Page Request Interface */
#define PCI_EXT_CAP_ID_AMD_XXX  0x0014  /* Reserved for AMD */
#define PCI_EXT_CAP_ID_REBAR    0x0015  /* Resizable BAR */
#define PCI_EXT_CAP_ID_DPA      0x0016  /* Dynamic Power Allocation */
#define PCI_EXT_CAP_ID_TPH      0x0017  /* TPH Requester */
#define PCI_EXT_CAP_ID_LTR      0x0018  /* Latency Tolerance Reporting */
#define PCI_EXT_CAP_ID_SECPCI   0x0019  /* Secondary PCIe Capability */
#define PCI_EXT_CAP_ID_PMUX     0x001A  /* Protocol Multiplexing */
#define PCI_EXT_CAP_ID_PASID    0x001B  /* Process Address Space ID */
#define PCI_EXT_CAP_ID_LNR      0x001C  /* LN Requester (LNR) */
#define PCI_EXT_CAP_ID_DPC      0x001D  /* Downstream Port Containment (DPC) */
#define PCI_EXT_CAP_ID_L1PMS    0x001E  /* L1 PM Substates */
#define PCI_EXT_CAP_ID_PTM      0x001F  /* Precision Time Measurement (PTM) */
#define PCI_EXT_CAP_ID_MPHY     0x0020  /* PCI Express over M-PHY (M-PCIe) */
#define PCI_EXT_CAP_ID_FRSQ     0x0021  /* FRS Queueing */
#define PCI_EXT_CAP_ID_RTR      0x0022  /* Readiness Time Reporting */

#define GET_CAPABILITY_STR(cap_id) \
    (cap_id) == 0x00 ? "Null Capability" : \
    (cap_id) == PCI_CAP_ID_PM ? "Power Management" : \
    (cap_id) == PCI_CAP_ID_AGP ? "Accelerated Graphics Port" : \
    (cap_id) == PCI_CAP_ID_VPD ? "Vital Product Data" : \
    (cap_id) == PCI_CAP_ID_SLOTID ? "Slot Identification" : \
    (cap_id) == PCI_CAP_ID_MSI ? "Message Signalled Interrupts (MSI)" : \
    (cap_id) == PCI_CAP_ID_CHSWP ? "CompactPCI HotSwap" : \
    (cap_id) == PCI_CAP_ID_PCIX ? "PCI-X" : \
    (cap_id) == PCI_CAP_ID_HT ? "HyperTransport" : \
    (cap_id) == PCI_CAP_ID_VNDR ? "Vendor-Specific" : \
    (cap_id) == PCI_CAP_ID_DBG ? "Debug port" : \
    (cap_id) == PCI_CAP_ID_CCRC ? "CompactPCI Central Resource Control" : \
    (cap_id) == PCI_CAP_ID_SHPC ? "PCI Standard Hot-Plug Controller" : \
    (cap_id) == PCI_CAP_ID_SSVID ? "Bridge subsystem vendor/device ID" : \
    (cap_id) == PCI_CAP_ID_AGP3 ? "AGP Target PCI-PCI bridge" : \
    (cap_id) == PCI_CAP_ID_SECDEV ? "Secure Device" : \
    (cap_id) == PCI_CAP_ID_EXP ? "PCI Express" : \
    (cap_id) == PCI_CAP_ID_MSIX ? "Extended Message Signalled Interrupts (MSI-X)" : \
    (cap_id) == PCI_CAP_ID_SATA ? "SATA Data/Index Conf." : \
    (cap_id) == PCI_CAP_ID_AF ? "PCI Advanced Features" : \
    "Unknown"

#define GET_EXTENDED_CAPABILITY_STR(cap_id) \
    (cap_id) == 0x0000 ? "Null Capability" : \
    (cap_id) == PCI_EXT_CAP_ID_ERR ? "Advanced Error Reporting (AER)" : \
    (cap_id) == PCI_EXT_CAP_ID_VC ? "Virtual Channel (VC)" : /* MFVC Extended Cap struct is not present in the device */ \
    (cap_id) == PCI_EXT_CAP_ID_DSN ? "Device Serial Number" : \
    (cap_id) == PCI_EXT_CAP_ID_PWR ? "Power Budgeting" : \
    (cap_id) == PCI_EXT_CAP_ID_RCLD ? "Root Complex Link Declaration" : \
    (cap_id) == PCI_EXT_CAP_ID_RCILC ? "Root Complex Internal Link Control" : \
    (cap_id) == PCI_EXT_CAP_ID_RCEC ? "Root Complex Event Collector Endpoint Association" : \
    (cap_id) == PCI_EXT_CAP_ID_MFVC ? "Multi-Function Virtual Channel (MFVC)" : \
    (cap_id) == PCI_EXT_CAP_ID_VC9 ? "Virtual Channel (VC)" : /* MFVC Extended Cap struct is present in the device */ \
    (cap_id) == PCI_EXT_CAP_ID_RCRB ? "Root Complex Register Block (RCRB) Header" : \
    (cap_id) == PCI_EXT_CAP_ID_VNDR ? "Vendor-Specific Extended Capability (VSEC)" : \
    (cap_id) == PCI_EXT_CAP_ID_CAC ? "Configuration Access Correlation (CAC)" : \
    (cap_id) == PCI_EXT_CAP_ID_ACS ? "Access Control Services (ACS)" : \
    (cap_id) == PCI_EXT_CAP_ID_ARI ? "Alternative Routing-ID Interpretation (ARI)" : \
    (cap_id) == PCI_EXT_CAP_ID_ATS ? "Address Translation Services (ATS)" : \
    (cap_id) == PCI_EXT_CAP_ID_SRIOV ? "Single Root I/O Virtualization (SR-IOV)" : \
    (cap_id) == PCI_EXT_CAP_ID_MRIOV ? "Multi-Root I/O Virtualization (MR-IOV)" : \
    (cap_id) == PCI_EXT_CAP_ID_MCAST ? "Multicast" : \
    (cap_id) == PCI_EXT_CAP_ID_PRI ? "Page Request" : \
    (cap_id) == PCI_EXT_CAP_ID_AMD_XXX ? "Reserved for AMD" : \
    (cap_id) == PCI_EXT_CAP_ID_REBAR ? "Resizable BAR" : \
    (cap_id) == PCI_EXT_CAP_ID_DPA ? "Dynamic Power Allocation (DPA)" : \
    (cap_id) == PCI_EXT_CAP_ID_TPH ? "TLP Processing Hints (TPH)" : \
    (cap_id) == PCI_EXT_CAP_ID_LTR ? "Latency Tolerance Reporting (LTR)" : \
    (cap_id) == PCI_EXT_CAP_ID_SECPCI ? "Secondary PCI Express" : \
    (cap_id) == PCI_EXT_CAP_ID_PMUX ? "Protocol Multiplexing (PMUX)" : \
    (cap_id) == PCI_EXT_CAP_ID_PASID ? "Process Address Space ID (PASID)" : \
    (cap_id) == PCI_EXT_CAP_ID_LNR ? "LN Requester (LNR)" : \
    (cap_id) == PCI_EXT_CAP_ID_L1PMS ? "Downstream Port Containment (DPC)" : \
    (cap_id) == PCI_EXT_CAP_ID_L1PMS ? "L1 PM Substates" : \
    (cap_id) == PCI_EXT_CAP_ID_PTM ? "Precision Time Measurement (PTM)" : \
    (cap_id) == PCI_EXT_CAP_ID_MPHY ? "PCI Express over M-PHY (M-PCIe)" : \
    (cap_id) == PCI_EXT_CAP_ID_FRSQ ? "FRS Queueing" : \
    (cap_id) == PCI_EXT_CAP_ID_RTR ? "Readiness Time Reporting" : \
    "Unknown"

#endif /* _PCI_REGS_H_ */

