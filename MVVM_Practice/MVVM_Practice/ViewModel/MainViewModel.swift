import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                print("값이 변함A")
                self.listenerA?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listenerA: ((T?) -> Void)?

    func bind( _ listenerB: @escaping ((T?) -> Void)) {
        print("값이 변함B")
        listenerB(value)
        self.listenerA = listenerB
    }
}

class MainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[Movie]> = Observable(nil)
    var dataSource: TredingMoviesModel?
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOFRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    
    func getData() {
        print("1. \(isLoading.value)")
        
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        print("2. \(isLoading.value)")
        
        APICaller.getTrendingMovies { [weak self] result in
            let _ = print("3. \(self?.isLoading.value)")
            
            self?.isLoading.value = false
            
            switch result {
            case .success(let data):
                print("Top Trending Counts: \(data.results.count)")
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.results ?? []
    }
    
    func getMovieTitle(_ movie: Movie) -> String {
        return movie.title ?? movie.name ?? ""
    }
}
