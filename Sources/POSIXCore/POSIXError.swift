// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if !os(Windows)
#if canImport(Glibc)
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
      guard let baseAddress = $0.baseAddress,
        strerror_r(code, baseAddress, $0.count) == 0 else {
        return "POSIX Error \(code)"
      }
      return String(cString: baseAddress)
    }
  }
}

#endif
