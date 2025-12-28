# UnionProfilePhoto

The easiest way to do profile photo upload and cropping in SwiftUI.

One line. That's it.

```swift
.profilePhotoPicker(isPresented: $showPicker, image: $profileImage)
```

## Features

- 📸 **Photo Library Picker** - Native PHPicker integration
- ✂️ **Circular Cropping** - Drag, pinch, and zoom gestures
- 🎨 **Beautiful UI** - Native iOS design with smooth animations
- 🔄 **Auto Flow** - Pick → Crop → Done automatically
- ⚡️ **Modern APIs** - Async/await, iOS 17+
- 🎯 **Zero Config** - Works perfectly out of the box

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/unionst/union-profile-picture.git", from: "1.0.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/unionst/union-profile-picture`
3. Add to your target

## Usage

### Basic Example

```swift
import SwiftUI
import UnionProfilePhoto

struct ContentView: View {
    @State private var profileImage: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        Button("Select Photo") {
            showPicker = true
        }
        .profilePhotoPicker(isPresented: $showPicker, image: $profileImage)
    }
}
```

### Complete Example

```swift
import SwiftUI
import UnionProfilePhoto

struct ProfileView: View {
    @State private var profileImage: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(.gray.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.gray)
                    }
            }
            
            Button("Change Photo") {
                showPicker = true
            }
            .buttonStyle(.borderedProminent)
        }
        .profilePhotoPicker(isPresented: $showPicker, image: $profileImage)
    }
}
```

## How It Works

1. User taps your button/view
2. Native photo picker appears
3. User selects a photo
4. Crop editor automatically appears
5. User adjusts with drag/pinch/zoom
6. Done! You get the cropped `UIImage`

Cancel at any point and `image` binding returns `nil`.

## Requirements

- iOS 17.0+
- Swift 6.0+
- Xcode 15.0+

## Credits

Built on top of [TOCropViewController](https://github.com/TimOliver/TOCropViewController) by Tim Oliver - the battle-tested cropping library used by thousands of apps.

## License

MIT License - see LICENSE file for details.

## Contributing

Issues and pull requests welcome! This is a simple library focused on doing one thing really well.
