//
//  ImageSelectModalController.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 23/02/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import UIKit

class ImageSelectModalController: UIViewController {
    var selectedImages = [UIImage]()

    override func viewDidLoad() {
        print("arrived at modal", selectedImages)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AR2000ToNetworkView" {
            let destinationVC = segue.destination as! NeuralNetworkViewController
            print("leaving for network", selectedImages)
            destinationVC.animalImages = selectedImages
        }

        if segue.identifier == "TCBToNetworkView" {
            let destinationVC = segue.destination as! NeuralNetworkViewController
            print("leaving for network", selectedImages)
            destinationVC.teslaImages = selectedImages
        }

        if segue.identifier == "FoodZeroToNetworkView" {
            let destinationVC = segue.destination as! NeuralNetworkViewController
            print("leaving for network", selectedImages)
            destinationVC.foodImages = selectedImages
        }
    }


    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
