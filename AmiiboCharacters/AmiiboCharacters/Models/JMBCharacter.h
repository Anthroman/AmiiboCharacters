//
//  JMBCharacter.h
//  AmiiboCharacters
//
//  Created by Anthroman on 3/26/20.
//  Copyright © 2020 Anthroman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMBCharacter : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *game;
@property (nonatomic, copy, readonly) NSString *releaseDate;
@property (nonatomic, copy, readonly) NSString *image;

- (instancetype)initWithCharacter:(NSString *)character game:(NSString *)game releaseDate:(NSString *)releaseDate image:(NSString *)image;

@end

@interface JMBCharacter (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
