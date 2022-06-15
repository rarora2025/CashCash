//
//  GroupsMainViewController.swift
//  June20Proj
//
//  Created by Rahul on 5/13/22.
//  Copyright © 2022 Rahul. All rights reserved.
//

//NOT GROUPS< BUT RATHER DONATION

import UIKit
import CardSlider

struct Item: CardSliderItem {
    var image: UIImage
    
    var rating: Int?
    
    var title: String
    
    var subtitle: String?
    
    var description: String?
    
    
}


class GroupsMainViewController: UIViewController, CardSliderDataSource {
    var goingHome = false
    var don = false
    var data = [Item]()
    func item(for index: Int) -> CardSliderItem {
        return data[index]
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    @objc func buttonAction(sender: UIButton!) {

    
        goingHome = true
        self.dismiss(animated: false, completion: nil)
        
    }
    @objc func buttondonAction(sender: UIButton!) {

       
           don = true
           self.dismiss(animated: false, completion: nil)
           
       }
    
    override func viewDidAppear(_ animated: Bool) {
        
    
        
        if goingHome{
            self.dismiss(animated: false, completion: nil)
           
        }
        if don {
            self.performSegue(withIdentifier: "letsdonate", sender: self)
        }
        data.append(Item(image: UIImage(named: "charity-1")!, rating: nil, title: "COVID Response Fund", subtitle: "CODE = WHO", description: "To suppress transmission, reduce exposure, counter misinformation, protect the vulnerable, reduce mortality and morbidity, and accelerate equitable access to new COVID-19 tools."))
        data.append(Item(image: UIImage(named: "charity-2")!, rating: nil, title: "Civil Rights Organization", subtitle: "CODE = NAACP", description: "To advance political, educational, social, and economic equality for Black people in the United States."))
        data.append(Item(image: UIImage(named: "charity-3")!, rating: nil, title: "UN Refugee Agency", subtitle: "CODE = UNHCR", description: "To make a lasting impact on the lives of refugees and displaced people around the world."))
        data.append(Item(image: UIImage(named: "charity-4")!, rating: nil, title: "Hunger Relief Organization", subtitle: "CODE = FA", description: "To get meals to kids & families facing hunger through food pantries, soup kitchens, shelters, and other community-based agencies."))
        data.append(Item(image: UIImage(named: "charity-5")!, rating: nil, title: "Conservation Organization", subtitle: "CODE = TEAMTREES", description: "To reestablish a sustainable water supply through protecting and replanting around springs and rivers, restoring habitat for wildlife, stabilizing steep slopes prone to landslides, and securing livelihoods."))
        data.append(Item(image: UIImage(named: "charity-6")!, rating: nil, title: "Ocean Cleanup Organization", subtitle: "CODE = TEAMSEAS", description: "To remove trash polluting coastal regions, rivers, and ultimately oceans."))
        data.append(Item(image: UIImage(named: "charity-7")!, rating: nil, title: "Animal Rights Organization", subtitle: "CODE = PETA", description: "To end abusive treatment of animals in business and society and promote consideration of animal interests in everyday decision making and general policies and practices."))
        data.append(Item(image: UIImage(named: "charity-8")!, rating: nil, title: "Children's Cancer Hospital", subtitle: "CODE = STJUDE", description: "To advance cures and means of prevention for pediatric catastrophic diseases through research and treatment."))
        data.append(Item(image: UIImage(named: "charity-9")!, rating: nil, title: "UN Children's Fund", subtitle: "CODE = UNICEF", description: "To ensure special protection for the most disadvantaged children - victims of war, disasters, extreme poverty, all forms of violence and exploitation and those with disabilities."))
        data.append(Item(image: UIImage(named: "charity-10")!, rating: nil, title: "Water Charity Organization", subtitle: "CODE = WATER", description: "To bring clean and safe drinking water to people in developing countries."))
        
       
        let vc = CardSliderViewController.with(dataSource: self)
    
        
        vc.title = "Earn DON Points"
       
        
        let button = UIButton(frame: CGRect(x: view.window!.width-150, y: 50, width: 125, height: 50))
        button.backgroundColor = UIColor(named: "default")
        button.setTitle("Donate", for: .normal)
        button.addTarget(self, action: #selector(buttondonAction), for: .touchUpInside)

        let button2 = UIButton(frame: CGRect(x: view.window!.width-150, y: view.window!.height-65, width: 125, height: 25))
               button2.backgroundColor = UIColor(named: "reverse")
               button2.setTitle("Return Home", for: .normal)
               button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        vc.modalPresentationStyle = .fullScreen
        vc.view.addSubview(button)
        vc.view.addSubview(button2)
        
 
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(gesture:)))
            gesture.direction = direction
            vc.view.addGestureRecognizer(gesture)
        }
        // Do any additional setup after loading the view.
    
   
        present(vc, animated: true)
    }
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print(gesture.direction)
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.down:
            print("down swipe")
        case UISwipeGestureRecognizer.Direction.up:
            print("up swipe")
        case UISwipeGestureRecognizer.Direction.left:
            print("left swipe")
        case UISwipeGestureRecognizer.Direction.right:
            print("right swipe")
        default:
            
            print("other swipe")
        }
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
