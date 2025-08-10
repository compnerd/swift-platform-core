// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if os(macOS)

@_exported
import Darwin

@_transparent
public var ICANON: tcflag_t {
  return tcflag_t(Darwin.ICANON)
}

@_transparent
public var ECHO: tcflag_t {
  return tcflag_t(Darwin.ECHO)
}

@_transparent
public var IXON: tcflag_t {
  return tcflag_t(Darwin.IXON)
}

@_transparent
public var ICRNL: tcflag_t {
  return tcflag_t(Darwin.ICRNL)
}

#endif
