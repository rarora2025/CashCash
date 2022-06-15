//
//  welcometempViewController.swift
//  June20Proj
//
//  Created by Rahul Arora on 6/24/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class welcometempViewController: UIViewController {
    var ref: DatabaseReference! = Database.database().reference()
    var database = Database.database()
    @IBOutlet weak var username: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
             let userID = Auth.auth().currentUser?.uid
             let profilePath = ref.child("users").child(userID!)
          
            profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                      let snapValue = snapshot.value as? NSDictionary
             //fix google sign in problem (when they don't have an ccount)
  
           
                 var usernameString = snapValue?["Username"] as? String ?? ""
                 
                 
                      
                 self.username.text = "Welcome " + usernameString
                
            
                                //to access users info
                 
             
             

             



              
             
             
            
                  })
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
