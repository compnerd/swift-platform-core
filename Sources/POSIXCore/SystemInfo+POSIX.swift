// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if !os(Windows)

public enum SystemInfo {
  public static var PageSize: Int {
#if os(macOS) || GNU
    return Int(sysconf(_SC_PAGESIZE))
#else
    precondition(false, "Unable to query page size on this platform")
    return -1 // Compiler error: Cannot convert return expression of type '()' to return type 'Int'
#endif
  }
}

#endif
