


# DiskUtil
![](https://img.shields.io/badge/version-1.0-brightgreen.svg)

DiskUtil is a simple SwiftPM Package for creating / ejecting / formatting  disk images.
Build using Swift 5.1, XCode 11.3, supports macOS only.

# Usage

The framework provide its functionality through the `DiskUtil` struct. The struct has 3 main static functions:

```swift
///  Creates a disk image from a ram region with a given size in megabytes.
///
///  - Parameter  size: The size of the ram region you want in MB.
///  - Parameter  completion: Completion block containing the result of the process.
///  Returns: The "hardware" `id` of the disk.
public static func createDiskImage(withSize size: Int, completion: @escaping (Response) -> ())

///  Erases an allocated RAM region with a given id to a specific filesystem and mounts it.
///
///  - Parameters:
///  - devicePath: The path that points to the device.
///  - name: The name you want set to your new RAM Disk
///  - fileSystem: the file system in which you want your ram region formatted.
///  - Returns: `true` if erase was successful, `false` if error had occured.
public static func eraseDisk(withDevicePath devicePath: String, name: String, fileSystem: FileSystem, completion: @escaping (Response) -> ())

///  Ejects a ram disk from Finder, destroying all things stored in it.
///
///  - Parameter  devicePath: The id of the disk that you want ejected.
///  - Returns: `true` if eject was successful, `false` otherwise.
public static func ejectDisk(withDevicePath devicePath: String, completion: @escaping (Response) -> ())
```

Each of these 3 functions give back asynchronously object of type `Response` that look like these:
```swift
// MARK: - Response

extension  DiskUtil {

	///  Container holding the output of a terminal task.
	public  struct  Response {

		///  The content of the output pipe after the task has been executed.
		public let output: String

		///  The content of the error pipe after the task has been executed
		public let error: String
		
		///  The task's exit code.
		public  let  terminationStatus: Int32
	}
}
```

# Example

Creating, formatting and ejecting disk image using `DiskUtil`:
```swift
DiskUtil.createDiskImage(withSize: 10) { (responce) in
	guard responce.error.isEmpty else { /* Fail */ return }
	let devicePath = responce.output
	
	DiskUtil.eraseDisk(withDevicePath: devicePath, name: "Test Disk", fileSystem: .apfs) { (responce) in
		guard responce.error.isEmpty else { /* Fail */ return }
		DiskUtil.ejectDisk(withDevicePath: devicePath) { (responce) in
			guard responce.error.isEmpty else { /* Fail */ return }
			/* Success! */
		}
	}
}
```
	
# Installation

### Swift Package Manager

1. Go to your project settings
2. Tap on your Project name above listed targets
3. Open tab swift packages
4. Add DiskUtil's repo as a package.

# Further Information

If you find `DiskUtil` Package helpful, you might as well like [DiskMonitor](https://github.com/stoqn4opm/DiskMonitor).

# Licence

The framework is licensed under MIT licence. For more information see file `LICENCE`
