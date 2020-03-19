//
//  AnalysisViewController.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 24/02/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController {
    var analysisImages = [UIImage]()
    var networkName = ""
    var progress: Float = 0.0
    var tapIndex = 0
    var imageIndex = 0

    @IBOutlet var analysisImageView: UIImageView!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var networkNameLabel: UILabel!

    @IBOutlet var animalPercentageLabel: UILabel!

    @IBOutlet var teslaPercentageLabel: UILabel!

    @IBOutlet var foodPercentageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        analysisImageView.image = analysisImages[imageIndex]
        progressBar.progress = 0.0
        networkNameLabel.text = "\(networkName) Image \(imageIndex + 1) of \(analysisImages.count)"
        // Do any additional setup after loading the view.

        // code from stackoverflow: https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        analysisImageView.isUserInteractionEnabled = true
        analysisImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    // Basic function from same stackoverflow post
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if tapIndex < 2 {
            progress = progress + 0.33
            animalPercentageLabel.text = "20%"
            teslaPercentageLabel.text = "40%"
            foodPercentageLabel.text = "6%"
            print(tapIndex)
            updateUI()
            tapIndex = tapIndex + 1
        } else if tapIndex == 2 {
            progress = 1.0
            animalPercentageLabel.text = "10%"
            teslaPercentageLabel.text = "70%"
            foodPercentageLabel.text = "3%"
            updateUI()
            tapIndex = tapIndex + 1
        } else if tapIndex == 3 {
            imageIndex = imageIndex + 1
            animalPercentageLabel.text = "0%"
            teslaPercentageLabel.text = "100%"
            foodPercentageLabel.text = "0%"
            progress = 0.0
            updateUI()
            tapIndex = 0
        }
    }

    func updateUI() {
        if imageIndex != analysisImages.count {
            progressBar.setProgress(progress, animated: true)
            analysisImageView.image = analysisImages[imageIndex]
            networkNameLabel.text = "\(networkName) Image \(imageIndex + 1) of \(analysisImages.count)"
        } else {
            performSegue(withIdentifier: "segueBack", sender: nil)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueBack" {
            let destinationVC = segue.destination as! NeuralNetworkViewController
            destinationVC.animalImagesAnalyzed = imageIndex
        }
    }
}
