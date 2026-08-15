#import <Cocoa/Cocoa.h>
#import <PDFKit/PDFKit.h>
#import <Vision/Vision.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *path = @"/Users/allen/Desktop/law/raw/notes/26商经郄鹏恩真金题.pdf";
        NSURL *url = [NSURL fileURLWithPath:path];
        PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
        if (!doc) {
            printf("Failed to load PDF\n");
            return 1;
        }
        
        NSUInteger startPage = 1;
        NSUInteger endPage = 10;
        if (argc >= 3) {
            startPage = atoi(argv[1]);
            endPage = atoi(argv[2]);
        }
        
        printf("OCR on pages %lu to %lu\n", (unsigned long)startPage, (unsigned long)endPage);
        fflush(stdout);
        
        for (NSUInteger i = startPage - 1; i < endPage && i < [doc pageCount]; i++) {
            PDFPage *page = [doc pageAtIndex:i];
            NSRect bounds = [page boundsForBox:kPDFDisplayBoxMediaBox];
            
            NSImage *img = [[NSImage alloc] initWithSize:bounds.size];
            [img lockFocus];
            CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] CGContext];
            [page drawWithBox:kPDFDisplayBoxMediaBox toContext:context];
            [img unlockFocus];
            
            CGImageRef cgImage = [img CGImageForProposedRect:nil context:nil hints:nil];
            if (!cgImage) continue;
            
            VNRecognizeTextRequest *request = [[VNRecognizeTextRequest alloc] init];
            request.recognitionLanguages = @[@"zh-Hans", @"en-US"];
            request.recognitionLevel = VNRequestTextRecognitionLevelAccurate;
            request.usesLanguageCorrection = YES;
            
            VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:cgImage options:@{}];
            NSError *error = nil;
            [handler performRequests:@[request] error:&error];
            
            if (error) {
                printf("Error on page %lu\n", (unsigned long)(i+1));
                continue;
            }
            
            printf("\n--- PAGE %lu ---\n", (unsigned long)(i + 1));
            for (VNRecognizedTextObservation *obs in request.results) {
                VNRecognizedText *topCandidate = [[obs topCandidates:1] firstObject];
                if (topCandidate) {
                    printf("%s\n", [topCandidate.string UTF8String]);
                }
            }
            fflush(stdout);
        }
    }
    return 0;
}
