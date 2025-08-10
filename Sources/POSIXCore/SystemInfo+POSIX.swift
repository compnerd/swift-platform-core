// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if !os(Windows)

public enum SystemInfo {
  public static var PageSize: Int {
#if os(macOS)
    return Int(sysconf(_SC_PAGESIZE))
#else
    precondition(false, "Unable to query page size on this platform")
#endif
  }
}

#endif
