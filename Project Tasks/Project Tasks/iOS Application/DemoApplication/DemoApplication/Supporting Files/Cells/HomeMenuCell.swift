

import UIKit

class HomeMenuCell: UITableViewCell {

    //MARK: -------- UI Elements Outlets --------

    @IBOutlet weak var viewContainer: UIView?
    @IBOutlet weak var imgViewIcon: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblCuisine: UILabel?
    @IBOutlet weak var lblRating: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.setUpUIElements()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: -------- Custom Functions --------
    
    // Setting Up UI Elements
    private func setUpUIElements () {
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        self.viewContainer?.addShadowWith(UIColor.black, shwOffset: CGSize(width: 0.0, height: 1.0), opacity: 0.3, shwRadius: 2, cornerRadius: 10.0, bgColor: UIColor.white)
        
        self.imgViewIcon?.layer.cornerRadius = self.imgViewIcon!.frame.size.width / 2.0
        self.imgViewIcon?.layer.borderWidth = 2.0
        self.imgViewIcon?.layer.borderColor = UIColor.white.cgColor
        self.imgViewIcon?.clipsToBounds = true
        self.imgViewIcon?.contentMode = .scaleAspectFill     //.scaleToFill
        
        self.lblRating?.textColor = UIColor.red
     
    }
    
    
    //MARK: ---------- Cell Configuration --------------
    
    func configureCellWith(_ log: Recipe?) {
        
        // Image --------
        if let url = URL(string: log?.image ?? "") {
            self.imgViewIcon?.loadImage(from: url)
        }
        
        // Title --------
        if let title = log?.name, title.trimSpace().isEmpty == false {
            self.lblTitle?.text = title
        } else {
            self.lblTitle?.text = "--"
        }
        
        // Cuisine  and Meal Type--------
        if let cuisine = log?.cuisine, cuisine.trimSpace().isEmpty == false {
            
            self.lblCuisine?.text = cuisine
            
            if let mealType = log?.mealType.joined(separator: " , ") {
                self.lblCuisine?.text = cuisine + " - ( " + mealType + " )"
            } else {
                self.lblCuisine?.text = cuisine
            }
            
        } else {
            self.lblCuisine?.text = "--"
        }
        
        // Ratings --------
        if let rating = log?.rating {
            self.lblRating?.text = String(rating) + " ★ ratings"
        } else {
            self.lblRating?.text = "--"
        }
        
    }
    
}
