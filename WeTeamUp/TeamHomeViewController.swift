//
//  TeamHomeViewController.swift
//  WeTeamUp
//
//  Created by Daniel Ayala on 17/07/2017.
//  Copyright © 2017 Daniel Ayala. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore


class TeamHomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var cardsCollection: UICollectionView!
    
    @IBOutlet weak var objFromLogin: UILabel!
    @IBOutlet var stringLogin: String!
    var ref: DatabaseReference!

    @IBOutlet weak var imageBoxProfile: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        print("Begin of code")
        
        
        // REGISTER XIB FILE
        self.cardsCollection.register(UINib(nibName: "HomeCardsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cardcell")

        self .getUserProfileDATA()
        
        ref = Database.database().reference()
        

        
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : HomeCardsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardcell", for: indexPath) as! HomeCardsCollectionViewCell
//      cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    // Pragma PROFILE IMAGE
    
    override func viewDidLayoutSubviews() {
        
        imageBoxProfile.layer.cornerRadius = imageBoxProfile.frame.size.width/2
        imageBoxProfile.clipsToBounds = true
        
    }
    
    func getUserProfileDATA() {
    
        let user = Auth.auth().currentUser
        
        if let user = user {
           
            objFromLogin.text = user.displayName
            //            let email = user.email
            // ...
        }
        
        var profileImageURL: NSURL
        profileImageURL = user!.photoURL! as NSURL
        
        if let checkedUrl = URL(string:profileImageURL.absoluteString!) {
            imageBoxProfile.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
    
    }
    
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.imageBoxProfile.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
