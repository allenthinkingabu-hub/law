#import <Foundation/Foundation.h>
#import <PDFKit/PDFKit.h>
#import <Vision/Vision.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *pdfPath = @"/Users/allen/Desktop/law/raw/notes/26商经郄鹏恩真金题.pdf";
        NSURL *url = [NSURL fileURLWithPath:pdfPath];
        PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
        if (!doc) {
            printf("Error: Cannot load PDF\n");
            return 1;
        }
        
        printf("PDF Total Pages: %lu\n", (unsigned long)[doc pageCount]);
        
        VNRecognizeTextRequest *request = [[VNRecognizeTextRequest alloc] init];
        request.recognitionLevel = VNRequestTextRecognitionLevelAccurate;
        request.recognitionLanguages = @[@"zh-Hans", @"en-US"];
        request.usesLanguageCorrection = YES;
        
        // Let's OCR pages 1 to 20 to see questions 1 to 25
        for (NSUInteger i = 0; i < 20; i++) {
            PDFPage *page = [doc pageAtIndex:i];
            NSData *data = [page dataRepresentation];
            CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
            if (!source) continue;
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, 0, NULL);
            CFRelease(source);
            if (!image) continue;
            
            VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:image options:@{}];
            CGImageRelease(image);
            
            NSError *error = nil;
            [handler performRequests:@[request] error:&error];
            if (error) continue;
            
            NSMutableString *pageText = [NSMutableString string];
            for (VNRecognizedTextObservation *obs in request.results) {
                VNRecognizedText *top = [[obs topCandidates:1] firstObject];
                if (top) {
                    [pageText appendFormat:@"%@\n", top.string];
                }
            }
            
            printf("=== PAGE %lu ===\n", (unsigned long)(i + 1));
            // Check if page mentions 考点 or 题号
            printf("%s\n", [pageText UTF8String]);
        }
    }
    return 0;
}
