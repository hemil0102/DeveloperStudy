import UIKit

class MainViewController: UIViewController {

    //IBOutlets:
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //ViewModel:
    var viewModel: MainViewModel = MainViewModel()
    
    //variables:
    var cellDataSource: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
    }
    
    func configView() {
        self.title = "Main View"
        self.view.backgroundColor = .red
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            print("테스트")
            guard let self = self, let isLoading = isLoading else {
                return
            }
            
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else {
                return
            }
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
}
