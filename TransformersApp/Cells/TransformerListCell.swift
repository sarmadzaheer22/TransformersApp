//
//  MoviesListCell.swift
//  MoviePreview
//
//  Created by Osama Arshad on 25/08/2023.
//

import UIKit
import SDWebImage

class TransformerListCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overallRankingLabel: UILabel!
    
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var enduranceLabel: UILabel!
    @IBOutlet weak var firepowerLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var courageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func UIActions(data:Transformer){
        self.cardView.layer.cornerRadius = 10
        self.titleLabel.text = data.name
        self.overallRankingLabel.text = String(data.overallRating ?? 0)
        
        if(data.team == "A"){
            self.posterImageView.image = UIImage(named: "Autobots")
        }else{
            self.posterImageView.image = UIImage(named: "Decepticons")
        }
        
        self.strengthLabel.text = String(data.strength)
        self.enduranceLabel.text = String(data.endurance)
        self.firepowerLabel.text = String(data.firepower)
        self.intelligenceLabel.text = String(data.intelligence)
        self.rankLabel.text = String(data.rank)
        self.skillLabel.text = String(data.skill)
        self.speedLabel.text = String(data.speed)
        self.courageLabel.text = String(data.courage)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
