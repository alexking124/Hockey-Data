//
//  UIImageView+Remote.m
//  Hockey Data
//
//  Created by Alex King on 11/4/16.
//  Copyright © 2016 Alex King. All rights reserved.
//

#import "UIImageView+Remote.h"

@implementation UIImageView (Remote)

/*
 
 extension UIImageView {
 func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
 contentMode = mode
 URLSession.shared.dataTask(with: url) { (data, response, error) in
 guard
 let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
 let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
 let data = data, error == nil,
 let image = UIImage(data: data)
 else { return }
 DispatchQueue.main.async() { () -> Void in
 self.image = image
 }
 }.resume()
 }
 func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
 guard let url = URL(string: link) else { return }
 downloadedFrom(url: url, contentMode: mode)
 }
 }
 
 */

- (void)downloadImageFromURL:(NSString *)urlString {
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        }
    }] resume];
}

@end
