

import UIKit


class FavoritesTableViewCell: UITableViewCell {

    let defaults:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var contentBlock: UIView!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var ansLabel: UILabel!
    @IBOutlet weak var favIcon: UIButton!
    var curId:Int64 = 0
    var isKaz = false
    
    
    
    @IBAction func favButSelected(_ sender: Any) {
       
        var keyDefaults:String = String(curId)
        if isKaz{
            print("HERE")
            keyDefaults = String(-curId)
        }
        if let isFavorite = defaults.object(forKey: keyDefaults ) as? Bool {
            if isFavorite == false {
                defaults.set(true, forKey: keyDefaults)
                favIcon.setImage(#imageLiteral(resourceName: "star-3"), for: .normal)
            }else{
                defaults.set(false, forKey: keyDefaults)
                favIcon.setImage(#imageLiteral(resourceName: "star-1"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentBlock.layer.masksToBounds = false
        backgroundColor = .clear
        contentBlock.layer.cornerRadius = 4
        contentBlock.layer.shadowColor = UIColor.black.cgColor
        contentBlock.layer.shadowOpacity = 0.15
        contentBlock.layer.shadowOffset = CGSize.zero
        contentBlock.layer.shadowRadius = 5
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
