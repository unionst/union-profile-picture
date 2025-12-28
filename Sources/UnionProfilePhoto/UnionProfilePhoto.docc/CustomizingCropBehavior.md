# Customizing Crop Behavior

Fine-tune the cropping experience for your specific use case.

## Overview

UnionProfilePhoto provides sensible defaults that work for most use cases, but you can customize the crop behavior to match your app's needs.

## Crop Shapes

Choose between circular and square cropping:

### Circular Crops

Perfect for profile photos and avatars:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .circle
)
```

### Square Crops

Ideal for posts, thumbnails, and general images:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square
)
```

## Aspect Ratios

Control the shape of the crop area with custom aspect ratios.

### Common Aspect Ratios

**1:1 (Square)**
```swift
aspectRatio: CGSize(width: 1, height: 1)
```

**16:9 (Widescreen)**
```swift
aspectRatio: CGSize(width: 16, height: 9)
```

**4:3 (Traditional)**
```swift
aspectRatio: CGSize(width: 4, height: 3)
```

**3:4 (Portrait)**
```swift
aspectRatio: CGSize(width: 3, height: 4)
```

**21:9 (Cinematic)**
```swift
aspectRatio: CGSize(width: 21, height: 9)
```

### Custom Aspect Ratios

Create any aspect ratio you need:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square,
    aspectRatio: CGSize(width: 5, height: 7)
)
```

## Locking Aspect Ratios

Control whether users can change the aspect ratio.

### Locked (Default)

Users must maintain the specified aspect ratio:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square,
    aspectRatio: CGSize(width: 16, height: 9),
    aspectRatioLocked: true
)
```

### Unlocked

Users can freely adjust the crop area:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square,
    aspectRatioLocked: false
)
```

## Advanced Patterns

### Context-Dependent Cropping

Change crop behavior based on context:

```swift
enum PhotoType {
    case profile, cover, post
    
    var cropShape: CropShape {
        switch self {
        case .profile: return .circle
        case .cover, .post: return .square
        }
    }
    
    var aspectRatio: CGSize {
        switch self {
        case .profile: return CGSize(width: 1, height: 1)
        case .cover: return CGSize(width: 16, height: 9)
        case .post: return CGSize(width: 4, height: 5)
        }
    }
}

struct PhotoUpload: View {
    let photoType: PhotoType
    @State private var image: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        Button("Upload \(photoType)") {
            showPicker = true
        }
        .cropImagePicker(
            isPresented: $showPicker,
            image: $image,
            cropShape: photoType.cropShape,
            aspectRatio: photoType.aspectRatio
        )
    }
}
```

### Multiple Image Pickers

Handle different image types in the same view:

```swift
struct ProfileSetup: View {
    @State private var avatarImage: UIImage?
    @State private var coverImage: UIImage?
    @State private var showAvatarPicker = false
    @State private var showCoverPicker = false
    
    var body: some View {
        VStack {
            Button("Upload Avatar") {
                showAvatarPicker = true
            }
            .cropImagePicker(
                isPresented: $showAvatarPicker,
                image: $avatarImage,
                cropShape: .circle
            )
            
            Button("Upload Cover") {
                showCoverPicker = true
            }
            .cropImagePicker(
                isPresented: $showCoverPicker,
                image: $coverImage,
                cropShape: .square,
                aspectRatio: CGSize(width: 16, height: 9)
            )
        }
    }
}
```

## See Also

- <doc:HowToImplementImageCropping>
- ``CropShape``
- ``SwiftUI/View/cropImagePicker(isPresented:image:cropShape:aspectRatio:aspectRatioLocked:)``

