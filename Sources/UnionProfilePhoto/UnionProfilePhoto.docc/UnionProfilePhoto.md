# ``UnionProfilePhoto``

The easiest way to crop images in SwiftUI.

## Overview

UnionProfilePhoto provides a dead-simple image cropping experience for SwiftUI apps. With just one line of code, you get a complete photo picking and cropping flow with beautiful native UI.

```swift
.cropImagePicker(isPresented: $showPicker, image: $image)
```

### Key Features

- **📸 Native Photo Picker** - Uses PHPicker for seamless photo selection
- **✂️ Flexible Cropping** - Circle or square crop shapes
- **📐 Custom Aspect Ratios** - Support for 1:1, 16:9, 4:3, or any custom ratio
- **🔓 Locked or Free Crop** - Lock aspect ratio or enable free-form cropping
- **🎨 Beautiful UI** - Native iOS design with smooth animations
- **🔄 Automatic Flow** - Pick → Crop → Done with no extra code
- **⚡️ Modern APIs** - Built with async/await for iOS 17+

### Quick Start

Import the package and add the modifier to any view:

```swift
import SwiftUI
import UnionProfilePhoto

struct ContentView: View {
    @State private var image: UIImage?
    @State private var showPicker = false
    
    var body: some View {
        Button("Select Photo") {
            showPicker = true
        }
        .cropImagePicker(isPresented: $showPicker, image: $image)
    }
}
```

## Topics

### Getting Started

- <doc:GettingStarted>
- <doc:HowToImplementImageCropping>

### Essentials

- ``SwiftUI/View/cropImagePicker(isPresented:image:cropShape:aspectRatio:aspectRatioLocked:)``
- ``CropShape``

### Advanced Usage

- <doc:CustomizingCropBehavior>

