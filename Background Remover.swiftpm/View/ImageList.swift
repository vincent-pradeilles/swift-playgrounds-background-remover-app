import SwiftUI

struct ImageList: View {
    
    @StateObject var viewModel = ImageListViewModel()
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        List {
            if viewModel.rowModels.isEmpty {
                Text("Use the button at the top right to select an image from your gallery 😉")
            }
            ForEach(viewModel.rowModels) { rowModel in
                ImageRow(model: rowModel)
            }
        }
        .listStyle(.plain)
        .navigationTitle("My images")
        .navigationBarItems(trailing: addButton)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { newImage in
            guard let newImage = newImage else { return }
            
            viewModel.removeBackground(from: newImage)
        }
    }
    
    var addButton: some View {
        Button(action: {
            showingImagePicker = true
        }) {
            Image(systemName: "plus")
        }
    }
}
