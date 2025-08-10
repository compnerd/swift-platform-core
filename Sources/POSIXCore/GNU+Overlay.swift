// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if os(Linux)

#if GNU

@_exported
import Glibc

@_transparent
package var _SC_PAGESIZE: CInt {
  CInt(Glibc._SC_PAGESIZE)
}

#endif

#endif
