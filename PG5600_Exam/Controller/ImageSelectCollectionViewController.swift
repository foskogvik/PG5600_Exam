//
//  ImageSelectCollectionViewController.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 21/02/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import Photos
import UIKit

private let reuseIdentifier = "ImageCell"

class ImageSelectCollectionViewController: UICollectionViewController {
    @IBOutlet var submitButton: UIBarButtonItem!
    
    let imageManager = ImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Images"

        // makes selecting multiple images in the view possible.
        collectionView.allowsMultipleSelection = true

        // call loadimage function to get all photos in the gallery.
        imageManager.loadImage()

        clearsSelectionOnViewWillAppear = true
        
            submitButton.isEnabled = false
        
    }

    
     // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "presentModal" {
            let destinationVC = segue.destination as! ImageSelectModalController
            destinationVC.selectedImages = imageManager.selectedImageArray
     }
    }
     

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageManager.imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Displays all the cells in the collection
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell

        // Gets a reference to the cell in the storyboard
        let imageView = cell.viewWithTag(1) as! UIImageView
        // Gets a reference to the titleLabel in the storyboard
        let label = cell.imageLabel!

        // sets the image in the view to the first one from the imagearray
        imageView.image = imageManager.imageArray[indexPath.row]
        // sets the text in the label to the date taken from the datearray and converts it to a sting
        label.text = imageManager.dateArray[indexPath.row].toString(dateFormat: "yyyy/MMM/dd")

        print(indexPath.row)

        // return the cell
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        let image = imageManager.imageArray[indexPath.row]

        if imageManager.selectedImageArray.contains(image) == false {
            cell.isSelected = true
            imageManager.selectedImageArray.insert(image, at: indexPath.row)
        }
        
        if imageManager.selectedImageArray.isEmpty {
            submitButton.isEnabled = false
        } else {
            submitButton.isEnabled = true
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        var index = 0
//        for image in imageManager.selectedImageArray {
        index = indexPath.row
//        }
        imageManager.selectedImageArray.remove(at: index)
        cell.isSelected = false
        
        if imageManager.selectedImageArray.isEmpty {
            submitButton.isEnabled = false
        } else {
            submitButton.isEnabled = true
        }
        
    }
}
