// Implement a ViewModel using Combine
// that fetches a list of strings asynchronously
// and publishes them to a SwiftUI view.
// Handle loading and error states

import SwiftUI
import Combine

class StringListViewModel: ObservableObject {

    @Published var items: [String] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()
    private let cache = NSCache<NSURL, NSArray>()

    func fetchItems() {
        guard let url = URL(string: "https://example.com/strings.json") else { return }

        let nsUrl = url as NSURL

        // Check cache first
        if let cachedItems = cache.object(forKey: nsUrl) as? [String] {
            self.items = cachedItems
            return
        }

        isLoading = true
        error = nil

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [String].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.items = result

                self.cache.setObject(items as NSArray, forKey: nsUrl)

            }
            .store(in: &cancellables)
    }

}



struct StringListView: View {
    @StateObject private var viewModel = StringListViewModel()

    var body: some View {
        List(viewModel.items, id: \.self) { item in
            Text(item)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.fetchItems() // <-- call fetchItems here
        }
        .alert("Error", isPresented: Binding<Bool>(
            get: { viewModel.error != nil },
            set: { _ in viewModel.error = nil }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }
    }
}
