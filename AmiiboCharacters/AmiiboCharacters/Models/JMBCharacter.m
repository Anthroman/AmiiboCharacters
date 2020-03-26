//
//  JMBCharacter.m
//  AmiiboCharacters
//
//  Created by Anthroman on 3/26/20.
//  Copyright © 2020 Anthroman. All rights reserved.
//

#import "JMBCharacter.h"

@implementation JMBCharacter

- (instancetype)initWithCharacter:(NSString *)character game:(NSString *)game releaseDate:(NSString *)releaseDate image:(NSString *)image
{
    self = [self init];
    if (self)
    {
        _name = character;
        _game = game;
        _releaseDate = releaseDate;
        _image = image;
    }
    return self;
}
@end

@implementation JMBCharacter (JSONConvertable)

// the variable "dictionary" here is our topLevelJSON
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *character = dictionary[@"name"];
    NSString *game = dictionary[@"amiiboSeries"];
    NSString *image = dictionary[@"image"];
    
    NSDictionary *releaseDictionary = dictionary[@"release"];
    NSString *releaseDate = releaseDictionary[@"na"];
    
    return [self initWithCharacter:character game:game releaseDate:releaseDate image:image];
}

@end
