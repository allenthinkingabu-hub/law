#import <Foundation/Foundation.h>
#import <PDFKit/PDFKit.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *path = @"/Users/allen/Desktop/law/raw/notes/26商经郄鹏恩真金题.pdf";
        NSURL *url = [NSURL fileURLWithPath:path];
        PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
        if (!doc) {
            NSLog(@"Failed to load PDF");
            return 1;
        }
        NSUInteger count = [doc pageCount];
        NSUInteger textPages = 0;
        for (NSUInteger i = 0; i < count; i++) {
            PDFPage *page = [doc pageAtIndex:i];
            NSString *str = [page string];
            if (str && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
                textPages++;
                if (textPages <= 5) {
                    printf("Page %lu has text (%lu chars): %s\n", (unsigned long)(i+1), (unsigned long)str.length, [[str substringToIndex:MIN((NSUInteger)80, str.length)] UTF8String]);
                }
            }
        }
        printf("Total text pages: %lu / %lu\n", (unsigned long)textPages, (unsigned long)count);
    }
    return 0;
}
