import UIKit
import TransitionButton
import FirebaseAuth
import Firebase
import GoogleSignIn
import LocalAuthentication
import NotificationBannerSwift

extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}

class SoloAI2ViewController: UIViewController {
    @IBOutlet weak var total: UILabel!
    var answered: Bool = false
    var timer2: Timer? = nil
    var timer3: Timer? = nil
    var creds: [String] = []
    var moder: String = ""
    var totalrect: Int = 0
    @IBOutlet weak var timer: UIProgressView!
    @IBOutlet weak var bttn: TransitionButton!
    @IBAction func b4Clicked(_ sender: Any) {
        updateCredentials(correctness: questions!.results[roundsCompleted].correct_answer == button4.titleLabel?.text, timed: false)
    }
    @IBAction func b3Clicked(_ sender: Any) {
        updateCredentials(correctness: questions!.results[roundsCompleted].correct_answer == button3.titleLabel?.text, timed: false)
    }
    @IBAction func b2Clicked(_ sender: Any) {
        updateCredentials(correctness: questions!.results[roundsCompleted].correct_answer == button2.titleLabel?.text, timed: false)
    }
    @IBAction func b1Clicked(_ sender: Any) {
        updateCredentials(correctness: questions!.results[roundsCompleted].correct_answer == button1.titleLabel?.text, timed: false)
    }
    
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var questionNum: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var totalWinnings: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    var roundsCompleted = 0
    var correctButton = 0
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    var potentialWinnings = 0
    @IBOutlet weak var wagered: UILabel!
    var totalRounds = 0
    var totalsWinning = 0
    var wgrd = 0
    var questions: TriviaAPI?
    var wgrPerRound = 0
    var winPerRound = 0

    
 var ref: DatabaseReference! = Database.database().reference()
    public func displayNext(){
        //check if round is overL HANDLE DONE
        
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        info.text = "Select an Answer"
   
        
        questionNum.text = "Question #" + String(roundsCompleted + 1)
       answered = false
        print(questions?.results)
        question.text = String(htmlEncodedString: questions!.results[roundsCompleted].question)
        let randomInt = Int.random(in: 1..<4)
        print(randomInt)
        question.adjustsFontSizeToFitWidth = true
        button1.titleLabel?.adjustsFontSizeToFitWidth = true
            button2.titleLabel?.adjustsFontSizeToFitWidth = true
            button3.titleLabel?.adjustsFontSizeToFitWidth = true
            button4.titleLabel?.adjustsFontSizeToFitWidth = true


        var incorrectanswers = questions!.results[roundsCompleted].incorrect_answers.count
        var totaladdedsofar = 0
        var remainingButtons: [UIButton]
        if (randomInt == 1) {
              correctButton = 1
  
            button1.setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].correct_answer), for: .normal)
        remainingButtons = [button2, button3, button4]
            while (totaladdedsofar < incorrectanswers) {
                remainingButtons[totaladdedsofar].setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].incorrect_answers[totaladdedsofar]), for: .normal)
                totaladdedsofar += 1
            }
        }
        if (randomInt == 2) {
  correctButton = 2
                 button2.setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].correct_answer), for: .normal)

        remainingButtons = [button1, button3, button4]
                           while (totaladdedsofar < incorrectanswers) {
                               remainingButtons[totaladdedsofar].setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].incorrect_answers[totaladdedsofar]), for: .normal)
                               totaladdedsofar += 1
                           }
            }
        if (randomInt == 3) {
               correctButton = 3

                     button3.setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].correct_answer), for: .normal)
               remainingButtons = [button1, button2, button4]
                                        while (totaladdedsofar < incorrectanswers) {
                                           remainingButtons[totaladdedsofar].setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].incorrect_answers[totaladdedsofar]), for: .normal)
                                            totaladdedsofar += 1
                                        }
            }
        if (randomInt == 4) {
             correctButton = 4
    
                  button4.setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].correct_answer), for: .normal)
         remainingButtons = [button1, button2, button3]
                                        while (totaladdedsofar < incorrectanswers) {
                                          remainingButtons[totaladdedsofar].setTitle(String(htmlEncodedString: questions!.results[roundsCompleted].incorrect_answers[totaladdedsofar]), for: .normal)
                                            totaladdedsofar += 1
                                        }
            }
     
        if moder == "mult" {
            wagered.text = String(totalrect)
              totalWinnings.text = "TBD"
              total.text = "Total Correct:"
        } else {
            wagered.text = String(wgrPerRound*roundsCompleted)
            totalWinnings.text = String(totalsWinning)
        }
        
        
            
        timer.setProgress(0, animated: false)
        timer.isHidden = false
    
        timer3 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [weak self] timer3 in
            if(self!.answered == false){
                self!.updateCredentials(correctness: false, timed: true)
            }
        }
        
         

        for x in 0..<100 {
        
                timer2 = Timer.scheduledTimer(withTimeInterval:Double(x)*0.1, repeats: false) { [weak self] timer2 in
                    self!.timer.setProgress(Float(x)/100, animated: true)
                }
               
        
        }
    }
    public func updateCredentials(correctness: Bool, timed: Bool){
        answered = true
        timer2!.invalidate()
        timer3!.invalidate()
        timer.isHidden = true
        var bruttons: [UIButton] = [button1, button2, button3, button4]
        var correctOne = bruttons[correctButton-1]
        for button in bruttons{
            if (button.titleLabel?.text == correctOne.titleLabel?.text) {
                button.backgroundColor = UIColor.systemGreen
            } else {
                 button.backgroundColor = UIColor(named: "incorrect_red")
            }
            button.isEnabled = false
        }

        if (correctness) {
              totalrect += 1
        ref.child("users").child((Auth.auth().currentUser?.uid)!).child("games").child("trivia").child("current").child("correct").setValue(totalrect)
            
            totalsWinning+=winPerRound+wgrPerRound
            ref.child("users").child((Auth.auth().currentUser?.uid)!).child("games").child("trivia").child("current").child("totalWinnings").setValue(totalsWinning)
           
         
            
            let banner = NotificationBanner(title: "Correct!", subtitle: "Nice, you have choosen the correct answer.", leftView: nil, rightView: nil, style: .success, colors: nil)
            
            banner.autoDismiss = false
            banner.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                banner.dismiss()
            })
        } else if (timed){
            
            let banner = NotificationBanner(title: "Times Up!", subtitle: "You took too long to answer.", leftView: nil, rightView: nil, style: .warning, colors: nil)
                       
                       banner.autoDismiss = false
                       banner.show()
                       DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                           banner.dismiss()
                       })
        } else {
            let banner = NotificationBanner(title: "Incorrect!", subtitle: "The response you selected was wrong.", leftView: nil, rightView: nil, style: .danger, colors: nil)
            
            banner.autoDismiss = false
            banner.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                banner.dismiss()
            })
            
        }
        roundsCompleted += 1
       
        ref.child("users").child((Auth.auth().currentUser?.uid)!).child("games").child("trivia").child("current").child("roundsFinished").setValue(roundsCompleted)
        
        ref.child("users").child((Auth.auth().currentUser?.uid)!).child("games").child("trivia").child("current").child("totalWinnings").setValue(totalsWinning)
        ref.child("users").child((Auth.auth().currentUser?.uid)!).child("games").child("trivia").child("current").child("wagered").setValue(roundsCompleted*wgrPerRound)
        
        var rounds_left = totalRounds - roundsCompleted
        
        if (rounds_left != 0) {
          info.text = "Rounds Left: " + String(rounds_left) + "; Winnings Left: $" + String(rounds_left*winPerRound)

       
        
        if moder == "mult" {
                 wagered.text = String(totalrect)
             totalWinnings.text = "TBD"
              total.text = "Total Correct:"
             } else {
                wagered.text = String(wgrPerRound * roundsCompleted)
             totalWinnings.text = String(totalsWinning)
             }
            bttn.setTitle("Next Question", for: .normal)
        bttn.isHidden = false
         UIView.animate(withDuration: 3, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, .allowUserInteraction], animations: {
                    
      
            self.bttn.backgroundColor = UIColor(named: "pink")
           
         
             self.bttn.backgroundColor = UIColor(named: "telisequa")
           


                }, completion: nil)
        
    } else {
            
            if(totalsWinning >= 0) {
               info.text = "Total Won: $" + String(totalsWinning)
            } else {
                info.text = "Total Loss: -$" + String(totalsWinning)
            }
              
           
            if moder == "mult" {
                totalWinnings.text = "TBD"
                  total.text = "Total Correct:"
                         wagered.text = String(totalrect)
                     } else {
                totalWinnings.text = String(totalsWinning)
                           wagered.text = String(wgrPerRound * roundsCompleted)
                     }

               bttn.setTitle("Finish", for: .normal)
              bttn.isHidden = false
               UIView.animate(withDuration: 3, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, .allowUserInteraction], animations: {
                          
            
                  self.bttn.backgroundColor = UIColor(named: "pink")
                 
               
                   self.bttn.backgroundColor = UIColor(named: "telisequa")
                 


                      }, completion: nil)
            
    
    }
               
    }

    @IBAction func didTapButton(_ sender: TransitionButton) {
        if(totalRounds-roundsCompleted != 0){
        question.text = "Loading..."
        button1.setTitle("", for: .normal)
        button2.setTitle("", for: .normal)
         button3.setTitle("", for: .normal)
         button4.setTitle("", for: .normal)
        button1.backgroundColor = UIColor(named: "pink")
            button2.backgroundColor = UIColor(named: "pink")
            button3.backgroundColor = UIColor(named: "pink")
            button4.backgroundColor = UIColor(named: "pink")
            sender.backgroundColor = UIColor(named: "telisequa")
        sender.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            sender.stopAnimation(animationStyle: .normal, revertAfterDelay: 0, completion: nil)
            sender.isHidden = true
            self.displayNext()
        }
        } else {
            sender.startAnimation() // 2: Then start the animation when the user tap the button
                   let qualityOfServiceClass = DispatchQoS.QoSClass.background
                   let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                   backgroundQueue.async(execute: {
                       
                       sleep(3) // 3: Do your networking task or background work here.
                       
                       DispatchQueue.main.async(execute: { () -> Void in
                           // 4: Stop the animation, here you have three options for the `animationStyle` property:
                           // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                           // .shake: when you want to reflect to the user that the task did not complete successfly
                           // .normal
                        sender.backgroundColor = UIColor(named: "telisequa")
                           sender.stopAnimation(animationStyle: .expand, completion: {
                            
                            self.performSegue(withIdentifier: "showResults", sender: self)
                           })
                       })
                   })
            
        }
         
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "showResults" {
            let vc = segue.destination as? FinishedTrivViewController
            vc?.wagereder = roundsCompleted*wgrPerRound
            vc?.winningser = totalsWinning
            vc?.roundser = roundsCompleted
            print(creds)
            vc?.creds2 = creds
            vc?.correct = totalrect
            
            if moder == "mult" {
                   vc?.modery = "mult"
            }
         
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if moder == "mult" {
            totalWinnings.text = "TBD"
            total.text = "Total Correct:"
        }
        self.bttn.isHidden = true
        let userID = Auth.auth().currentUser?.uid
        let profilePath = ref.child("users").child(userID!).child("games").child("trivia").child("current")
                 
                   profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                             let snapValue = snapshot.value as? NSDictionary
                  
         
                    if snapshot.hasChild("gameID"){
                        self.moder = "mult"
                    }
                  
                    self.potentialWinnings = snapValue?["potWinnings"] as? Int ?? 0
                    self.roundsCompleted = snapValue?["roundsFinished"] as? Int ?? 0
                    self.totalRounds = snapValue?["totalRounds"] as? Int ?? 0
                    self.totalsWinning = snapValue?["totalWinnings"] as? Int ?? 0
                    self.wgrd = snapValue?["wagered"] as? Int ?? 0
                    self.totalrect = snapValue?["correct"] as? Int ?? 0
                
                    self.wgrPerRound = snapValue?["wagerPerRound"] as? Int ?? 0
              
                   
                 
                     self.winPerRound = snapValue?["winningsPerRound"] as? Int ?? 0
                    if(self.roundsCompleted > 0){
                        self.roundsCompleted += 1
                        }
                    
                    if(self.totalRounds <= self.roundsCompleted){
                        self.performSegue(withIdentifier: "showResults", sender: self)
                    } else {
                        
                        var mode: String = ""
             
                        if(self.potentialWinnings > self.wgrd*2){
                           mode = "hard"
                        } else if (self.potentialWinnings < self.wgrd*2){
                            mode = "easy"
                        } else if (self.potentialWinnings == self.wgrd*2){
                            
                           mode = "medium"
                        }
                        
                        var numberOfQuestions = self.totalRounds
                        
                        let url = "https://opentdb.com/api.php?amount=\(numberOfQuestions)&difficulty=\(mode)&type=multiple"
             
                        
                        self.getData(from: url)
                        
                        
                    }
                    
                    
    
                    
                   
                         })
        
        
        
    }
    private func getData(from url: String){

        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("ERROR ")
                return
            }
         
            var result:TriviaAPI?
            do{
                result = try JSONDecoder().decode(TriviaAPI.self, from: data)
            } catch {
                print("failed to fetch trivia data from https://opentdb.com/api.php?amount=5")
            }
            
            guard let json = result else {
                return
            }
            
            self.questions = json
           
            DispatchQueue.main.async {
                self.displayNext()
            }
            
            })
            
            task.resume()
       
        
    }
    


}




struct TriviaAPI: Codable {
    let results: [myResults]
    let response_code: Int
    
}
struct myResults: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    
}
