import SwiftUI

public struct ProfilePhotoPicker: View {
    @Binding var image: UIImage?
    @Environment(\.dismiss) var dismiss
    
    var presentCrop: Binding<Bool> {
        Binding {
            image != nil
        } set: { newValue in
            if !newValue {
                image = nil
            }
        }
    }
    
    public init(image: Binding<UIImage?>) {
        self._image = image
    }
    
    public var body: some View {
        NavigationStack {
            ImagePickerView(image: $image) {
                dismiss()
            }
            .navigationDestination(isPresented: presentCrop) {
                CropImageView(image: $image) {
                    dismiss()
                }
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

