//current games cancelled, make sure u wagering money dat u have
//make sure that you are doing more than 0 rounds

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import LocalAuthentication
import SCLAlertView

class SoloAIViewController: UIViewController {
    @IBOutlet weak var titleOfGame: UILabel!
    @IBOutlet weak var wagerTitle: UILabel!
    
           let userID = Auth.auth().currentUser?.uid
     var ref: DatabaseReference! = Database.database().reference()
    var rounds: Int = 1
    var arr: [String] = []
    var wagerPerRound: Int = 0
    var mode: String = "Solo"
    var opIfAny: String = ""
    var multOppsIfAny: [String:String] = [:]
    var opIfAnyID: String = ""
    var difficulty: Int = 1
    @IBOutlet weak var roundTxt: UILabel!
    @IBOutlet weak var wagerSlider: UISlider!
    @IBOutlet weak var wagerText: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var diff: UISegmentedControl!
    @IBAction func didChangeSeg(_ sender: UISegmentedControl) {
        updateButton()
    }
    @IBAction func didChangeDifficulty(_ sender: Any) {
       difficulty = diff.selectedSegmentIndex + 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(opIfAny != "") {
            mode = "1v1"
        } else if (multOppsIfAny != [:]){
            mode = "mult"
            let profilePath6 = ref.child("users").child(userID!)
                                    
                                      profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                               let snapValue = snapshot.value as? NSDictionary
                                       var points = snapValue?["Username"] as? String
                                        self.multOppsIfAny[points!] = self.userID
                                      
                                            })
            
        }
        switch(mode){
        
        case "mult":
            titleOfGame.text = "Multiplayer"
            wagerTitle.text = "Everyone puts in:"
            break
            
        case "1v1":
            titleOfGame.text = "1v1 Wager"
            wagerTitle.text = "Each of you put in:"
            break
            
        default:
            break
        
        }
     
        updateRounds()

        // Do any additional setup after loading the view.
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "getToQ" {
                 let vc = segue.destination as? SoloAI2ViewController
                 vc?.creds = arr
                 
                
              
             }
   }
    func updateRounds(){
        
        roundTxt.text = String(rounds)
        updateButton()
        
        
    }
    @IBAction func didreturn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    public func evaluateCanGo()->Bool{
//        var count: Int = 0
//        var usersidnums = multOppsIfAny.values
//     var clean: Bool = true
// var clearName: String = ""
//     for persona in usersidnums {
//
//
//           let profilePath6 = ref.child("users").child(persona)
//
//                                    profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
//
//                                      if(snapshot.hasChild("games")){
//                                         let profilePath5 = self.ref.child("users").child(self.userID!).child("games")
//
//                                                               profilePath5.observeSingleEvent(of: .value, with: { (snapshot) in
//
//                                                                 print(persona + "got heres")
//                                                                 if(snapshot.hasChild("trivia")){
//                                                                    count += 1
//                                                                    print(persona + "got here")
//                                                                    clean = false
//
//                                                                 } else {
//                                                                    print(persona + "got here")
//                                                                    count += 1
//                                                                 }
//
//
//
//
//
//
//                                                                     })
//
//                                      } else {
//                                        print(persona + "got here")
//                                        count += 1
//
//                                      }
//
//
//                                          })
//
//     }
//        while (count == usersidnums.count){
//            return clean
//        }
//
//    }
    
    @IBAction func didBetRN(_ sender: Any) {
        
        if(mode == "1v1"){
            
        }else if(mode == "mult") {
            var randomid: String = "MultiplayerGame-" + NSUUID().uuidString
            
         
        
                    let profilePath6 = ref.child("users").child(userID!)
                                            
                    profilePath6.observeSingleEvent(of: .value, with: { [self] (snapshot) in
                                                       let snapValue = snapshot.value as? NSDictionary
                                               var points = snapValue?["points"] as? Int
                          var username = snapValue?["Username"] as? String
                                        if(self.wagerPerRound*self.rounds <= points!) {
                                            
                                         
                                            
                                            var usersIDS = self.multOppsIfAny.values
                                            self.arr.append("\(self.rounds)-round Multiplayer Trivia from \(username!)")
                                            self.arr.append(randomid)
                                            for ID in usersIDS {
                                            
                                                self.ref.child("users").child(ID).child("pending").child("\(self.rounds)-round Multiplayer Trivia from \(username!)").setValue(randomid)
                                                   
                                                var better = self.wagerPerRound
                                                       var winint = 0
                                              
                                                       
                                                      
//                                                self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("wagered").setValue(0)
//
//                                                    self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("potWinnings").setValue(0)
//
//                                                self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("totalRounds").setValue(self.rounds)
//                                                    self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("roundsFinished").setValue(0)
//                                                    self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("totalWinnings").setValue(0)
//
//                                                self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("wagerPerRound").setValue(0)
//
//                                                self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("winningsPerRound").setValue(0)
//                                                self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("correct").setValue(0)
//                                                self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("gameID").setValue(randomid)
                                                
                                            }
                                            
                                             self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("wagered").setValue(0)
                                            
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("potWinnings").setValue(0)
                                            
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("totalRounds").setValue(self.rounds)
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("roundsFinished").setValue(0)
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("totalWinnings").setValue(0)
                                            
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("wagerPerRound").setValue(0)
                                            
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("winningsPerRound").setValue(0)
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("correct").setValue(0)
                                            self.ref.child("users").child(self.userID!).child("games").child("trivia").child("current").child("gameID").setValue(randomid)
                                            
                                            self.ref.child("games").child("trivia").child(randomid).child("type").setValue("mult")
                                            self.ref.child("games").child("trivia").child(randomid).child("host").setValue(self.userID)
                                            self.ref.child("games").child("trivia").child(randomid).child("status").setValue("invite")
                                            self.ref.child("games").child("trivia").child(randomid).child("users").setValue(self.multOppsIfAny)
                                            self.ref.child("games").child("trivia").child(randomid).child("unconfirmed").setValue(self.multOppsIfAny)
                                            self.ref.child("games").child("trivia").child(randomid).child("wagers").setValue(self.wagerPerRound)
                                            self.ref.child("games").child("trivia").child(randomid).child("totalRounds").setValue(self.rounds)
                                            self.ref.child("games").child("trivia").child(randomid).child("winnings").setValue(self.wagerPerRound * self.multOppsIfAny.count)
                
                             
                                            
                                            
                                           
                                  
                               
                                      //
                                          
                                            self.performSegue(withIdentifier: "getToQ", sender: self)
                                        } else {
                                             let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true
                                                                                                                                                                                                                                    )
                                                                                                                      let alertView = SCLAlertView(appearance: appearancery)
                                                                                                                      
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     alertView.showInfo("Not Enough Points", subTitle: "You don't have enough points to wager that much.", closeButtonTitle: "Ok")
                                        }
                    })
             
                                      
                                           
            
        } else {
       //
        let profilePath6 = ref.child("users").child(userID!)
                                
                                  profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                           let snapValue = snapshot.value as? NSDictionary
                                   var points = snapValue?["points"] as? Int
                                    
                                    if(self.wagerPerRound*self.rounds <= points!) {
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("type").setValue("bet")
                                           
                                        var better = self.wagerPerRound*self.rounds
                                               var winint = 0
                                        switch(self.difficulty){
                                               case 1:
                                                winint = (self.wagerPerRound*self.rounds)/2
                                                   break
                                               case 2:
                                                winint = (self.wagerPerRound*self.rounds)
                                                    break
                                               case 3:
                                                winint = (self.wagerPerRound*self.rounds)*2
                                                    break
                                               default:
                                                   //error
                                                   winint = 0
                                                   self.submitButton.setTitle("error", for: .normal)
                                                    break
                                               }
                                               
                                              
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("wagered").setValue(better)
                                            
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("potWinnings").setValue(winint+better)
                                            
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("totalRounds").setValue(self.rounds)
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("roundsFinished").setValue(0)
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("totalWinnings").setValue(0)
                                            
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("wagerPerRound").setValue(self.wagerPerRound)
                                            
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("winningsPerRound").setValue(winint/self.rounds)
                                        
                                        self.performSegue(withIdentifier: "getToQ", sender: self)
                                    } else {
                                         let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true
                                                                                                                                                                                                                                )
                                                                                                                  let alertView = SCLAlertView(appearance: appearancery)
                                                                                                                  
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 alertView.showInfo("Not Enough Points", subTitle: "You don't have enough points to wager that much.", closeButtonTitle: "Ok")
                                    }
                                  
                                        })
        }
    
    }
    @IBAction func getToGamemyguy(_ sender: Any) {
        
        
    }
    func updateButton(){
        if(mode == "1v1"){
            submitButton.setTitle("Send Request to " + opIfAny + "; Winner gets $" + String(wagerPerRound*2), for: .normal)
        
        } else if (mode == "mult"){
            submitButton.setTitle("Request $" + String(wagerPerRound) + "; Winner gets $" + String(wagerPerRound * multOppsIfAny.count), for: .normal)
           
        } else {
        var betstr = String(wagerPerRound*rounds)
        var winint = 0
        switch(difficulty){
        case 1:
            winint = (wagerPerRound*rounds)/2
            break
        case 2:
            winint = (wagerPerRound*rounds)
             break
        case 3:
            winint = (wagerPerRound*rounds)*2
             break
        default:
            //error
            winint = 0
            submitButton.setTitle("error", for: .normal)
             break
        }
        
        var winstr = String(winint+wagerPerRound*rounds)
            
        submitButton.setTitle("Submit $" + betstr + " to Win $" + winstr, for: .normal)
        }
    }
    
    func updateWager(){
          
          wagerText.text = "$" + String(wagerPerRound)
            updateButton()
      }
    
    
    @IBAction func didChangeWager(_ sender: Any) {
        wagerPerRound = Int((sender as! UISlider).value)

                   updateWager()
    }
    @IBAction func didStepUp(_ sender: Any) {
        
        rounds = Int((sender as! UIStepper).value)

            updateRounds()

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
