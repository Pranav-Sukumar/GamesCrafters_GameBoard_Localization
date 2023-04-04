//
//  ViewController.swift
//  SpaceShipMuseum
//
//  Created by Brian Advent on 09.06.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {
            print("No images available")
            return
        }

        configuration.trackingImages = trackedImages
        configuration.maximumNumberOfTrackedImages = 1
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            
            let width = planeNode.scale.y
            let height = planeNode.scale.x
            print(width)
            
            
            let ballOne = SCNScene(named: "art.scnassets/ship.scn")!
            let ballOneNode = ballOne.rootNode.childNodes.first!
            ballOneNode.scale.x = 0.05
            ballOneNode.scale.y = 0.05
            ballOneNode.scale.z = 0.05
            ballOneNode.position = SCNVector3Zero
            ballOneNode.position.z = 0.01
            ballOneNode.position.y = height/2
            ballOneNode.position.x = -width/2
            planeNode.addChildNode(ballOneNode)
            
            let ballTwo = SCNScene(named: "art.scnassets/ship.scn")!
            let ballTwoNode = ballTwo.rootNode.childNodes.first!
            ballTwoNode.scale.x = 0.05
            ballTwoNode.scale.y = 0.05
            ballTwoNode.scale.z = 0.05
            ballTwoNode.position = SCNVector3Zero
            ballTwoNode.position.z = 0.01
            ballTwoNode.position.y = -height/2
            ballTwoNode.position.x = -width/2
            
            planeNode.addChildNode(ballTwoNode)
            
            let ballThree = SCNScene(named: "art.scnassets/ship.scn")!
            let ballThreeNode = ballThree.rootNode.childNodes.first!
            ballThreeNode.scale.x = 0.05
            ballThreeNode.scale.y = 0.05
            ballThreeNode.scale.z = 0.05
            ballThreeNode.position = SCNVector3Zero
            ballThreeNode.position.z = 0.01
            ballThreeNode.position.y = height/2
            ballThreeNode.position.x = width/2
            
            planeNode.addChildNode(ballThreeNode)
            
            let ballFour = SCNScene(named: "art.scnassets/ship.scn")!
            let ballFourNode = ballFour.rootNode.childNodes.first!
            ballFourNode.scale.x = 0.05
            ballFourNode.scale.y = 0.05
            ballFourNode.scale.z = 0.05
            ballFourNode.position = SCNVector3Zero
            ballFourNode.position.z = 0.01
            ballFourNode.position.y = -height/2
            ballFourNode.position.x = width/2
            
            planeNode.addChildNode(ballFourNode)
            
            let arrow = SCNScene(named: "art.scnassets/torus.scn")!
            let arrowNode = arrow.rootNode.childNodes.first!
            arrowNode.scale.x = 0.12
            arrowNode.scale.y = 0.12
            arrowNode.scale.z = 0.12
            arrowNode.position = SCNVector3Zero
            arrowNode.position.z = 0.01
            arrowNode.position.y = -height/3
            arrowNode.position.x = 0
            arrowNode.eulerAngles.x = -.pi/2
            planeNode.addChildNode(arrowNode)
            
            
            node.addChildNode(planeNode)
            
        }
        
        return node
        
    }
    
    
}
