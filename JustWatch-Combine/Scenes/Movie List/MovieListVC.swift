//
//  MovieListVC.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import UIKit
import Combine

class MovieListVC: UITableViewController {
    // MARK: - Diffable data source typealias
    private typealias DataSource = UITableViewDiffableDataSource<MovieListVM.Section, MovieList>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<MovieListVM.Section, MovieList>
    
    // MARK: - Properties
    private var viewModel: MovieListVM
    private var bindings = Set<AnyCancellable>()
    
    private var dataSource: DataSource!
    
    // MARK: - Initializers
    init() {
        viewModel = MovieListVM()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = MovieListVM()
        super.init(coder: coder)
    }
    
    // MARK: - Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
    }
    
    // MARK: - Setup functions
    private func setupUI() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func setupBindings() {
        Task {
            await viewModel.fetchData()
        }
        
        viewModel.$isFetchingData
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                if !value {
                    self?.setupSnapshot()
                }
            }.store(in: &bindings)
    }
    
    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "SectionCell", bundle: nil), forCellReuseIdentifier: SectionCell.REUSE_IDENTIFIER)
        
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionCell.REUSE_IDENTIFIER) as! SectionCell
            let title: String
            switch indexPath.section {
            case 0:
                title = "Popular"
            case 1:
                title = "Now Playing"
            case 2:
                title = "Upcoming"
            default:
                title = "Unknown"
            }
            cell.setupContents(with: SectionCellVM(type: .movie, title: title, movies: itemIdentifier.results!))
            cell.addMovieSelectHandler(handler: { [unowned self] movie in
                self.navigationController?.pushViewController(MovieDetailVC(movieId: movie.ID ?? 0), animated: true)
            })
            return cell
        })
    }
    
    private func setupSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.popular, .nowPlaying, .upcoming])
        snapshot.appendItems(viewModel.popular, toSection: .popular)
        snapshot.appendItems(viewModel.nowPlaying, toSection: .nowPlaying)
        snapshot.appendItems(viewModel.upcoming, toSection: .upcoming)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Actions
    @objc private func refreshAction() {
        Task {
            await viewModel.fetchData()
        }
        refreshControl?.endRefreshing()
    }
}

// MARK: - Table view delegate
extension MovieListVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SectionCell.CELL_HEIGHT
    }
}
