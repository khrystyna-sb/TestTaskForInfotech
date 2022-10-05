//
//  CityTableViewCell.swift
//  TestTaskForInfotech
//
//  Created by Khrystyna Matasova on 14.09.2022.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let indent: CGFloat = 10.0
        static let spacing: CGFloat = 15
    }
    
    static let identifier = "CityTableViewCell"
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var picture: LoadingImageView = {
        let imageView = LoadingImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerStackView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainerStackView() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(picture)
        containerStackView.addArrangedSubview(cityNameLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indent),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.indent),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent),
        ])
    }
    
    public func configure(with model: CityViewModel) {
        self.cityNameLabel.text = model.name
        self.picture.loadImage(mainPath: model.url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityNameLabel.text = ""
        self.picture.cancelLoading()
    }
}
