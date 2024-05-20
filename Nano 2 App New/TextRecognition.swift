//
//  TextRecognition.swift
//  Nano 2 App New
//
//  Created by Michelle Chau on 20/05/24.
//

import Vision
import AVFoundation
import CoreImage

class TextRecognizer: ObservableObject {
    private var requests = [VNRequest]()
    @Published var recognizedText: String = ""

    init() {
        setupVision()
    }

    private func setupVision() {
        let textRecognitionRequest = VNRecognizeTextRequest(completionHandler: self.handleDetectedText)
        textRecognitionRequest.recognitionLevel = .accurate
        self.requests = [textRecognitionRequest]
    }

    func recognizeText(from sampleBuffer: CMSampleBuffer) {
        let requestOptions: [VNImageOption: Any] = [:]
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvImageBuffer: imageBuffer)
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: requestOptions)

        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print("Failed to perform text recognition: \(error.localizedDescription)")
        }
    }

    private func handleDetectedText(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

        var detectedText = ""
        for observation in observations {
            guard let topCandidate = observation.topCandidates(1).first else { continue }
            detectedText += topCandidate.string + " "
        }

        DispatchQueue.main.async {
            self.recognizedText = detectedText
        }
    }
}


