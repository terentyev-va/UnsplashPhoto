//
//  PhotosViewController.swift
//  UnsplashPhoto
//
//  Created by Вячеслав Терентьев on 28.06.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let idPhotosCollection = "idPhotosCollection"
    
    var results: [ResultPhoto] = []
    var timer: Timer?
    
    public var testPhotoArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        setNavigationBar()
        setupSearchController()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: idPhotosCollection)
        view.addSubview(collectionView)
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Albums"
        navigationItem.searchController = searchController
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    func fetchPhotos(query: String) {
        
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=OcVkHMcsE5eOqkXQS00m-Oy4iZXNTR9EYHntd2lZraU"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIresponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.test()
                    self?.collectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func test() {
//        let imageURLString = results[indexPath.row].urls.regular
        for urlString in 0..<results.count {
            
            let imageURLString = results[urlString].urls.regular
            
            guard let url = URL(string: imageURLString) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let image = UIImage(data: data) else { return }
    //                self?.imageView.image = image
                    self?.testPhotoArray.append(image)
                    self?.collectionView.reloadData()
                }
            } .resume()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testPhotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let imageURLString = results[indexPath.row].urls.regular
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idPhotosCollection, for: indexPath) as! PhotosCollectionViewCell
        cell.imageView.image = testPhotoArray[indexPath.row]
//        cell.configure(with: imageURLString)
        return cell

    }
}
    
//MARK: - UICollectionViewDelegate

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsPhotoViewController = DetailsPhotoViewController()
        let photo = results[indexPath.row]
        detailsPhotoViewController.detailPhotoResult = photo
        detailsPhotoViewController.photoImageView.image = testPhotoArray[indexPath.row]
        navigationController?.pushViewController(detailsPhotoViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        CGSize(width: collectionView.frame.size.width / 1,
               height: collectionView.frame.size.width / 1)
    }
}

//MARK: - UISearchBarDelegate

extension PhotosViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let text = searchBar.text {
            results = []
            collectionView.reloadData()
            fetchPhotos(query: text)
        }
        print(searchText)
    }
}

//MARK: - SetConstraints

extension PhotosViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
