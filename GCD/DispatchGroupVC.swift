import UIKit

class DispatchGroupVC: UIViewController {
    var items = [String]()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "table_cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        fetchFood()
    }

    func fetchFood() {
        
    }
}

extension DispatchGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "table_cell", for: indexPath) as? UITableViewCell {
            let label = items[indexPath.row]
            cell.textLabel?.text = label
            return cell
        }
        return UITableViewCell()
    }
}
