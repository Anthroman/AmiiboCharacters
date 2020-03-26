//
//  JMBCharacterController.h
//  AmiiboCharacters
//
//  Created by Anthroman on 3/26/20.
//  Copyright © 2020 Anthroman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMBCharacter;

NS_ASSUME_NONNULL_BEGIN

@interface JMBCharacterController : NSObject

+ (instancetype)shared;

- (void)searchForCharacterWithSearchTerm:(NSString *)searchTerm completion:(void(^) (NSArray<JMBCharacter *> *posts, NSError *error))completion;

- (void)fetchCharacterImage:(JMBCharacter *)character completion:(void(^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
