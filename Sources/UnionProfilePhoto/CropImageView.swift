//
//  CropImageView.swift
//  UnionProfilePhoto
//
//  Created on 12/28/24.
//

import SwiftUI
import CropViewController

struct CropImageView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let cropShape: CropShape
    let aspectRatio: CGSize
    let aspectRatioLocked: Bool
    var dismiss: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> CropViewController {
        guard let image else {
            return CropViewController(image: UIImage())
        }
        
        let cropController = CropViewController(
            croppingStyle: cropShape.croppingStyle,
            image: image
        )
        cropController.customAspectRatio = aspectRatio
        cropController.aspectRatioLockEnabled = aspectRatioLocked
        cropController.aspectRatioPickerButtonHidden = true
        cropController.cancelButtonColor = .white
        cropController.resetButtonHidden = true
        cropController.delegate = context.coordinator
        return cropController
    }

    func updateUIViewController(_ uiViewController: CropViewController, context: Context) { }

    class Coordinator: NSObject, CropViewControllerDelegate {
        var parent: CropImageView

        init(_ parent: CropImageView) {
            self.parent = parent
        }
        
        func cropViewController(
            _ cropViewController: CropViewController,
            didCropToImage image: UIImage,
            withRect cropRect: CGRect,
            angle: Int
        ) {
            parent.image = image
            parent.dismiss()
        }
        
        func cropViewController(
            _ cropViewController: CropViewController,
            didFinishCancelled cancelled: Bool
        ) {
            if cancelled {
                parent.image = nil
            }
        }
    }
}

