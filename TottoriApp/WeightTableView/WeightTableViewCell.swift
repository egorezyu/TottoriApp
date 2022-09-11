//
//  WeightTableViewCell.swift
//  TottoriApp
//
//  Created by Егор Родионов on 5.09.22.
//

import UIKit

class WeightTableViewCell: UITableViewCell {
    static let id = "WeightTableViewCell"
    private lazy var label : UILabel = {
        var view = UILabel()
        
        
        
        
        view.textColor = .black
        
        view.font = UIFont(name: "Gilroy-Regular", size: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 1.07
        return view
        
        
        
        
        
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    private func addViews(){
        contentView.addSubview(label)
        
        
        
    }
    private func setConstraints(){
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    public func configureCell(text : String){
        label.text = text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
