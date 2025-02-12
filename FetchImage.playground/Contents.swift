import UIKit
//
//func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
//
//
//    URLSession.shared.dataTask(with: url) { data, responce, error in
//        if let data = data, let image = UIImage(data: data) {
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        } else {
//            completion(nil)
//        }
//    }.resume()
//}
//
//func fetchImages(from urls: [String], completion: @escaping ([UIImage?]) -> Void) {
//    var images: [UIImage?] = Array(repeating: nil, count: urls.count)
//    let dispatchGroup = DispatchGroup()
//
//    for (index, urlString) in urls.enumerated() {
//        guard let url = URL(string: urlString) else { continue }
//
//        dispatchGroup.enter()
//
//        fetchImage(from: url, completion: { image in
//            images[index] = image
//            dispatchGroup.leave()
//        })
//
//    }
//
//    dispatchGroup.notify(queue: .main) {
//        completion(images)
//    }
//}


func fetchImage(from urlString: String) async -> UIImage? {
    guard let url = URL(string: urlString) else { return nil }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    } catch {
        print("Error fetching image: \(error)")
        return nil
    }
}

func fetchImages(from urls: [String]) async -> [UIImage?] {
    await withTaskGroup(of: UIImage?.self) { group in
        var images = [UIImage?](repeating: nil, count: urls.count)
        for (index, urlString) in urls.enumerated() {
            group.addTask {
               await fetchImage(from: urlString)
            }

            var index = 0
            for await image in group {
                images[index] = image
                index += 1
            }
        }

        return images
    }

}
/// Example Usage
let imageUrls = [
    "https://combo.staticflickr.com/66a031f9fc343c5e42d965ca/671bc7cb12e93afc27446e4c_grow-1.jpg",
    "https://combo.staticflickr.com/66a031f9fc343c5e42d965ca/66a3f071a6be891c3601e679_photo-9-hm.jpg",
    "https://combo.staticflickr.com/66a031f9fc343c5e42d965ca/66a3ed818a23915310eb11cb_photo-7-hm.jpg"
]
Task {
 let images = await fetchImages(from: imageUrls)
}
