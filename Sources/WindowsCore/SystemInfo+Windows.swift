// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if os(Windows)

import WinSDK

public enum SystemInfo {
  public static var PageSize: Int {
    var info = SYSTEM_INFO()
    GetSystemInfo(&info)
    return Int(info.dwPageSize)
  }
}

#endif
