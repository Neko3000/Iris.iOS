//
//  ExploreViewController.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/15/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundContainerView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        searchTextField.layer.cornerRadius = 10.0
        searchTextField.layer.masksToBounds = true
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "enter keyword to find", attributes: [.foregroundColor:UIColor(named: "text-light-grey-2")!])
        
        backgroundContainerView.layer.masksToBounds = true
        setImageBG(image: UIImage(named: "explore-ahri-1")!)
        
        searchTextField.layer.cornerRadius = 10.0
        searchTextField.layer.masksToBounds = true
        
        searchTextField.returnKeyType = .go
        searchTextField.delegate = self
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func setImageBG(image:UIImage){
        let orgCIImage = CIImage(image: image)
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(orgCIImage, forKey: "inputImage")
        blurFilter?.setValue("10.0", forKey: "inputRadius")
        
        let destCIImage = blurFilter?.value(forKey: "outputImage") as! CIImage
        
        let ciContext = CIContext()
        let finalCGImage = ciContext.createCGImage(destCIImage, from: orgCIImage!.extent)
        
        backgroundImageView.image = UIImage(cgImage: finalCGImage!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "ExploreToArtList"){
            
            let destVC = segue.destination as! ArtListViewController
            destVC.searchKeyword = self.searchTextField.text!
            
            print(navigationController?.viewControllers.count)
        }
    }
}

extension ExploreViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.returnKeyType == .go){
            
            performSegue(withIdentifier: "ExploreToArtList", sender: nil)
        }
        
        return true
    }
}
