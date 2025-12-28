# Getting Started

Add image cropping to your SwiftUI app in minutes.

## Overview

UnionProfilePhoto makes it incredibly easy to add photo picking and cropping functionality to your SwiftUI app. This guide will walk you through installation and basic usage.

## Installation

### Swift Package Manager

Add UnionProfilePhoto to your project using Swift Package Manager:

1. In Xcode, select **File → Add Package Dependencies**
2. Enter the repository URL: `https://github.com/unionst/union-profile-picture`
3. Select the version you want to use (recommended: latest)
4. Add the package to your target

Or add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/unionst/union-profile-picture.git", from: "1.0.0")
]
```

## Basic Usage

### Circular Profile Photo Cropping

The most common use case - cropping a circular profile photo:

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
            }
            
            Button("Change Photo") {
                showPicker = true
            }
            .buttonStyle(.borderedProminent)
        }
        .cropImagePicker(isPresented: $showPicker, image: $profileImage)
    }
}
```

### Square Crop

For square thumbnails or posts:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square
)
```

### Custom Aspect Ratio

For cover photos, banners, or custom layouts:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square,
    aspectRatio: CGSize(width: 16, height: 9)
)
```

## How It Works

When you present the crop image picker:

1. **Photo Picker Appears** - Native PHPicker lets users select from their library
2. **Automatic Navigation** - Selected image automatically flows to crop editor
3. **Crop and Adjust** - Users can drag, pinch, and zoom to adjust the crop
4. **Done** - Cropped image is returned to your binding

If the user cancels at any point, the binding is set to `nil`.

## Next Steps

- <doc:HowToImplementImageCropping> - SEO-optimized detailed guide
- <doc:CustomizingCropBehavior> - Advanced customization options

