// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if os(macOS) || os(Linux)

#if os(macOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

public struct POSIXError: Error {
  internal let code: CInt

  public init(_ code: CInt = errno) {
    self.code = code
  }
}

extension POSIXError: CustomStringConvertible {
  public var description: String {
    return withUnsafeTemporaryAllocation(of: CChar.self, capacity: 256) {
      guard strerror_r(code, $0.baseAddress, $0.count) == 0,
          let baseAddress = $0.baseAddress else {
        return "POSIX Error \(code)"
      }
      return String(cString: baseAddress)
    }
  }
}

#endif
