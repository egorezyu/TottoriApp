//
//  TypeCollectionView.swift
//  TottoriApp
//
//  Created by Егор Родионов on 12.07.22.
//

import UIKit

class TypeCollectionView: UIView {
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width / 2.5, height: frame.width / 4)
        layout.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.backgroundColor = .backGroundColor
        collectionView.register(TypeViewCellCollectionViewCell.self, forCellWithReuseIdentifier: TypeViewCellCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        return collectionView
        
        
    }()
    private var typeArray : [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .backGroundColor
        collectionView.frame = bounds
        
        addSubview(collectionView)
        getMockData()
        
    }
    private func getMockData(){
        NetworkManager.netWork.getDataFromApi { result in
            switch result{
                
            case .success(let typeArray):
                DispatchQueue.main.async {[weak self] in
                    self?.typeArray = typeArray
                    self?.collectionView.reloadData()
                }
            case .failure(_):
                print("")
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

   

}
extension TypeCollectionView : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeArray.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeViewCellCollectionViewCell.identifier, for: indexPath) as! TypeViewCellCollectionViewCell
        cell.setType(type: typeArray[indexPath.row])
        
        
        
        
        
        return cell
    }
    
    
    
}



//import UIKit
//
//
//
//
//final class MenuView: UIView {
//
//
//
//    weak var delegate: MenuViewDelegate?
//
//
//
//    init(subscriber: MenuViewDelegate?) {
//
//        super.init(frame: .zero)
//
//
//
//        self.delegate = subscriber
//
//        addSubView()
//
//        setupLayout()
//
//    }
//
//
//
//    required init?(coder: NSCoder) {
//
//        fatalError("init(coder:) has not been implemented")
//
//    }
//
//
//
//    private func addSubView() {
//
//
//
//        addSubview(topMenuStackView)
//
//        addSubview(subMenuCollectionView)
//
//        addSubview(mainActivityIndicator)
//
//    }
//
//
//
//    private lazy var logoImageView: UIImageView = {
//
//
//
//        var view = UIImageView()
//
//        view.image = UIImage(named: "Logo")
//
//        view.contentMode = .scaleAspectFit
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        view.widthAnchor.constraint(equalToConstant: 163).isActive = true
//
//        return view
//
//    }()
//
//
//
//    private lazy var promoButton: UIButton = {
//
//
//
//        var view = UIButton()
//
//        view.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
//
//        view.tintColor = .white
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        view.widthAnchor.constraint(equalToConstant: 35).isActive = true
//
//        view.addTarget(self, action: #selector(promoButtonTapped), for: .touchUpInside)
//
//        return view
//
//    }()
//
//
//
//    private lazy var blowerButton: UIButton = {
//
//
//
//        var view = UIButton()
//
//        view.setBackgroundImage(UIImage(systemName: "phone"), for: .normal)
//
//        view.tintColor = .white
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
//
//        view.addTarget(self, action: #selector(blowerButtonTapped), for: .touchUpInside)
//
//        return view
//
//    }()
//
//
//
//    private lazy var topMenuStackView: UIStackView = {
//
//
//
//        var view = UIStackView(arrangedSubviews: [logoImageView, promoButton, blowerButton])
//
//        view.alignment = .fill
//
//        view.distribution = .equalSpacing
//
//        view.axis = .horizontal
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//
//    }()
//
//
//
//    public lazy var mainActivityIndicator: UIActivityIndicatorView = {
//
//
//
//        var view = UIActivityIndicatorView(style: .large)
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//
//    }()
//
//
//
//    public lazy var subMenuCollectionView: UICollectionView = {
//
//
//
//        var cellWidth = CGFloat()
//
//        var cellHeight = CGFloat()
//
//        if UIScreen.main.bounds.size.height == 568 {
//
//            cellWidth = UIScreen.main.bounds.size.width / 1.1428571429
//
//            cellHeight = UIScreen.main.bounds.size.height / 2.3
//
//        } else if UIScreen.main.bounds.size.height == 667 {
//
//            cellWidth = UIScreen.main.bounds.size.width / 2 - 30
//
//            cellHeight = UIScreen.main.bounds.size.height / 2.7659952607
//
//        } else {
//
//            cellWidth = UIScreen.main.bounds.size.width / 2 - 30
//
//            cellHeight = UIScreen.main.bounds.size.height / 3.50
//
//        }
//
//
//
//        var flowLayout = UICollectionViewFlowLayout()
//
//        flowLayout.scrollDirection = .vertical
//
//        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//
//        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
//
//        flowLayout.minimumLineSpacing = 20
//
//        var view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//
//        view.register(cell: SubMenuCollectionViewCell.self)
//
//        view.backgroundColor = .clear
//
//        view.showsHorizontalScrollIndicator = false
//
//        view.showsVerticalScrollIndicator = false
//
//        view.alwaysBounceVertical = true
//
//        view.alpha = 0
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//
//    }()
//
//
//
//    private func setupLayout() {
//
//
//
//        var menuCollectionSize = CGFloat()
//
//        if UIScreen.main.bounds.size.height == 568 {
//
//
//menuCollectionSize = 10
//
//        } else {
//
//            menuCollectionSize = 25
//
//        }
//
//
//
//        NSLayoutConstraint.activate([
//
//
//
//            topMenuStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
//
//            topMenuStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 17),
//
//            topMenuStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
//
//            topMenuStackView.heightAnchor.constraint(equalToConstant: 31),
//
//
//
//            subMenuCollectionView.topAnchor.constraint(equalTo: topMenuStackView.bottomAnchor, constant: menuCollectionSize),
//
//            subMenuCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//
//            subMenuCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//
//            subMenuCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//
//
//
//            mainActivityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
//
//            mainActivityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
//
//        ])
//
//    }
//
//
//
//    @objc func promoButtonTapped(sender: UIButton) {
//
//
//
//        delegate?.promoButtonTapped()
//
//    }
//
//
//
//    @objc func blowerButtonTapped(sender: UIButton) {
//
//
//
//        delegate?.blowerButtonTapped()
//
//    }
//
//}

