import UIKit

class MainThreadVC: UIViewController {
    private let url = "https://source.unsplash.com/featured/1920x1080"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = .red
        loading.transform = CGAffineTransformMakeScale(1.75, 1.75)
        return loading
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reload", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(fetchImage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setView()
        
        fetchImage()
    }
    
    private func setView() {
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.widthAnchor.constraint(equalToConstant: 200),
            
            loading.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -36),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.widthAnchor.constraint(equalToConstant: 100),
            loading.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        loading.startAnimating()
    }
    
    @objc
    private func fetchImage() {
        loading.isHidden = false
        
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
