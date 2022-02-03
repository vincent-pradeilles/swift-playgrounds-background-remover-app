import Foundation
import UIKit

class ImageListViewModel: ObservableObject {
    
    @Published var rowModels: [ImageRowModel] = []
    
    let backgroundRemovalService = BackgroundRemovalService()
    
    func removeBackground(from image: UIImage) {
        let newRowModel = ImageRowModel(original: image)
        
        rowModels.append(newRowModel)
        
        backgroundRemovalService.removeBackground(from: image) { [weak self] response in
            guard let index = self?.rowModels.firstIndex(where: { $0.original == image }) else {
                return
            }
            
            self?.rowModels[index].result = resultOf {
                switch response {
                case let .success(image):
                    return .result(image)
                case let .progress(progress):
                    return .progress(progress)
                case let .error(error):
                    debugPrint(error)
                    return .error
                }
            }
        }
    }
}
