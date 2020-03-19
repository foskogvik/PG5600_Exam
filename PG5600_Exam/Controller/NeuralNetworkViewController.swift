//
//  NeuralNetworkViewController.swift
//  PG5600_Exam
//
//  Created by Fredrik Skogvik on 23/02/2020.
//  Copyright © 2020 Fredrik Skogvik. All rights reserved.
//

import UIKit

class NeuralNetworkViewController: UIViewController {
    @IBOutlet var AR2000PendingLabel: UILabel!
    @IBOutlet var AR2000AnalyzedLabel: UILabel!

    @IBOutlet var TCBPendingLabel: UILabel!
    @IBOutlet var TCBAnalyzedLabel: UILabel!

    @IBOutlet var FZPendingLabel: UILabel!
    @IBOutlet var FZAnalyzedLabel: UILabel!

    @IBOutlet weak var AR2000StartButton: UIButton!
    @IBOutlet weak var TCBStartButton: UIButton!
    @IBOutlet weak var FZStartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AR2000PendingLabel.text = ("\(animalImages.count) images pending")
        TCBPendingLabel.text = ("\(teslaImages.count) images pending")
        FZPendingLabel.text = ("\(foodImages.count) images pending")
        
        AR2000AnalyzedLabel.text = ("\(animalImagesAnalyzed) images analyzed")
        TCBAnalyzedLabel.text = ("\(teslaImagesAnalyzed) images analyzed")
        FZAnalyzedLabel.text = ("\(foodImagesAnalyzed) images analyzed")
        
        enableButtons()
    }

    var animalImages = [UIImage]()
    var teslaImages = [UIImage]()
    var foodImages = [UIImage]()
    var animalImagesAnalyzed = 0
    var teslaImagesAnalyzed = 0
    var foodImagesAnalyzed = 0

    let AR2000name = "Animal Recognizer 2000"
    let TCBname = "Tesla Car Brain"
    let FZname = "Food Zone"

    func enableButtons() {
        if animalImages.count > 0 {
            AR2000StartButton.isHidden = false
            AR2000StartButton.isEnabled = true
        }
        else if teslaImages.count > 0 {
            TCBStartButton.isHidden = false
            TCBStartButton.isEnabled = true
        }
        else if foodImages.count > 0 {
            FZStartButton.isHidden = false
            FZStartButton.isEnabled = true
        }

        
    }
    
    
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AR2000PendingToAnalysis" {
            let destinationVC = segue.destination as! AnalysisViewController
            print("leaving for analysis", animalImages)
            destinationVC.analysisImages = animalImages
            destinationVC.networkName = AR2000name
        }
        if segue.identifier == "TCBPendingToAnalysis" {
            let destinationVC = segue.destination as! AnalysisViewController
            print("leaving for analysis", teslaImages)
            destinationVC.analysisImages = teslaImages
            destinationVC.networkName = TCBname
        }
        if segue.identifier == "FZPendingToAnalysis" {
            let destinationVC = segue.destination as! AnalysisViewController
            print("leaving for analysis", foodImages)
            destinationVC.analysisImages = foodImages
            destinationVC.networkName = FZname
        }
     }
     
}
