//
//  FurnitureCollectionViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 11.08.22.
//

import UIKit

class FurnitureCollectionViewCell: UICollectionViewCell {
    static public var id = "FurnitureCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
    }
    private lazy var bigImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
        
        
    }()
    private lazy var bigText : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.textColor = .myLightGrey
        textView.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        textView.isEditable = false
        return textView
    }()
    private lazy var littleImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true

        return image
        
        
    }()
    private lazy var littleText : UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.textColor = .myLightGrey
        textView.font = UIFont(name: "Gilroy", size: FontSizes.font14)
        textView.isEditable = false
        return textView
    }()
    private func addViews(){
        contentView.addSubview(bigImage)
        contentView.addSubview(bigText)
        contentView.addSubview(littleImage)
        contentView.addSubview(littleText)
        
    }
    private func setConstraints(){
        
        bigImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 40).isActive = true
        bigImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        bigImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        bigImage.heightAnchor.constraint(equalToConstant: frame.height * 0.4).isActive = true
        bigText.topAnchor.constraint(equalTo: bigImage.bottomAnchor,constant: 10).isActive = true
        bigText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        bigText.widthAnchor.constraint(equalToConstant: frame.width * 0.8).isActive = true
        bigText.heightAnchor.constraint(equalToConstant: frame.height * 0.1).isActive = true
        littleImage.topAnchor.constraint(equalTo: bigText.bottomAnchor,constant: 10).isActive = true
        littleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        littleImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -50).isActive = true
       
        littleImage.widthAnchor.constraint(equalToConstant: frame.width * 0.4).isActive = true
        
        littleText.leadingAnchor.constraint(equalTo: littleImage.trailingAnchor,constant: 20).isActive = true
        littleText.centerYAnchor.constraint(equalTo: littleImage.centerYAnchor,constant: 30).isActive = true
        littleText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        littleText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -50).isActive = true
        
        
    }
    func configureCell(item : ElemBlock){
        NetworkManager.shared.setImageFromUrl(url: item.bigPicture, imageView: self.bigImage)
        self.bigText.text = item.textContent1
        NetworkManager.shared.setImageFromUrl(url: item.smallPicture, imageView: self.littleImage)
        self.littleText.text = item.textContent2
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
