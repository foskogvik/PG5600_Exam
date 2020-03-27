//
//  ImageCell.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 21/02/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var timeStampLabel: UILabel!
    @IBOutlet var checkImageView: UIImageView!

    var thumbnailImage: UIImage! {
        didSet {
            cellImageView.image = thumbnailImage
        }
    }

    override var isSelected: Bool {
        didSet {
            cellImageView.alpha = isSelected ? 0.5 : 1
            checkImageView.isHidden = isSelected ? false : true
        }
    }
}



// Date functionality currently resides in GalleryCollectionViewController. Will attempt to decouple and adhere to MVC as much as possible later.
// extension Date
// {
//    func toString( dateFormat format  : String ) -> String
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: self)
//    }
// }
