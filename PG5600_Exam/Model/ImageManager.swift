//
//  ImageManager.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 23/02/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class ImageManager {

    
    // array of images fetched from the gallery
    var imageArray = [UIImage]()
    // array of images selected and preparing for sending to next screen
    var selectedImageArray = [UIImage]()
    // array of dates for images fetched from the library
    var dateArray = [Date]()
    
    // function for getting images from gallery
    func loadImage() {
        
        // define imagemanager
        let imgManager = PHImageManager.default()

        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic

        let fetchOptions = PHFetchOptions()
        
        // fetches all images and loops through creation dates and adds them to the dateArray
        // Function coutresy of Jared Davidson because apple docs sucks beyond comprehension. No clue how to fix the warning.
        // https://www.youtube.com/watch?v=BFZ4ZCw_9z4&t=1018s
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
             if fetchResult.count > 0 {
                for result in 0 ..< fetchResult.count {
                    self.dateArray.append(fetchResult[result].creationDate!)
                }
            }
            if fetchResult.count > 0 {
                for result in 0 ..< fetchResult.count {
                    imgManager.requestImage(for: fetchResult.object(at: result), targetSize: CGSize(width: 170, height: 120), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                        image, error in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("You got no photos")
            }
        }
    }
}
