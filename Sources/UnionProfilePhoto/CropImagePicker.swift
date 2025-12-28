//
//  CropImagePicker.swift
//  UnionProfilePhoto
//
//  Created on 12/28/24.
//

import SwiftUI

public struct CropImagePicker: View {
    @Binding var image: UIImage?
    let cropShape: CropShape
    let aspectRatio: CGSize
    let aspectRatioLocked: Bool
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedImage: UIImage?
    @State private var showCropView = false
    
    public init(
        image: Binding<UIImage?>,
        cropShape: CropShape = .circle,
        aspectRatio: CGSize = CGSize(width: 1, height: 1),
        aspectRatioLocked: Bool = true
    ) {
        self._image = image
        self.cropShape = cropShape
        self.aspectRatio = aspectRatio
        self.aspectRatioLocked = aspectRatioLocked
    }
    
    public var body: some View {
        NavigationStack {
            ImagePickerView(image: $selectedImage) {
                dismiss()
            }
            .navigationDestination(isPresented: $showCropView) {
                CropImageView(
                    image: $selectedImage,
                    cropShape: cropShape,
                    aspectRatio: aspectRatio,
                    aspectRatioLocked: aspectRatioLocked
                ) {
                    if let selectedImage {
                        image = selectedImage
                    }
                    dismiss()
                }
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
            .onChange(of: selectedImage) { oldValue, newValue in
                if newValue != nil {
                    showCropView = true
                }
            }
        }
        .ignoresSafeArea()
    }
}

