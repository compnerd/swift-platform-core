// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if os(Windows)

import WinSDK
import FoundationEssentials

internal var hNTDLL: HMODULE? {
  "ntdll.dll".withUTF16CString(GetModuleHandleW)
}

public typealias NtQueryInformationProcessTy =
    @convention(c) (HANDLE, PROCESSINFOCLASS, UnsafeMutableRawPointer?, ULONG, UnsafeMutablePointer<ULONG>?) -> NTSTATUS

private func GetNtQueryInformationProcess() -> NtQueryInformationProcessTy? {
  guard let hNTDLL else { return nil }
  return GetProcAddress(hNTDLL, "NtQueryInformationProcess").flatMap {
    return unsafeBitCast($0, to: NtQueryInformationProcessTy.self)
  }
}

package typealias RtlGetVersionTy =
    @convention(c) (UnsafeMutablePointer<RTL_OSVERSIONINFOW>?) -> NTSTATUS

private func GetRtlGetVersion() -> RtlGetVersionTy? {
  guard let hNTDLL else { return nil }
  return GetProcAddress(hNTDLL, "RtlGetVersion").flatMap {
    return unsafeBitCast($0, to: RtlGetVersionTy.self)
  }
}

public let pfnNtQueryInformationProcess: NtQueryInformationProcessTy? =
  GetNtQueryInformationProcess()

package let pfnRtlGetVersion: RtlGetVersionTy? =
  GetRtlGetVersion()

#endif
