// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

import WinSDK

extension String {
  /// Calls the given closure with a pointer to the contents of the string,
  /// represented as a null-terminated UTF-16 encoded C string.
  ///
  /// This uses temporary stack allocation when possible, avoiding heap
  /// allocation for reasonably-sized strings.
  ///
  /// - Parameter body: A closure with a pointer parameter that points to a
  ///   null-terminated UTF-16 string. If `body` has a return value, that value
  ///   is also used as the return value for this method.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  public func withUTF16CString<R>(_ body: (UnsafePointer<WCHAR>?) throws -> R) rethrows -> R {
    let count = self.utf16.count
    return try withUnsafeTemporaryAllocation(of: WCHAR.self, capacity: count + 1) { pBuffer in
      if self.utf16.withContiguousStorageIfAvailable({ pSourceBuffer in
        pSourceBuffer.baseAddress?.withMemoryRebound(to: WCHAR.self, capacity: count) { pSource in
          pBuffer.baseAddress?.initialize(from: pSource, count: count)
        }
      }) == nil {
        _ = pBuffer.initialize(from: self.utf16)
      }

      pBuffer[count] = 0 // null terminator
      return try body(pBuffer.baseAddress)
    }
  }
}
