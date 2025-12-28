import SwiftUI

public extension View {
    func profilePhotoPicker(isPresented: Binding<Bool>, image: Binding<UIImage?>) -> some View {
        sheet(isPresented: isPresented) {
            ProfilePhotoPicker(image: image)
        }
    }
}

