//
//  ViewController.swift
//  June2020
//
//  Created by Rahul on 6/14/20.
//  Copyright © 2020 Rahul. All rights reserved.

//TO DO:
//check for wifi

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import LocalAuthentication



class ViewController: UIViewController, UITextFieldDelegate, GIDSignInDelegate {
    
    var ref: DatabaseReference! = Database.database().reference()
  
    let context:LAContext = LAContext()
    let defaults = UserDefaults.standard
    var doesUseFaceID = ["false", "", ""]
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordTextField.endEditing(true)
        emailTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true)
        emailTextField.endEditing(true)
        
        return true
    }
    var authentication: GIDAuthentication?
    var credential: AuthCredential?
   
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      
         if GIDSignIn.sharedInstance()?.currentUser != nil {
        
     
      
//
       authentication = user.authentication
           credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)

               if let user = user {
             Auth.auth().signIn(with: credential!) { (userax, error) in
                let userID = Auth.auth().currentUser?.uid
                let profilePath = self.ref.child("users").child(userID!)
                                  
                                    profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                              let snapValue = snapshot.value as? NSDictionary
                                        
                                       var psswrd = snapValue?["Password"] as? String ?? "Unknown_User"
                                       var email = snapValue?["Email"] as? String ?? "Unknown_User"
                                        
                                 let credential2 = EmailAuthProvider.credential(withEmail: email, password: psswrd)
                                 Auth.auth().currentUser?.link(with: credential2, completion: nil)

                                    
                                         
               
                   //                      }
                                         
                                       
                                    
                                          })
                
                 
                
               
                
              
                    
          
                    
                profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                          let snapValue = snapshot.value as? NSDictionary
          
                 
                     var mailString = snapValue?["Email"] as? String ?? ""
                     var passString = snapValue?["Password"] as? String ?? ""
                     
                                 var urlString = snapValue?["PhotoURL"] as? String ?? ""
                    var password = " "

                                var usernameString = snapValue?["Username"] as? String ?? ""
                    if usernameString == "" {
                        Auth.auth().createUser(withEmail: user.profile!.email, password: password) { (usera, error) in
                                
                            let credential2 = EmailAuthProvider.credential(withEmail: user.profile.email, password: password)
                                
                                   Auth.auth().currentUser?.link(with: credential2, completion: nil)
                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Email").setValue(user.profile?.email)
                                                
                                                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Password").setValue(password)
                                                  self.performSegue(withIdentifier: "nextSteps", sender: self)
                                                
                                            }
                    } else {
                        self.performSegue(withIdentifier: "homepg", sender: self)
                        
                    }
         
                
                 

                  
                 
                 
                
                      })
                
             
          
            }
            }

       } else {
            //no google account
          print("got here")
//                     print()
//                     print(user.profile.name)
//                     print(user.profile.hasImage)
//                     print(user.profile.imageURL(withDimension: 100))
//           var password = ""
//            Auth.auth().createUser(withEmail: user.profile.email, password: password) { (usera, error) in
//
//                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Email").setValue(user.profile.email)
//
//                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Password").setValue(password)
//
//                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Username").setValue(user.profile.name)
//
//                if user.profile.hasImage == true {
//                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("PhotoURL").setValue(user.profile.imageURL(withDimension: 100))
//
//                } else {
//                    //set a default prof photo
//                }
//                print("herde")
//                self.performSegue(withIdentifier: "newGoogleUser", sender: self)
//
//
//
//
//
//
//
//
//
//
//            }
            
           
            
//else {
//
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Email").setValue(email)
//            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Password").setValue(password)
//            if let u = user {
//            let userID = Auth.auth().currentUser?.uid
//              if self.ns == true || self.ref.child("users").child(Auth.auth().currentUser!.uid) == nil {
//
//                let facealert = UIAlertController(title: "Connect with Face-ID", message: "Would you like to connect this account to your iPhone's Face/Touch Recognition so you can use that to login. This will disconnect all other accounts currently linked.", preferredStyle: .alert)
//
//                facealert.addAction(UIAlertAction(title: "No Thanks", style: .default, handler: { action in
//
//                     //var doesUseFaceID = [[false, nil]]
//                    self.doesUseFaceID[0] = "false"
//                    self.doesUseFaceID[1] = ""
//                    self.doesUseFaceID[2] = ""
//
//                    self.defaults.set(self.doesUseFaceID, forKey: "DoesUseFaceID")
//
//                    self.performSegue(withIdentifier: "nextSteps", sender: self)
//
//                }))
//                facealert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
//
//                    self.doesUseFaceID[0] = "true"
//                    self.doesUseFaceID[1] = self.emailTextField.text!
//                    self.doesUseFaceID[2] = self.passwordTextField.text!
//                    print("saved  \(self.doesUseFaceID)")
//                    self.defaults.set(self.doesUseFaceID, forKey: "DoesUseFaceID")
//                    self.performSegue(withIdentifier: "nextSteps", sender: self)
//
//
//
//
//                }))
//                self.present(facealert, animated: true)
//
//
//              } else {
//                   self.performSegue(withIdentifier: "homepg", sender: self)
//
//              }
//
//
//            } else {
//                let mailvalidity = self.isValidEmail(self.emailTextField.text!)
//                if self.emailTextField.text == "" || mailvalidity == false {
//                    self.error.isHidden = false
//                    self.error.text = "Please enter a valid email"
//                } else if self.passwordTextField.text == ""{
//                    self.error.isHidden = false
//                    self.error.text = "Please enter a valid password"
//
//                } else {
//
//                    self.error.isHidden = false
//                    self.error.text = "Please enter valid login credentials."
//
//                }
//
//            }
//        }
//
//
//
//           }
//

          
        }
    }
  
    
    
    @IBOutlet var googsignInButton: GIDSignInButton!

    @IBAction func userForgotPass(_ sender: UIButton) {
        self.performSegue(withIdentifier: "passreset", sender: self)
        
    }
    
    @IBOutlet weak var fpass: UIButton!
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        error.isHidden = true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        error.isHidden = true
    }
    @IBOutlet weak var error: UILabel!
    
  

    var ns = false
   

    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLbl: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignin:Bool = true
    
    override func viewDidLoad() {
       
        signInLbl.text = ""
        var charIndex = 0.0
        let titleText = "Welcome"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.12 * charIndex, repeats: false) { (timer) in
                self.signInLbl.text?.append(letter)
            }
            charIndex += 1
        }
        
        let x = self.defaults.value(forKey: "DoesUseFaceID") as? Array ?? ["", "", ""]
        print(x)
       

        let faceIdvalidt = x[0]
        
        
      
        
        if faceIdvalidt == "true" {
           
           
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
                    
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Message") { (good, error) in
         

            if good {
                
                
              
                //sign the user in
                let mail = x[1] as! String ?? ""
                let pass = x[2] as! String ?? ""
                
          
                Auth.auth().signIn(withEmail: mail, password: pass) { (user, error) in
                          if let u = user {
                            var usernameString: String = ""
                            var photoString: String = ""
                            let userID = Auth.auth().currentUser?.uid
                                           let profilePath = self.ref.child("users").child(userID!)
                             profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                           let snapValue = snapshot.value as? NSDictionary
                            usernameString = snapValue?["Username"] as? String ?? ""
                                photoString = snapValue?["PhotoURL"] as? String ?? ""
                                             
                            })
                            
                        
                              if self.ns == true || self.ref.child("users").child(Auth.auth().currentUser!.uid) == nil {
                            
                                  self.performSegue(withIdentifier: "nextSteps", sender: self)
                                 
                             } else {
                                  self.performSegue(withIdentifier: "homepg", sender: self)
                                 
                             }
                          } else {
                              let mailvalidity = self.isValidEmail(self.emailTextField.text!)
                              if self.emailTextField.text == "" || mailvalidity == false {
                                  self.error.isHidden = false
                                  self.error.text = "Invalid Email"
                              } else if self.passwordTextField.text == ""{
                                  self.error.isHidden = false
                                  self.error.text = "Invalid Password"
                                  
                              } else {
                                  if mailvalidity == true {
                                      self.error.isHidden = false
                                      self.error.text = "Email/Password is incorrect"
                                      
                                  } else {
                                      self.error.isHidden = false
                                      self.error.text = "No user: " + self.emailTextField.text!
                                      
                                  }
                                  
                                  
                              }
                              
                              
                          }
                      }
          
            

            } else {
              
            
            }

            }

            }
            
          
            
        } else {
            
            var handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                              if let user = user {
                                  if self.ns != true && self.ref.child("users").child(Auth.auth().currentUser!.uid) != nil {
                                    if let xylogin = MyVariables.autologin {
                                        if xylogin {
                                            self.performSegue(withIdentifier: "homepg", sender: self)
                                            
                                        }
                                        
                                    }
                                           
                                                                  
                                                              }
                                  
                              }
                          }
          
        }

        GIDSignIn.sharedInstance()?.clientID = "993828370509-t0nu52iqvpujlajonkpck0drff7dmp2e.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
        googsignInButton.style = GIDSignInButtonStyle.wide
      

   self.signInLbl.textColor = .white

      
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        UIView.animate(withDuration: 5, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, .allowUserInteraction], animations: {
                   
           
            self.view.backgroundColor = UIColor(named: "telisequa")
            
            
       
                   self.view.backgroundColor = UIColor(named: "pink")
           self.signInButton.backgroundColor = UIColor(named: "pink")
          
        
            self.signInButton.backgroundColor = UIColor(named: "telisequa")
                
                  
                  //


               }, completion: nil)
        
        error.isHidden = true
        
        passwordTextField.isSecureTextEntry = true
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    @IBAction func signInselectorChanged(_ sender: UISegmentedControl) {
    
    
       
        isSignin = !isSignin
        
        if isSignin {
           ns = false
            fpass.isHidden = false
            signInLbl.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
             googsignInButton.isHidden = false
        } else {
            ns = true
            fpass.isHidden = true
            signInLbl.text = "Register"
               signInButton.setTitle("Register", for: .normal)
         
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        
        
 
    
                if let email = emailTextField.text, let password = passwordTextField.text {
                       
                        if isSignin {

                            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                                if let u = user {
                                 
                                    let userID = Auth.auth().currentUser?.uid
                                    if self.ns == true || self.ref.child("users").child(Auth.auth().currentUser!.uid) == nil {
                                        self.performSegue(withIdentifier: "nextSteps", sender: self)
                                       
                                   } else {
                                        self.performSegue(withIdentifier: "homepg", sender: self)
                                       
                                   }
                                } else {
                                    let mailvalidity = self.isValidEmail(self.emailTextField.text!)
                                    if self.emailTextField.text == "" || mailvalidity == false {
                                        self.error.isHidden = false
                                        self.error.text = "Please enter a valid email"
                                    } else if self.passwordTextField.text == ""{
                                        self.error.isHidden = false
                                        self.error.text = "Please enter a valid password"
                                        
                                    } else {
                                        if mailvalidity == true {
                                            self.error.isHidden = false
                                            self.error.text = "Email/Password is incorrect"
                                            
                                        } else {
                                            self.error.isHidden = false
                                            self.error.text = "No user: " + self.emailTextField.text!
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                            
                                   
                               } else {
                            
                            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                              self.ref.child("users").child((user?.user.uid)!).child("Email").setValue(email)
                                    self.ref.child("users").child((user?.user.uid)!).child("Password").setValue(password)
                                                                 if let u = user {
                                                                  
                                                                     let userID = u.user.uid
                                                                     if self.ns == true || self.ref.child("users").child(u.user.uid) == nil {
                                                                   
                                                                     let facealert = UIAlertController(title: "Connect with Face-ID", message: "Would you like to connect this account to your iPhone's Face/Touch Recognition so you can use that to login. This will disconnect all other accounts currently linked.", preferredStyle: .alert)
                                                                     
                                                                     facealert.addAction(UIAlertAction(title: "No Thanks", style: .default, handler: { action in
                                                                         
                                                                          //var doesUseFaceID = [[false, nil]]
                                                                         self.doesUseFaceID[0] = "false"
                                                                         self.doesUseFaceID[1] = ""
                                                                         self.doesUseFaceID[2] = ""
                                                                         
                                                                         self.defaults.set(self.doesUseFaceID, forKey: "DoesUseFaceID")
                                                                         
                                                                         self.performSegue(withIdentifier: "nextSteps", sender: self)
                                                                         
                                                                     }))
                                                                     facealert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                                                                 
                                                                         self.doesUseFaceID[0] = "true"
                                                                         self.doesUseFaceID[1] = self.emailTextField.text!
                                                                         self.doesUseFaceID[2] = self.passwordTextField.text!
                                                                         print("saved  \(self.doesUseFaceID)")
                                                                         self.defaults.set(self.doesUseFaceID, forKey: "DoesUseFaceID")
                                                                         self.performSegue(withIdentifier: "nextSteps", sender: self)
                                                                         
                                                                         
                                                                         
                                                                         
                                                                     }))
                                                                     self.present(facealert, animated: true)
                                                                     
                                                                       
                                                                   } else {
                                                                        self.performSegue(withIdentifier: "homepg", sender: self)
                                                                       
                                                                   }
                                                                     
                                                                 
                                                                 } else {
                                                                     let mailvalidity = self.isValidEmail(self.emailTextField.text!)
                                                                     if self.emailTextField.text == "" || mailvalidity == false {
                                                                         self.error.isHidden = false
                                                                         self.error.text = "Please enter a valid email"
                                                                     } else if self.passwordTextField.text == ""{
                                                                         self.error.isHidden = false
                                                                         self.error.text = "Please enter a valid password"
                                                                         
                                                                     } else {
                                                                     
                                                                         self.error.isHidden = false
                                                                         self.error.text = "Please enter valid login credentials."
                                                                         
                                                                     }
                                                                     
                                                                 }
                            
                             
                            }
                            
                    
                                   
                               }
                    }

                   
               
        
    
       
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
   
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true)
        emailTextField.endEditing(true)
        if passwordTextField.text == "" {
            passwordTextField.placeholder = "Password"
            error.isHidden = true
        } else if emailTextField.text == "" {
           emailTextField.placeholder = "Email Address"
            error.isHidden = true
        }

        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
       
         passwordTextField.endEditing(true)
        emailTextField.endEditing(true)
        if passwordTextField.text == "" {
            passwordTextField.placeholder = "Password"
            error.isHidden = true
        } else if emailTextField.text == "" {
           emailTextField.placeholder = "Email Address"
            error.isHidden = true
        }
    }
 
}

