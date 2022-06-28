//
//  PhotoDetailsInfoCell.swift
//  UnsplashPhoto
//
//  Created by Вячеслав Терентьев on 28.06.2022.
//

import UIKit

class PhotoDetailsInfoCell: UITableViewCell {
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameAuthor: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = "Name Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(photoImageView)
        addSubview(nameAuthor)
    }
}

extension PhotoDetailsInfoCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            photoImageView.heightAnchor.constraint(equalToConstant: 70),
            photoImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            nameAuthor.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            nameAuthor.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
