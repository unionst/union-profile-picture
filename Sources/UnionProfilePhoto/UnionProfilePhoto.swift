//
//  UnionProfilePhoto.swift
//  UnionProfilePhoto
//
//  Created on 12/28/24.
//

import SwiftUI

public extension View {
    /// Presents an image picker with automatic cropping.
    ///
    /// This modifier presents a sheet containing a photo picker that automatically flows into a crop editor.
    /// The user can select an image from their photo library, then crop it with drag, pinch, and zoom gestures.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the photo picker is presented.
    ///   - image: A binding to the selected and cropped image. Set to `nil` if the user cancels.
    ///   - cropShape: The shape of the crop area. Default is `.circle`.
    ///   - aspectRatio: The aspect ratio of the crop area. Default is `1:1` (square).
    ///   - aspectRatioLocked: Whether the aspect ratio is locked. Default is `true`.
    ///
    /// - Returns: A view that presents the crop image picker.
    ///
    /// Basic Example (Circular):
    /// ```swift
    /// @State private var profileImage: UIImage?
    /// @State private var showPicker = false
    ///
    /// Button("Select Photo") {
    ///     showPicker = true
    /// }
    /// .cropImagePicker(isPresented: $showPicker, image: $profileImage)
    /// ```
    ///
    /// Square Crop Example:
    /// ```swift
    /// .profilePhotoPicker(
    ///     isPresented: $showPicker,
    ///     image: $profileImage,
    ///     cropShape: .square
    /// )
    /// ```
    ///
    /// Custom Aspect Ratio Example:
    /// ```swift
    /// .profilePhotoPicker(
    ///     isPresented: $showPicker,
    ///     image: $profileImage,
    ///     cropShape: .square,
    ///     aspectRatio: CGSize(width: 16, height: 9)
    /// )
    /// ```
    ///
    /// Complete Example:
    /// ```swift
    /// struct ProfileView: View {
    ///     @State private var profileImage: UIImage?
    ///     @State private var showPicker = false
    ///
    ///     var body: some View {
    ///         VStack {
    ///             if let profileImage {
    ///                 Image(uiImage: profileImage)
    ///                     .resizable()
    ///                     .scaledToFill()
    ///                     .frame(width: 200, height: 200)
    ///                     .clipShape(Circle())
    ///             } else {
    ///                 Circle()
    ///                     .fill(.gray.opacity(0.3))
    ///                     .frame(width: 200, height: 200)
    ///                     .overlay {
    ///                         Image(systemName: "person.fill")
    ///                             .font(.system(size: 80))
    ///                             .foregroundStyle(.gray)
    ///                     }
    ///             }
    ///
    ///             Button("Change Photo") {
    ///                 showPicker = true
    ///             }
    ///             .buttonStyle(.borderedProminent)
    ///         }
    ///         .cropImagePicker(isPresented: $showPicker, image: $profileImage)
    ///     }
    /// }
    /// ```
    func cropImagePicker(
        isPresented: Binding<Bool>,
        image: Binding<UIImage?>,
        cropShape: CropShape = .circle,
        aspectRatio: CGSize = CGSize(width: 1, height: 1),
        aspectRatioLocked: Bool = true
    ) -> some View {
        sheet(isPresented: isPresented) {
            CropImagePicker(
                image: image,
                cropShape: cropShape,
                aspectRatio: aspectRatio,
                aspectRatioLocked: aspectRatioLocked
            )
        }
    }
}

