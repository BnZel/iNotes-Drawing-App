//
//  DrawViewController.swift
//  iNotes-Test
//
//  Created by Jay on 2020-03-12.
//

import UIKit

class DrawViewController: UIViewController {
    
    var lastPoint = CGPoint.zero //last drawn point on the canvas
    var brushWidth: CGFloat = 10.0
    var color = UIColor.black //current selected color (default black colour)
    var opacity: CGFloat = 1.0
    var swiped = false //if the brush stroke is continuous
    
    @IBOutlet weak var tempImageView: UIImageView!
    
    // UIResponder (parent class of touch-notifying methods)
    // user puts a finger down on the screen.
    // first make sure you indeed received a touch.
    // reset swiped to false since the touch hasn’t moved yet.
    // save the touch location in lastPoint so when the user starts drawing
    //  keep track of where the stroke started.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false
        lastPoint = touch.location(in: view)
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: view.bounds)
        
        // 2
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        // 3
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        // 4
        context.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        // 6
        swiped = true
        let currentPoint = touch.location(in: view)
        drawLine(from: lastPoint, to: currentPoint)
        
        // 7
        lastPoint = currentPoint
    }

    @IBAction func btnPencilPressed(_ sender: UIButton) {
        print("pencil")
    }
    
    @IBAction func btnEraserPressed(_ sender: UIButton) {
        print("eraser")
    }
    
    @IBAction func btnResetPressed(_ sender: UIButton) {
        print("reset")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
