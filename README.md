# UnionProfilePhoto

The easiest way to do profile photo upload/cropping in SwiftUI.

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/union-profile-photo.git", from: "1.0.0")
]
```

## Usage

Dead simple:

```swift
import SwiftUI
import UnionProfilePhoto

struct ContentView: View {
    @State private var profileImage: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        Button("Change Photo") {
            showPicker = true
        }
        .profilePhotoPicker(isPresented: $showPicker, image: $profileImage)
    }
}
```

That's it. One line gets you:
- Photo library picker
- Circular cropping with drag/zoom
- Beautiful native UI

## Requirements

- iOS 17.0+
- Swift 6.0+

## Credits

Built on [TOCropViewController](https://github.com/TimOliver/TOCropViewController) by Tim Oliver.

## License

MIT

