import SwiftUI

enum ImageToDisplay {
    case original
    case result
}

struct ImageDetailView: View {
    
    let model: ImageDetailModel
    
    @State private var imageToDisplay = ImageToDisplay.result
    
    var body: some View {
        VStack {
            Picker("Image selection", selection: $imageToDisplay) {
                Text("Before")
                    .tag(ImageToDisplay.original)
                Text("After")
                    .tag(ImageToDisplay.result)
            }
            .pickerStyle(.segmented)
            
            let image: UIImage = resultOf {
                switch imageToDisplay {
                case .original:
                    return model.orginal
                case .result:
                    return model.result
                }
            }
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity)
        }
        .safeAreaInset(edge: .bottom) {
            Image("PhotoRoom")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
