//
//  SectionCell.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 28/08/22.
//

import UIKit

class SectionCell: UITableViewCell {
    private typealias MovieDataSource = UICollectionViewDiffableDataSource<Int, Movie>
    private typealias MovieSnapshot = NSDiffableDataSourceSnapshot<Int, Movie>
    private typealias TVDataSource = UICollectionViewDiffableDataSource<Int, TVSeries>
    private typealias TVSnapshot = NSDiffableDataSourceSnapshot<Int, TVSeries>
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    static let CELL_HEIGHT: CGFloat = 250
    
    private var viewModel: SectionCellVM!
    private var movieDataSource: MovieDataSource!
    private var tvDataSource: TVDataSource!
    
    private var movieSelectHandler: ((Movie) -> Void)?
    private var tvSelectHandler: ((TVSeries) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        listCollectionView.delegate = self
        listCollectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: ItemCell.REUSE_IDENTIFIER)
    }
    
    func setupContents(with viewModel: SectionCellVM) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        
        if viewModel.type == .movie {
            setupMovieDataSource()
            setupSnapshot(movies: viewModel.movies!)
        } else {
            setupTVDataSource()
            setupSnapshot(tv: viewModel.tvSeries!)
        }
    }
    
    func addMovieSelectHandler(handler: @escaping (Movie) -> Void) {
        movieSelectHandler = handler
    }
    
    func addTVSelectHandler(handler: @escaping (TVSeries) -> Void) {
        tvSelectHandler = handler
    }
    
    private func setupMovieDataSource() {
        movieDataSource = MovieDataSource(collectionView: listCollectionView, cellProvider: { collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.REUSE_IDENTIFIER, for: indexPath) as! ItemCell
            cell.setupContents(with: ItemCellVM(imagePath: model.posterPath ?? "", title: model.title ?? ""))
            return cell
        })
    }
    
    private func setupTVDataSource() {
        tvDataSource = TVDataSource(collectionView: listCollectionView, cellProvider: { collectionView, indexPath, model in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.REUSE_IDENTIFIER, for: indexPath) as! ItemCell
            cell.setupContents(with: ItemCellVM(imagePath: model.posterPath ?? "", title: model.name ?? ""))
            return cell
        })
    }
    
    private func setupSnapshot(movies: [Movie]) {
        var snapshot = MovieSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(movies)
        movieDataSource.apply(snapshot)
    }
    
    private func setupSnapshot(tv: [TVSeries]) {
        var snapshot = TVSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(tv)
        tvDataSource.apply(snapshot)
    }
    
}

extension SectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.type == .movie {
            if let movie = movieDataSource.itemIdentifier(for: indexPath), let handler = movieSelectHandler {
                handler(movie)
            }
        } else {
            if let tv = tvDataSource.itemIdentifier(for: indexPath), let handler = tvSelectHandler {
                handler(tv)
            }
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
