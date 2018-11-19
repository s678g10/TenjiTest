//
//  ViewController.swift
//  Tenjitest
//
//  Created by 坂井岳 on 2018/11/18.
//  Copyright © 2018 Gaku Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var panGesture = UIGestureRecognizer()
    var bgView = UIView()
    var startPoint:CGPoint = CGPoint(x:0,y:0)
    let generator = UIImpactFeedbackGenerator(style: .heavy)//1発のFeedの強さはここで変更できる
    var beforeTag:Int = 0
    var tenjiArray:[UIView] = []
    @IBOutlet weak var alphaSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gestureを設定するView
        bgView.frame = CGRect(x: 0, y: 0, width: 375, height:812)
        bgView.backgroundColor = UIColor.clear
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dragged(_:)))
        bgView.addGestureRecognizer(panGesture)
        self.view.addSubview(bgView)
        self.view.bringSubviewToFront(alphaSwitch)
        
        
        for i in 1...13 {
            let tenjiView = self.view.viewWithTag(i)
            tenjiArray.append(tenjiView!)
        }
    }
    
    //ドラッグジェスチャーの設定
    @objc func dragged(_ sender:UIPanGestureRecognizer){
        //Panをスタートした時
        if sender.state == UIGestureRecognizer.State.began{
            startPoint = CGPoint.zero
            startPoint = sender.location(in: bgView)
            print("pan start",startPoint)
        }
        
        let translation = sender.translation(in: self.view)
        startPoint.x += translation.x
        startPoint.y += translation.y
        
        print("x:",startPoint.x,"y:",startPoint.y)
        tenjiFB(startPoint)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        //Panを終わらせた時
        if sender.state == UIGestureRecognizer.State.ended{
            beforeTag = 0
            print("pan ended")
        }
    }
    
    //セグメントコントロールの設定
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bgView.backgroundColor = UIColor.clear
        default:
            bgView.backgroundColor = UIColor.white
        }
    }
    
    
    func tenjiFB(_ point:CGPoint){
        
        tenjiArray.forEach{
           let tag = $0.tag
           if $0.frame.contains(point) && tag != beforeTag{
            print("FB")
            generator.prepare()
            //generator.impactOccurred()を増やせばFBの強さをさらに強くできる
            generator.impactOccurred()
            //generator.impactOccurred()
            beforeTag = tag
           }
        }
        
        
    }


}

