//
//  ViewController.swift
//  World Tracking
//
//  Created by Christopher Lee on 23/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
//        let node = SCNNode()
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
//
//        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
//        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//
//        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
//        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
//
//        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        node.position = SCNVector3(0.2, 0.3, -0.2)
//
//        boxNode.position = SCNVector3(0, -0.05, 0)
//
//        doorNode.position = SCNVector3(0, -0.02, 0.055)
//
//        self.sceneView.scene.rootNode.addChildNode(node)
//        node.addChildNode(boxNode)
//        boxNode.addChildNode(doorNode)
        
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        pyramid.position = SCNVector3(0, 0, -0.3)
        
        pyramid.eulerAngles = SCNVector3(Float(90.degreesToRadians), 0, 0)
        
        self.sceneView.scene.rootNode.addChildNode(pyramid)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
