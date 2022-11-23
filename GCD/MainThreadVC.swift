import UIKit

class MainThreadVC: UIViewController {
    private let url = "https://source.unsplash.com/featured/1920x1080"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var loading = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setView()
        
        fetchImage()
    }
    
    private func setView() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(loading)
        loading.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        loading.center = view.center
        loading.color = .red
        loading.startAnimating()
    }
    
    private func fetchImage() {
        guard let url = URL(string: url) else { return }
        
        // background thread
        
        URLSession(configuration: .default).dataTask(with: url, completionHandler: { data, _, _ in
            guard let data = data else {
                return
            }

            let image = UIImage(data: data)
            
            // Main thread
            DispatchQueue.main.async {
                self.imageView.image = image
                self.loading.isHidden = true
            }
                
        }).resume()
    }
}
