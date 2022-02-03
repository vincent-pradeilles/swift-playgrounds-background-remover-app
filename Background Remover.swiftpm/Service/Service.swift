import Foundation
import Alamofire
import UIKit

enum BackgroundServiceError: Error {
    case badURL
    case couldNotEncodeImage
    case couldNotDecodeImage
}

enum BackgroundRemovalServiceResponse {
    case success(UIImage)
    case progress(Double)
    case error(Error)
}

class BackgroundRemovalService {
    
#error("get your API key 👉 https://www.photoroom.com/api/")
    static let apiKey = "REPLACE_WITH_YOUR_API_KEY"
    
    func removeBackground(from image: UIImage, _ handler: @escaping (BackgroundRemovalServiceResponse) -> Void) {
        guard let url = URL(string: "https://sdk.photoroom.com/v1/segment") else {
            assertionFailure("Bad endpoint URL")
            handler(.error(BackgroundServiceError.badURL))
            return
        }
        
        guard let jpegData = image.jpegData(compressionQuality: 0.7) else {
            assertionFailure("Couldn't encode image to JPEG")
            handler(.error(BackgroundServiceError.couldNotEncodeImage))
            return
        }
        
        
        let headers: HTTPHeaders = [
            .init(name: "x-api-key", value: BackgroundRemovalService.apiKey),
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(jpegData, withName: "image_file", fileName: "file.png", mimeType: "image/jpg")
        }, to: url, method: .post, headers: headers)
            .uploadProgress { progress in
                // divide by 2 because upload is first half of networking process
                handler(.progress(progress.fractionCompleted / 2.0))
            }
            .downloadProgress { progress in
                // divide by 2 and add 0.5 because download is second half of networking process
                handler(.progress(0.5 + (progress.fractionCompleted / 2.0)))
            }
            .responseData { response in
                debugPrint(response)
                switch response.result {
                case let .success(data):
                    guard let decodedImage = UIImage(data: data) else {
                        handler(.error(BackgroundServiceError.couldNotDecodeImage))
                        return
                    }
                    handler(.success(decodedImage))
                case let .failure(error):
                    handler(.error(error))
                }
            }
    }
}


