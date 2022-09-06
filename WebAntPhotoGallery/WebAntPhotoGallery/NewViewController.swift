//
//  NewViewController.swift
//  WebAntPhotoGallery
//
//  Created by asbul on 29.08.2022.
//

import UIKit

final class NewViewController: UIViewController {

    let screenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.1725490196, green: 0.09411764706, blue: 0.3882352941, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        label.text = "Popular" // This property should be changed
        return label
    }()

    var galleryCollectionView = GalleryCollectionView()
    let networkService = WebAntAPI.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5881755352, green: 0.5882772803, blue: 0.5881621242, alpha: 1)
        setupViews()

        networkService.getPhotos { [weak self] result in
            switch result {
            case .success(let photos):
                self?.galleryCollectionView.set(cells: photos)

                DispatchQueue.main.async {
                    self?.galleryCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
//        galleryCollectionView.set(cells: <#T##[Photo]#>)
//        WebAntAPI.shared.getPhotos()

    }
    
    private func setupViews() {
        view.addSubview(screenLabel)
        view.addSubview(galleryCollectionView)

        screenLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        screenLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        screenLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        screenLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 8).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        galleryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
