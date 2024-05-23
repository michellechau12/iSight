//
//  ObjectDetection.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 21/05/24.
//

import Vision
import CoreML
import CoreImage

class ObjectDetector: ObservableObject {
    private var requests = [VNRequest]()
    @Published var detectedObjects: String = ""
    
    init() {
        setupModel()
    }
    
    private func setupModel() {
        do {
            guard let yoloV3modelURL = Bundle.main.url(forResource: "YOLOv3Int8LUT", withExtension: "mlmodelc") else {fatalError("model file not found")}
            
            let yoloV3Model =  try VNCoreMLModel(for: MLModel(contentsOf: yoloV3modelURL))
            let recognitionRequest = VNCoreMLRequest(model: yoloV3Model, completionHandler: self.handleDetectedObjects) //VNCoreMLRequest is created with the model, will be used to perform object detection
            self.requests = [recognitionRequest]
        } catch {
            fatalError("failed to load model: \(error)")
        }
    }
    
    func detectObjects(from sampleBuffer: CMSampleBuffer) { //CMSampleBuffer contains the video frame data
        let requestOptions: [VNImageOption: Any] = [:]
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let ciImage = CIImage(cvImageBuffer: imageBuffer) //convert CMSampleBuffer to CIImage
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: requestOptions)
        
        do {
            try imageRequestHandler.perform(self.requests) //performs the object detection requests with yolo
        } catch {
            print("Failed to perform object detection: \(error.localizedDescription)")
        }
    }
    
    private func handleDetectedObjects(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNRecognizedObjectObservation] else {return} //extracts the detection results from the request
        
        var objects = ""
        for observation in results {
            if let topLabel = observation.labels.first { //retrieves the top label of dtected objects
                objects += topLabel.identifier + ", "
            }
            
        }
        
        DispatchQueue.main.async {
            self.detectedObjects = objects //update with the detected objects
        }
        
    }
}
