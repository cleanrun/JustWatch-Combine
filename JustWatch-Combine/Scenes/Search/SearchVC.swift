//
//  SearchVC.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 01/09/22.
//

import UIKit
import Combine

class SearchVC: UIViewController {
    // MARK: - Diffable data source typealias
    private typealias MovieDataSource = UITableViewDiffableDataSource<Int, Movie>
    private typealias TVDataSource = UITableViewDiffableDataSource<Int, TVSeries>
    private typealias MovieSnapshot = NSDiffableDataSourceSnapshot<Int, Movie>
    private typealias TVSnapshot = NSDiffableDataSourceSnapshot<Int, TVSeries>
    
    // MARK: - IBOutlets and UI Components
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    // MARK: - Variables
    private var viewModel: SearchVM
    private var bindings = Set<AnyCancellable>()
    
    private var movieDataSource: MovieDataSource!
    private var tvDataSource: TVDataSource!
    
    // MARK: - Initializers
    init() {
        viewModel = SearchVM()
        super.init(nibName: "SearchVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = SearchVM()
        super.init(coder: coder)
    }
    
    // MARK: - Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
    }

    // MARK: - Setup Functions
    private func setupUI() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupBindings() {
        searchField.textPublisher
            .debounce(for: 0.5, scheduler: RunLoop.current)
            .sink { [weak viewModel] value in
                if !value.isEmpty {
                    Task {
                        await viewModel?.getSearchResult(query: value)
                    }
                }
            }.store(in: &bindings)
        
        searchTypeSegmentedControl.selectedIndexPublisher
            .sink { [weak viewModel] value in
                viewModel?.setSearchType(SearchVM.SearchType(rawValue: value) ?? .movie)
            }.store(in: &bindings)
        
        viewModel.$loadingState
            .receive(on: RunLoop.main)
            .sink { [weak resultsTableView, weak loadingIndicator, weak notFoundLabel] value in
                resultsTableView?.isHidden = !(value == .fetched)
                loadingIndicator?.isHidden = !(value == .loading)
                notFoundLabel?.isHidden = !(value == .noData)
                
                value == .loading ? loadingIndicator?.startAnimating() : loadingIndicator?.stopAnimating()
            }.store(in: &bindings)
        
        viewModel.$movieResult
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                if !value.isEmpty {
                    self?.setupMovieDataSource()
                    self?.setupMovieSnapshot(value)
                }
            }.store(in: &bindings)
        
        viewModel.$tvResult
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                if !value.isEmpty {
                    self?.setupTVDataSource()
                    self?.setupTVSnapshot(value)
                }
            }.store(in: &bindings)
    }
    
    private func setupTableView() {
        resultsTableView.delegate = self
        resultsTableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: SearchResultCell.REUSE_IDENTIFIER)
    }
    
    private func setupMovieDataSource() {
        movieDataSource = MovieDataSource(tableView: resultsTableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.REUSE_IDENTIFIER) as! SearchResultCell
            cell.setupContents(viewModel: SearchResultCellVM(movie: item))
            return cell
        })
    }
    
    private func setupTVDataSource() {
        tvDataSource = TVDataSource(tableView: resultsTableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.REUSE_IDENTIFIER) as! SearchResultCell
            cell.setupContents(viewModel: SearchResultCellVM(tvSeries: item))
            return cell
        })
    }
    
    private func setupMovieSnapshot(_ movies: [Movie]) {
        var snapshot = MovieSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(movies)
        movieDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupTVSnapshot(_ tvSeries: [TVSeries]) {
        var snapshot = TVSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(tvSeries)
        tvDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Custom Functions
    private func routeToMovieDetail(movieId: Int) {
        navigationController?.pushViewController(MovieDetailVC(movieId: movieId), animated: true)
    }
    
    private func routeToTVDetail(tvId: Int) {
        self.navigationController?.pushViewController(TVDetailVC(tvId: tvId), animated: true)
    }
    
}

// MARK: - Table view delegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SearchResultCell.CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.searchType == .movie {
            routeToMovieDetail(movieId: movieDataSource.itemIdentifier(for: indexPath)?.ID ?? 0)
        } else {
            routeToTVDetail(tvId: tvDataSource.itemIdentifier(for: indexPath)?.ID ?? 0)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
