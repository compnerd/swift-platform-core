// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if !os(Windows)

public enum SystemInfo {
  public static var PageSize: Int {
    return Int(sysconf(_SC_PAGESIZE))
  }
}

#endif
