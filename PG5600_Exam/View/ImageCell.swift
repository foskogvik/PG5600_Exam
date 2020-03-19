//
//  ImageCell.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 21/02/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    var isSeleted: Bool = false
    
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var checkMarkView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                checkMarkView.isHidden = false
            } else {
                checkMarkView.isHidden = true
            }
        }
    }
    
    var thumbnailImage: UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
