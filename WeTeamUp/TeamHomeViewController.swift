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
import Photos



class TeamHomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var masterView: UIView!
    @IBOutlet weak var stretchyView: SpringView!
    @IBOutlet weak var collectioHeader: UICollectionReusableView!
    @IBOutlet weak var collectionCards: UICollectionView!
    @IBOutlet weak var objFromLogin: UILabel!
    @IBOutlet var stringLogin: String!
    var posts: [DataSnapshot]! = []
    @IBOutlet weak var imageBoxProfile: UIImageView!
    var refUser: DatabaseReference!
    var refPost: DatabaseReference!
    var refHandle: DatabaseHandle!
//    let headerNib = UINib(nibName: "IOGrowHeader", bundle: Bundle.main)




    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // CONFIG FIREBASE ELEMENTS
        refUser = Database.database().reference()
        refPost = Database.database().reference()
        self.collectionCards.delegate = self
        self.collectionCards.dataSource = self
        
        // REGISTER XIB FILE
        self.collectionCards.register(UINib(nibName: "HomeCardsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cardcell")
        
//          self.collectionCards.register(UINib(nibName: "subHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "subheadercell")
        
        let layout = collectionCards.collectionViewLayout as? StickyHeaderCollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
//        self.getUserProfileDATA()
        self.configureDatabase()

//        self.refPost.child("user_posts").removeObserver(withHandle: refHandle)
        
 
//        // TEST MESSAGE
//        let user = Auth.auth().currentUser
//        self.refUser.child("users").child((user?.uid)!).setValue(["username": user?.displayName])
//        self .sendMessage(withData: ["description" : "HOLA"])
        
        
       // CREATE GESTURE PAN
//        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        self.collectionCards.addGestureRecognizer(gestureRecognizer)
        
//        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
//        swipeDown.direction = .down
//        self.stretchyView.addGestureRecognizer(swipeDown)
//        
//        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
//        swipeUp.direction = .up
//        self.stretchyView.addGestureRecognizer(swipeUp)
//        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
//        swipeRight.direction = .right
//        self.stretchyView.addGestureRecognizer(swipeRight)
//        
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
//        swipeLeft.direction = .left
//        self.stretchyView.addGestureRecognizer(swipeLeft)
        
        
        //GET SIZE FOR CELLS
        let cellSize = CGSize(width:355 , height:160)
        let layouty = StickyHeaderCollectionViewFlowLayout()
        layouty.scrollDirection = .vertical //.horizontal
        layouty.itemSize = cellSize
        collectionCards.setCollectionViewLayout(layouty, animated: true)
        
        collectionCards.reloadData()
        
    }
    
    //    @IBAction func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
    //        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
    //
    //            let translation = gestureRecognizer.translation(in: self.view)
    //            // note: 'view' is optional and need to be unwrapped
    //            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
    //            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    //        }
    //    }
    
    
//    func swiped(gesture: UIGestureRecognizer)
//    {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer
//        {
//            switch swipeGesture.direction
//            {
//                
//            case UISwipeGestureRecognizerDirection.right:
//                print("Swiped Right")
//                
//            case UISwipeGestureRecognizerDirection.left:
//                print("Swiped Left")
//                
//                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
//                rotationAnimation.fromValue = 0.0
//                rotationAnimation.toValue = Double.pi
//                rotationAnimation.duration = 1.0
//                
//                
//                self.stretchyView.layer.add(rotationAnimation, forKey: nil)
//                
//            case UISwipeGestureRecognizerDirection.up:
//                print("Swiped Up")
//                UIView.animate(withDuration: 1.0, animations: {
//
//                    self.stretchyView.animation = "slideUp"
//                    self.stretchyView.duration = 2.0
//                    self.stretchyView.velocity = 1.0
//                    self.stretchyView.animate()
//                    
//                })
//            case UISwipeGestureRecognizerDirection.down:
//                print("Swiped Down")
//                UIView.animate(withDuration: 1.0, animations: {
//                    
//                    self.stretchyView.animation = "slideDown"
//                    self.stretchyView.duration = 2.0
//                    self.stretchyView.velocity = 1.0
//                    self.stretchyView.animate()
//                })
//                
//            default:
//                break
//            }
//        }
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
    

    // number of sections is 2. Section above search and below search
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //number of items for each section. Section above search will have only one and below search will be dynamic as per images we have
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            //Below search bar
            return posts.count
        }
    }
    
//    // tell the collection view how many cells to make
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.posts.count
//    }
//    

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headersection", for: indexPath)
//        return view
//    }

    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
//        return CGSize(width: self.collectionCards.bounds.width, height: 238)
//        
//    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            // above search cell

//            let cell : subHeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "subheadercell", for: indexPath) as! subHeaderCollectionViewCell
//            return cel
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboveSearch", for: indexPath)
            return cell

            
        } else {
            // below search cell
            
            let cell : HomeCardsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardcell", for: indexPath) as! HomeCardsCollectionViewCell
            
//            // Unpack message from Firebase DataSnapshot
            let messageSnapshot = self.posts[indexPath.row]
            guard let message = messageSnapshot.value as? [String: String] else { return cell }
            let name = message[Constants.MessageFields.name] ?? ""
            let text = message[Constants.MessageFields.text] ?? ""
            //        cell.labelName?.text = name + ": " + text
            //        cell.labelDescription?.text = name + ": " + text
            cell.labelName?.text = name
            cell.labelDescription?.text = text
            cell.imageBoxCell?.image = UIImage(named: "ic_account_circle")
            
            // DOWNLOAD IMAGE
            if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL),
                let data = try? Data(contentsOf: URL) {
                cell.imageBoxCell?.image = UIImage(data: data)
            }
            
            return cell

        }
        
        
      
    }
    
    // implementation of function viewForSupplementaryElementOfKind, for section header of collectionView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // returning the search bar for header
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headersection", for: indexPath)
    }
    
    // size for header in section: since we have 2 sections, collectionView will ask size for header for both sections so we make section header of first section with height 0 and width 0 so it remains like invisible.
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // if section is above search bar we need to make its height 0
        if section == 0 {
            return CGSize(width: 0, height: 0)
            //            return CGSize(width: collectionView.frame.width, height: 50)
            
        }
        // for section header i.e. actual search bar
        return CGSize(width: collectionView.frame.width, height: 50
        )
    }

    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
    
    func configureDatabase() {
        // Listen for new messages in the Firebase database
        self.refHandle = self.refPost.child("user_posts").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.self.posts.append(snapshot)
            //            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
            strongSelf.collectionCards.insertItems(at: [IndexPath(row: strongSelf.posts.count-1, section: 1)])
            
            
        })
    }
    
    
    func sendMessage(withData data: [String: String]) {
        var mdata = data
        mdata["name"] = Auth.auth().currentUser?.displayName
        if let photoURL = Auth.auth().currentUser?.photoURL {
            mdata["photourl"] = photoURL.absoluteString
        }
        
        // Push data to Firebase Database
        self.refPost.child("user_posts").childByAutoId().setValue(mdata)
    }
    
    // Pragma PROFILE IMAGE
    
//    override func viewDidLayoutSubviews() {
//        
//        imageBoxProfile.layer.cornerRadius = imageBoxProfile.frame.size.width/2
//        imageBoxProfile.clipsToBounds = true
//        
//    }
    
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
    
    
    // MARK: - Image Picker
    
//    @IBAction func didTapAddPhoto(_ sender: AnyObject) {
//        let picker = UIImagePickerController()
//        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
//            picker.sourceType = UIImagePickerControllerSourceType.camera
//        } else {
//            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        }
//        
//        present(picker, animated: true, completion:nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : Any]) {
//        picker.dismiss(animated: true, completion:nil)
//        
//        let referenceUrl = info[UIImagePickerControllerReferenceURL] as! URL
//        let assets = PHAsset.fetchAssets(withALAssetURLs: [referenceUrl], options: nil)
//        let asset = assets.firstObject
//        asset?.requestContentEditingInput(with: nil, completionHandler: { (contentEditingInput, info) in
//            _ = contentEditingInput?.fullSizeImageURL
//            _ = "\(String(describing: Auth.auth().currentUser?.uid))/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\(referenceUrl.lastPathComponent)"
//        })
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion:nil)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
