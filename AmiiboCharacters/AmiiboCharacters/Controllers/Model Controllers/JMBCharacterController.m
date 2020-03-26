//
//  JMBCharacterController.m
//  AmiiboCharacters
//
//  Created by Anthroman on 3/26/20.
//  Copyright © 2020 Anthroman. All rights reserved.
//

#import "JMBCharacterController.h"
#import "JMBCharacter.h"
#import <UIKit/UIKit.h>

static NSString *const baseURLString = @"https://www.amiiboapi.com/api/amiibo/";
static NSString *const characterComponent = @"character";

@implementation JMBCharacterController

// MARK: - Shared Instance
+ (JMBCharacterController *) shared {
    static JMBCharacterController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [JMBCharacterController new];
    });
    return shared;
}

// MARK: - Properties
- (NSURL *) baseURL
{
    return [NSURL URLWithString: baseURLString];
}

// MARK: - Fetch

- (void)searchForCharacterWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<JMBCharacter *> * _Nonnull, NSError * _Nullable))completion
{
    // base URL
    NSURL *baseURL = [self baseURL];
    
    // create an array to hold queryitem key-value pairs
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    // create character query
    NSURLQueryItem *characterQuery = [[NSURLQueryItem alloc] initWithName:characterComponent value:searchTerm];
    
    // add character query to the empty array I just created
    [queryItems addObject:characterQuery];
    
    // set up baseURL to receive urlComponents
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:true];
    
    // add the query items to urlcomponents
    [urlComponents setQueryItems:queryItems];
    
    // create finalURL including the query items
    NSURL *finalURL = [urlComponents URL];
    
    // log it out to check for errors if something goes wrong
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion([NSArray new], nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
            
            // array of dictionaries
            NSArray *characterArray = jsonDictionary[@"amiibo"];
            
            NSMutableArray *characters = [NSMutableArray array];
            
            for (NSDictionary *characterDictionary in characterArray) {
                JMBCharacter *character = [[JMBCharacter alloc] initWithDictionary:characterDictionary];
                [characters addObject:character];
            }
            completion(characters, nil);
        }
    }] resume];
}

-(void)fetchCharacterImage:(JMBCharacter *)character completion:(void (^)(UIImage * _Nullable))completion
{
    NSString *characterImageString = [[NSString alloc] initWithFormat:@"%@", character.image];
    
    NSURL *characterImageURL = [[NSURL alloc] initWithString:characterImageString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:characterImageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error handling image %@", error);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error: no data returned from image task %@", error);
            completion(nil);
            return;
        }
        
        UIImage *characterImage = [[UIImage alloc] initWithData:data];
        completion(characterImage);
    }]resume];
}

@end
