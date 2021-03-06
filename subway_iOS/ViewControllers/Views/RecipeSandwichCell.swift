//
//  RecipeSandwichCell.swift
//  subway_iOS
//
//  Created by khpark on 2018. 8. 26..
//  Copyright © 2018년 TeamSubway. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeSandwichCell: UITableViewCell {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var sandwichImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var selectedFlagBackground: UIView!
    
    static let cellId = "RecipeSandwichCell"
    
    var data : SandwichInstance? {
        didSet {
            updateUI()
        }
    }
    
    var clicked = false {
        willSet {
            if newValue {
                selectedFlagBackground.backgroundColor = UIColor.yellowSelected
            } else {
                selectedFlagBackground.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupViews()
    }
    
    fileprivate func setupViews(){
        
        selectionStyle = .none
        
        let path = UIBezierPath(roundedRect:selectedFlagBackground.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 15, height:  15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        selectedFlagBackground.layer.mask = maskLayer
        
        infoButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
    }
    
    @objc fileprivate func showDetail(){
        guard let d = data else{
            fatalError("data is not set!!")
        }
        
        let vc = UIStoryboard(name: "Tab2", bundle: nil).instantiateViewController(withIdentifier: NutrientInfoPopupViewController.identifier) as! NutrientInfoPopupViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.data = d.sandwich
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    fileprivate func updateUI(){
        guard let d = data?.sandwich, let clicked = data?.clicked else{
            fatalError("data is not set!!")
        }
        
        let placeholder = UIImage(named: "placeholderSandwichRight")
        sandwichImageView.kf.setImage(with: URL(string: d.imageRight), placeholder: placeholder)
        nameLabel.text = d.name
        caloriesLabel.text = "\(d.calories) Kcal"
        
        selectedFlagBackground.backgroundColor = clicked ? UIColor.yellowSelected : UIColor.clear
    }

}
