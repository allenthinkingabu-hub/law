import Cocoa
import PDFKit
import Vision

let path = "/Users/allen/Desktop/law/raw/notes/26商经郄鹏恩真金题.pdf"
guard let doc = PDFDocument(url: URL(fileURLWithPath: path)) else {
    print("Failed to open PDF")
    exit(1)
}

let args = CommandLine.arguments
let start = args.count > 1 ? (Int(args[1]) ?? 95) : 95
let end = args.count > 2 ? (Int(args[2]) ?? 105) : 105

for i in (start-1)..<min(end, doc.pageCount) {
    guard let page = doc.page(at: i) else { continue }
    let rect = page.bounds(for: .mediaBox)
    let img = NSImage(size: rect.size)
    img.lockFocus()
    guard let ctx = NSGraphicsContext.current?.cgContext else {
        img.unlockFocus()
        continue
    }
    page.draw(with: .mediaBox, to: ctx)
    img.unlockFocus()
    
    guard let cgImg = img.cgImage(forProposedRect: nil, context: nil, hints: nil) else { continue }
    let req = VNRecognizeTextRequest()
    req.recognitionLanguages = ["zh-Hans", "en-US"]
    req.recognitionLevel = .accurate
    let handler = VNImageRequestHandler(cgImage: cgImg)
    try? handler.perform([req])
    
    print("\n=== PAGE \(i+1) ===")
    if let results = req.results {
        for obs in results {
            if let cand = obs.topCandidates(1).first {
                print(cand.string)
            }
        }
    }
    fflush(stdout)
}
