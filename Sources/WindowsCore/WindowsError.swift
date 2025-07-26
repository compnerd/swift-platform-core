// Copyright © 2025 Saleem Abdulrasool <compnerd@compnerd.org>
// SPDX-License-Identifier: BSD-3-Clause

#if os(Windows)

import WinSDK

public struct WindowsError: Error {
  public enum ErrorCode: Sendable {
    case nt(NTSTATUS)
    case win32(DWORD)
    case hresult(HRESULT)
  }

  internal let code: ErrorCode

  public init(_ status: NTSTATUS) {
    self.code = .nt(status)
  }

  public init(_ dwCode: DWORD = GetLastError()) {
    self.code = .win32(dwCode)
  }

  public init(hr: HRESULT) {
    self.code = .hresult(hr)
  }
}

extension WindowsError: CustomStringConvertible {
  public var description: String {
    let dwFlags = FORMAT_MESSAGE_ALLOCATE_BUFFER
                | FORMAT_MESSAGE_FROM_SYSTEM
                | FORMAT_MESSAGE_IGNORE_INSERTS

    var buffer: UnsafeMutablePointer<WCHAR>?
    let dwResult: DWORD
    let short: String

    switch code {
      case let .nt(status):
        short = "NTSTATUS 0x\(String(status, radix: 16))"
        dwResult = withUnsafeMutablePointer(to: &buffer) {
          FormatMessageW(dwFlags | FORMAT_MESSAGE_FROM_HMODULE, hNTDLL,
                         DWORD(status),
                         MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                         UnsafeMutableRawPointer($0)
                             .assumingMemoryBound(to: WCHAR.self),
                         0, nil)
        }

      case let .win32(dwCode):
        short = "Win32 Error \(dwCode)"
        dwResult = withUnsafeMutablePointer(to: &buffer) {
          FormatMessageW(dwFlags, nil, dwCode,
                         MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                         UnsafeMutableRawPointer($0)
                             .assumingMemoryBound(to: WCHAR.self),
                         0, nil)
        }

      case let .hresult(hr):
        short = "HRESULT 0x\(String(hr, radix: 16))"
        dwResult = withUnsafeMutablePointer(to: &buffer) {
          FormatMessageW(dwFlags, nil, DWORD(bitPattern: hr),
                         MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                         UnsafeMutableRawPointer($0)
                            .assumingMemoryBound(to: WCHAR.self),
                         0, nil)
        }

    }

    guard dwResult > 0, let buffer else { return short }

    defer { LocalFree(buffer) }
    return String(decodingCString: buffer, as: UTF16.self)
  }
}

#endif
