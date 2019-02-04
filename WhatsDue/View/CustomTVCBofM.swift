import UIKit
protocol CustomTableViewCellDelegateBofM {
    func didTapSwitch(cell: CustomTableViewCellBofM)
}

class CustomTableViewCellBofM: UITableViewCell {
    
    
    @IBOutlet weak var imageCellBackground: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    
    // @IBOutlet weak var imageCell2: UIImageView!
}
