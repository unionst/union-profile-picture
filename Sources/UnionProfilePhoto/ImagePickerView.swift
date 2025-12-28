import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let dismiss: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let provider = results.first?.itemProvider else {
                parent.dismiss()
                return
            }
            
            guard provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) else {
                parent.dismiss()
                return
            }
            
            provider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                if let error {
                    DispatchQueue.main.async {
                        self.parent.dismiss()
                    }
                    return
                }
                
                guard let sourceURL = url else {
                    DispatchQueue.main.async {
                        self.parent.dismiss()
                    }
                    return
                }
                
                let uniqueFilename = UUID().uuidString + "." + sourceURL.pathExtension
                let temporaryFileURL = FileManager.default.temporaryDirectory.appendingPathComponent(uniqueFilename)

                do {
                    try FileManager.default.copyItem(at: sourceURL, to: temporaryFileURL)
                } catch {
                    DispatchQueue.main.async {
                        self.parent.dismiss()
                    }
                    return
                }

                Task {
                    do {
                        let data = try Data(contentsOf: temporaryFileURL)
                        if let image = UIImage(data: data) {
                            await MainActor.run {
                                self.parent.image = image
                            }
                        } else {
                            await MainActor.run {
                                self.parent.dismiss()
                            }
                        }
                    } catch {
                        await MainActor.run {
                            self.parent.dismiss()
                        }
                    }
                }
            }
        }
    }
}

