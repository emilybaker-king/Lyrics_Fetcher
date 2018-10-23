//
//  ViewController.swift
//  Lyrics Fetcher
//
//  Created by Emily Baker-King on 10/23/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var lyricsTextView: UITextView!

    
    //The base URL for the lyrics API, aka the point where we connect to it
    let lyricsAPIBaseURL = "https://api.lyrics.ovh/v1/"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        guard let artistName = artistTextField.text, let songTitle = songTextField.text else {
            return
        }
        
        //we can't have spaces in URL, so add a + instead
        let artistNameURLComponent = artistName.replacingOccurrences(of: " ", with: "+")
    
        let songTitleURLComponent = songTitle.replacingOccurrences(of: " ", with: "+")
        
        //Full URL for the request we will make to the API
        let requestURL = lyricsAPIBaseURL + artistNameURLComponent + "/" + songTitleURLComponent
        
        //We are going to use Alimofire to create an actual request using the URL
        let request = Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        
        //now we need to actually make our request
        request.responseJSON { response in
            //We switch based on the response result, which can be either success or failure
            switch response.result {
            case .success(let value):
                //In the case of success , the request has succeeded, and we've gotten some dat back
                print(value)
                
                let json = JSON(value)
                
                self.lyricsTextView.text = json["lyrics"].stringValue
                
                print("Success")
                
            case .failure(let error):
                //In the case of failure, the request has failed and we've gotten an error back
                print("Error :(")
                print(error.localizedDescription)
            }
        }
        
        artistTextField.text = ""
        songTextField.text = ""
        
    }
    

}

