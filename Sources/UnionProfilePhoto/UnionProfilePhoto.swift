import SwiftUI

public extension View {
    /// Presents a profile photo picker with automatic cropping.
    ///
    /// This modifier presents a sheet containing a photo picker that automatically flows into a circular crop editor.
    /// The user can select an image from their photo library, then crop it to a circular profile photo with drag, pinch, and zoom gestures.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the photo picker is presented.
    ///   - image: A binding to the selected and cropped image. Set to `nil` if the user cancels.
    ///
    /// - Returns: A view that presents the profile photo picker.
    ///
    /// Basic Example:
    /// ```swift
    /// @State private var profileImage: UIImage?
    /// @State private var showPicker = false
    ///
    /// Button("Select Photo") {
    ///     showPicker = true
    /// }
    /// .profilePhotoPicker(isPresented: $showPicker, image: $profileImage)
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
    ///         .profilePhotoPicker(isPresented: $showPicker, image: $profileImage)
    ///     }
    /// }
    /// ```
    func profilePhotoPicker(isPresented: Binding<Bool>, image: Binding<UIImage?>) -> some View {
        sheet(isPresented: isPresented) {
            ProfilePhotoPicker(image: image)
        }
    }
}

