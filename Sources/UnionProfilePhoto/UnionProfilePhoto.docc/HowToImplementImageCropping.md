# How to Implement Image Cropping in SwiftUI

Learn how to add professional image cropping functionality to your SwiftUI app.

## Overview

Image cropping is an essential feature in modern iOS apps - from profile pictures to social media posts. This comprehensive guide shows you how to implement image cropping in SwiftUI with just a few lines of code using UnionProfilePhoto.

## What You'll Learn

In this tutorial, you'll learn:

- How to add an image picker with cropping to SwiftUI
- How to implement circular profile photo cropping
- How to customize crop shapes and aspect ratios
- Best practices for displaying cropped images
- How to handle user cancellation

## Prerequisites

- iOS 17.0 or later
- Xcode 15.0 or later
- Basic knowledge of SwiftUI

## Step 1: Install UnionProfilePhoto

First, add the UnionProfilePhoto package to your project:

### Using Xcode

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies**
3. Paste this URL: `https://github.com/unionst/union-profile-picture`
4. Click **Add Package**

### Using Package.swift

Add to your dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/unionst/union-profile-picture.git", from: "1.0.0")
]
```

## Step 2: Import the Package

Add the import statement to your SwiftUI view:

```swift
import SwiftUI
import UnionProfilePhoto
```

## Step 3: Add State Variables

You need two state variables - one for the image and one to control the picker presentation:

```swift
@State private var profileImage: UIImage?
@State private var showPicker = false
```

## Step 4: Add the Crop Image Picker Modifier

Attach the `cropImagePicker` modifier to any view in your SwiftUI hierarchy:

```swift
Button("Select Photo") {
    showPicker = true
}
.cropImagePicker(isPresented: $showPicker, image: $profileImage)
```

That's it! You now have a fully functional image picker with cropping.

## Complete Example: Profile Photo

Here's a complete example for implementing a circular profile photo picker:

```swift
import SwiftUI
import UnionProfilePhoto

struct ProfilePhotoView: View {
    @State private var profileImage: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            profileImageView
            selectButton
        }
        .cropImagePicker(isPresented: $showPicker, image: $profileImage)
    }
    
    @ViewBuilder
    private var profileImageView: some View {
        if let profileImage {
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(radius: 10)
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
    }
    
    private var selectButton: some View {
        Button {
            showPicker = true
        } label: {
            Text(profileImage == nil ? "Add Photo" : "Change Photo")
                .frame(width: 200)
        }
        .buttonStyle(.borderedProminent)
    }
}
```

## Customizing the Crop Shape

### Square Crops

For Instagram-style square crops:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square
)
```

Display the square image:

```swift
if let image {
    Image(uiImage: image)
        .resizable()
        .scaledToFill()
        .frame(width: 300, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 12))
}
```

### Cover Photos (16:9 Aspect Ratio)

Perfect for banner images and cover photos:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $coverImage,
    cropShape: .square,
    aspectRatio: CGSize(width: 16, height: 9)
)
```

Display the cover photo:

```swift
if let coverImage {
    Image(uiImage: coverImage)
        .resizable()
        .scaledToFill()
        .frame(height: 200)
        .clipped()
}
```

### Portrait Photos (4:3 Aspect Ratio)

For traditional portrait orientation:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square,
    aspectRatio: CGSize(width: 3, height: 4)
)
```

### Free-Form Cropping

Allow users to crop at any aspect ratio:

```swift
.cropImagePicker(
    isPresented: $showPicker,
    image: $image,
    cropShape: .square,
    aspectRatioLocked: false
)
```

## Best Practices

### 1. Handle Loading States

Show a loading indicator while processing large images:

```swift
@State private var isLoading = false

if isLoading {
    ProgressView()
} else {
    // Your image view
}
```

### 2. Save Images Efficiently

Convert and save UIImage to file:

```swift
func saveImage(_ image: UIImage) async throws {
    guard let data = image.jpegData(compressionQuality: 0.8) else {
        throw ImageError.compressionFailed
    }
    
    let filename = UUID().uuidString + ".jpg"
    let url = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent(filename)
    
    try data.write(to: url)
}
```

### 3. Optimize Image Size

Resize large images before uploading:

```swift
extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
```

### 4. Add Haptic Feedback

Improve user experience with haptic feedback:

```swift
Button {
    let impact = UIImpactFeedbackGenerator(style: .light)
    impact.impactOccurred()
    showPicker = true
} label: {
    Text("Select Photo")
}
```

## Common Use Cases

### Social Media App

```swift
struct PostCreator: View {
    @State private var postImage: UIImage?
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let postImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 400)
                } else {
                    Text("Tap to add image")
                        .foregroundStyle(.secondary)
                        .frame(height: 400)
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.2))
                        .onTapGesture {
                            showImagePicker = true
                        }
                }
            }
            .cropImagePicker(
                isPresented: $showImagePicker,
                image: $postImage,
                cropShape: .square
            )
            .navigationTitle("New Post")
        }
    }
}
```

### E-Commerce Product Photo

```swift
struct ProductPhotoUpload: View {
    @State private var productImage: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        VStack {
            if let productImage {
                Image(uiImage: productImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 300)
            }
            
            Button("Upload Product Photo") {
                showPicker = true
            }
        }
        .cropImagePicker(
            isPresented: $showPicker,
            image: $productImage,
            cropShape: .square,
            aspectRatio: CGSize(width: 1, height: 1)
        )
    }
}
```

### Business Card Scanner

```swift
struct BusinessCardScanner: View {
    @State private var cardImage: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        VStack {
            Button("Scan Business Card") {
                showPicker = true
            }
        }
        .cropImagePicker(
            isPresented: $showPicker,
            image: $cardImage,
            cropShape: .square,
            aspectRatio: CGSize(width: 3.5, height: 2),
            aspectRatioLocked: true
        )
        .onChange(of: cardImage) { oldValue, newValue in
            if let image = newValue {
                processBusinessCard(image)
            }
        }
    }
    
    func processBusinessCard(_ image: UIImage) {
    }
}
```

## Troubleshooting

### Image Not Appearing

Make sure you're using optional binding correctly:

```swift
if let image = myImage {
    Image(uiImage: image)
}
```

### Picker Not Showing

Verify your `isPresented` binding is set to `true`:

```swift
Button("Show") {
    showPicker = true
}
```

### Image Quality Issues

Adjust the display size and scaling:

```swift
Image(uiImage: image)
    .resizable()
    .scaledToFill()  // or .scaledToFit()
    .frame(width: 200, height: 200)
    .clipped()
```

## Performance Tips

### 1. Lazy Loading

Use `LazyVStack` or `LazyVGrid` when displaying multiple images:

```swift
LazyVGrid(columns: columns) {
    ForEach(images, id: \.self) { image in
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
    }
}
```

### 2. Background Processing

Process images off the main thread:

```swift
Task.detached {
    let processed = processImage(image)
    await MainActor.run {
        self.processedImage = processed
    }
}
```

### 3. Image Caching

Cache processed images to avoid repeated work:

```swift
let cache = NSCache<NSString, UIImage>()

func cachedImage(for key: String) -> UIImage? {
    cache.object(forKey: key as NSString)
}
```

## Conclusion

You've now learned how to implement professional image cropping in SwiftUI using UnionProfilePhoto. The package handles all the complexity of photo picking and cropping, letting you focus on your app's unique features.

## See Also

- <doc:CustomizingCropBehavior>
- <doc:GettingStarted>
- ``SwiftUI/View/cropImagePicker(isPresented:image:cropShape:aspectRatio:aspectRatioLocked:)``

