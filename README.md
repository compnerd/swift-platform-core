# swift-platform-core

A Swift library providing access to low-level system APIs across Windows, macOS, and Linux platforms.

## Features

- Type-safe wrappers around system APIs
- Cross-platform system information
- Platform-specific error handling
- Modular design with separate Windows and POSIX modules

## Usage

### Cross-Platform System Information
```swift
import POSIXCore      // macOS, Linux
import WindowsCore    // Windows

let pageSize = SystemInfo.PageSize
```

### Error Handling
```swift
// POSIX platforms
guard ... else {
  throw POSIXError() // implicitly captures `errno`
}

// Windows platform  
guard ... else {
  throw WindowsError() // implicitly captures 'GetlastError()`
}
```

## Requirements

- Swift 6.0+
- Platforms:
  - Windows 10+
  - macOS 10.15+
  - Linux

## Modules

- **POSIXCore** - macOS and Linux support
  - POSIX API constants
  - POSIX error wrapper  

- **WindowsCore** - Windows support
  - Win32 API constants
  - Windows error wrapper
  - NT API function accessors

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
