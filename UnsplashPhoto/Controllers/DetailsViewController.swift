//
//  DetailsViewController.swift
//  UnsplashPhoto
//
//  Created by Вячеслав Терентьев on 28.06.2022.
//

import UIKit

class DetailsPhotoViewController: UIViewController {
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "saveButton"), for: .normal)
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameAuthorLabel = UILabel(text: "Name Author:")
    private let nameLabel = UILabel(text: "")
    private let dateLabel = UILabel(text: "Date:")
    private let dateInfoLabel = UILabel(text: "")
    private let cityLabel = UILabel(text: "City:")
    private let cityInfoLabel = UILabel(text: "")
    private let likesLabel = UILabel(text: "Likes:")
    private let likesInfoLabel = UILabel(text: "")
    
    private var infoPhotoStackView = UIStackView()
    private var nameInfoStackView = UIStackView()
    private var dateInfoStackView = UIStackView()
    private var cityInfoStackView = UIStackView()
    private var likesInfoStackView = UIStackView()
    
    var detailPhotoResult: ResultPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setModel()
    }
    
    private func setupViews() {
        title = "Photo"
        view.backgroundColor = .black
        
        view.addSubview(photoImageView)
        
        nameInfoStackView = UIStackView(arragedSubiews: [nameAuthorLabel, nameLabel],
                                        axis: .horizontal,
                                        spacing: 10,
                                        distribution: .fill)
        
        dateInfoStackView = UIStackView(arragedSubiews: [dateLabel, dateInfoLabel],
                                        axis: .horizontal,
                                        spacing: 10,
                                        distribution: .fill)
        
        cityInfoStackView = UIStackView(arragedSubiews: [cityLabel,cityInfoLabel],
                                        axis: .horizontal,
                                        spacing: 10,
                                        distribution: .fill)
        
        likesInfoStackView = UIStackView(arragedSubiews: [likesLabel, likesInfoLabel],
                                         axis: .horizontal,
                                         spacing: 10,
                                         distribution: .fill)

        infoPhotoStackView = UIStackView(arragedSubiews: [nameInfoStackView, dateInfoStackView, cityLabel, likesInfoStackView],
                                         axis: .vertical,
                                         spacing: 10,
                                         distribution: .fillProportionally)
        view.addSubview(infoPhotoStackView)
        view.addSubview(saveButton)
    }
    
    private func configure(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.photoImageView.image = image
            }
        } .resume()
    }
    
    private func setModel() {
        
        guard detailPhotoResult != nil else { return }
        
        nameLabel.text = detailPhotoResult?.user.name
        cityInfoLabel.text = detailPhotoResult!.user.location
        likesInfoLabel.text = "\(detailPhotoResult!.likes)"
        dateInfoLabel.text = detailPhotoResult?.created_at
    }
    
    @objc private func saveButtonTapped() {
        print("save")
    }
}

extension DetailsPhotoViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            photoImageView.heightAnchor.constraint(equalToConstant: 400),
            photoImageView.widthAnchor.constraint(equalToConstant: 400)
        ])
        
        NSLayoutConstraint.activate([
            infoPhotoStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            infoPhotoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            infoPhotoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            infoPhotoStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: infoPhotoStackView.bottomAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 25),
            saveButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
