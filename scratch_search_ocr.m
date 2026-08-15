#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <PDFKit/PDFKit.h>
#import <Vision/Vision.h>
#import <CoreGraphics/CoreGraphics.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *path = @"/Users/allen/Desktop/law/raw/notes/26商经郄鹏恩真金题.pdf";
        NSURL *url = [NSURL fileURLWithPath:path];
        PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
        if (!doc) {
            NSLog(@"Failed to load PDF");
            return 1;
        }
        
        NSUInteger start = 1;
        NSUInteger end = [doc pageCount];
        if (argc >= 3) {
            start = atoi(argv[1]);
            end = atoi(argv[2]);
        }
        printf("Searching pages %lu to %lu...\n", (unsigned long)start, (unsigned long)end);
        fflush(stdout);
        
        NSArray *keywords = @[@"人格否认", @"人格混同", @"第23条", @"第二十三条", @"横向穿透", @"三角刺破", @"刺破公司面纱", @"过度支配"];
        
        for (NSUInteger i = start - 1; i < end && i < [doc pageCount]; i++) {
            @autoreleasepool {
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
                request.recognitionLevel = VNRequestTextRecognitionLevelFast;
                
                VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:cgImage options:@{}];
                [handler performRequests:@[request] error:nil];
                
                NSMutableString *pageText = [NSMutableString string];
                for (VNRecognizedTextObservation *obs in request.results) {
                    VNRecognizedText *topCandidate = [[obs topCandidates:1] firstObject];
                    if (topCandidate) {
                        [pageText appendFormat:@"%@\n", topCandidate.string];
                    }
                }
                
                for (NSString *kw in keywords) {
                    if ([pageText containsString:kw]) {
                        printf("\n>>> [MATCH ON PAGE %lu (Book page ~%03d)] keyword '%s':\n", (unsigned long)(i + 1), (int)(i + 1 - 13), [kw UTF8String]);
                        NSArray *lines = [pageText componentsSeparatedByString:@"\n"];
                        for (NSString *line in lines) {
                            if ([line containsString:kw] || [line containsString:@"金题"] || [line containsString:@"考点"] || [line containsString:@"【题干"] || [line containsString:@"［题干"]) {
                                printf("  %s\n", [line UTF8String]);
                            }
                        }
                        fflush(stdout);
                        break;
                    }
                }
            }
        }
        printf("\nSearch completed.\n");
        fflush(stdout);
    }
    return 0;
}
