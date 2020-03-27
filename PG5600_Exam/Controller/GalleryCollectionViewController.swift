//
//  GalleryCollectionViewController.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 02/03/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import Photos
import PhotosUI
import UIKit

private let reuseIdentifier = "ImageCell"

class GalleryCollectionViewController: UICollectionViewController {
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    var assetCollection: PHAssetCollection!

    var availableWidth: CGFloat = 0
    fileprivate var thumbnailSize: CGSize!

    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Determine the size of the thumbnails to request from the PHCachingImageManager.
        let scale = UIScreen.main.scale
        let cellSize = flowLayout.itemSize

        // This bases itself on the size of the cell. EG. this line states that images fetched by the manager should have the exact same size as the cells.
        thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.allowsMultipleSelection = true
        
        let allPhotosOptions = PHFetchOptions()
        // sets sorting order of fetched images, sorted ascending by creation date.
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        // retrieves all assets that matches our options and assigns them to the fetchResult collection.
        fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let width = view.bounds.inset(by: view.safeAreaInsets).width
        // Adjust the item size if the available width has changed.
        if availableWidth != width {
            availableWidth = width
            // increasing the "divided by" number decreases the number of cells in the column
            // these calculate the size of the flowlayout cells based on the size of the phone. Which is why the images are scaled correctly based on which device. Dont think they're related to image or content of the cell.
            let columnCount = (availableWidth / 140).rounded(.towardZero)
            let itemLength = (availableWidth - columnCount - 12) / columnCount

            flowLayout.itemSize = CGSize(width: itemLength, height: itemLength)
        }
    }

    /*
     // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
     */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = fetchResult.object(at: indexPath.item)
        // research implementation better.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCell
        else { fatalError("Unexpected cell in collection view") }

        // Request an image for the asset from the PHCachingImageManager.
        imageManager.requestImage(for: asset, targetSize: flowLayout.itemSize, contentMode: .aspectFill
                                  , options: nil) { image, _ in
            cell.thumbnailImage = image

            // Format date. don't think this is the best place for the functionality. Will look into moving it.
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "no_NO")
            formatter.timeStyle = .short
            formatter.dateStyle = .short
            cell.timeStampLabel.text = formatter.string(from: asset.creationDate!)
        }
        return cell
    }

    // MARK: UICollectionViewDelegate


     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCell
        else { fatalError("Unexpected cell in collection view") }
        
        print(cell.isSelected)
    }
    
     override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCell
        else { fatalError("Unexpected cell in collection view") }
        
        print(cell.isSelected)
    }

}
