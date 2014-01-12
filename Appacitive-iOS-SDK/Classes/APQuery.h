//
//  APQuery.h
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 05/09/12.
//  Copyright (c) 2012 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef enum {
    kKilometers,
    kMiles
} DistanceMetric;

typedef enum {
    kAnd,
    kOr
} BooleanOperator;

#pragma mark - SimpleQuery

@interface APSimpleQuery : NSObject

@property (strong, nonatomic) NSString *fieldName;
@property (strong, nonatomic) NSString *fieldType;
@property (strong, nonatomic) NSString *operation;
@property (strong, nonatomic) NSString *value;

- (NSString*) stringForm;

@end

#pragma mark - CompoundQuery

@interface APCompoundQuery : APSimpleQuery

@property (nonatomic) BooleanOperator boolOperator;
@property (nonatomic, strong, readonly) NSMutableArray *innerQueries;

- (instancetype) init;

- (NSString*) stringForm;

@end

#pragma mark - QueryExpression

@interface APQueryExpression : APSimpleQuery {
    NSString *_name;
    NSString *_type;
}

/**
 Helper method to generate an equal to query string.
 
 @param propertyName name of the property to search for.
 @param propertyValue the value of the property to equate to.
 
 Example query would be +[APQuery queryForEqualCondition:@"hotelName" propertyValue:@"Le Meridian"]
 This would return "*hotelName == 'Le Meridian'" which is the format Appacitive understands.
 */
- (APSimpleQuery *) isEqualTo:(NSString*)value;

/**
 Helper method to generate an equal to query string.
 
 @param propertyName name of the property to search for
 @param date the date to equate to.
 
 Example query would be +[APQuery queryForEqualCondition:@"checkinDate" date:someDate]
 This would return "*checkinDate == date(someDate.description)'" which is the format Appacitive understands
 */
- (APSimpleQuery *) isEqualToDate:(NSDate*)date;

/**
 Helper method to generate a not equal to query string.
 
 @param propertyName name of the property to search for.
 @param propertyValue the value of the property to equate to.
 
 Example query would be +[APQuery queryForNotEqualCondition:@"hotelName" propertyValue:@"Le Meridian"]
 This would return "*hotelName != 'Le Meridian'" which is the format Appacitive understands.
 */
- (APSimpleQuery *) isNotEqualTo:(NSString*)value;

/**
 Helper method to generate a not equal to query string.
 
 @param propertyName name of the property to search for
 @param date the date to equate to.
 
 Example query would be +[APQuery queryForNotEqualCondition:@"checkinDate" date:someDate]
 This would return "*checkinDate != date(someDate.description)'" which is the format Appacitive understands
 */
- (APSimpleQuery *) isNotEqualToDate:(NSDate*)date;

/**
 Helper method to generate a greater than query string.
 
 @param propertyName name of the property to search for
 @param propertyValue value that the property should be greater than.
 
 Example query would be +[APQuery queryForGreaterThanCondition:@"cost" propertyValue:[NSString stringWithFormat@"%d", 123]]
 This would return "*cost > '123'" which is the format Appacitive understands
 */
- (APSimpleQuery *) isGreaterThan:(NSString*)value;

/**
 Helper method to generate a less than query string.
 
 @param propertyName name of the property to search for
 @param propertyValue the value the property should be less than.
 
 Example query would be +[APQuery queryForLessThanCondition:@"cost" propertyValue:[NSString stringWithFormat@"%d", 123]]
 This would return "*cost < '123'" which is the format Appacitive understands
 */
- (APSimpleQuery *) isLessThan:(NSString*)value;

/**
 Helper method to generate a greater than or eqal to query string.
 
 @param propertyName name of the property to search for
 @param propertyValue value that the property should be greater than or equal to.
 
 Example query would be +[APQuery queryForGreaterThanOrEqualToCondition:@"cost" propertyValue:[NSString stringWithFormat@"%d", 123]]
 This would return "*cost >= '123'" which is the format Appacitive understands
 */
- (APSimpleQuery *) isGreaterThanOrEqualTo:(NSString*)value;

/**
 Helper method to generate a less than or equal to query string.
 
 @param propertyName name of the property to search for
 @param propertyValue the value the property should be less than or equal to.
 
 Example query would be +[APQuery queryForLessThanOrEqualToCondition:@"cost" propertyValue:[NSString stringWithFormat@"%d", 123]]
 This would return "*cost <= '123'" which is the format Appacitive understands
 */
- (APSimpleQuery *) isLessThanOrEqualTo:(NSString*)value;

/**
 Helper method to generate a query string for like condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 
 Example query would be +[APQuery queryForLikeCondition:@"hotelName" propertyValue:@"Le Meridian"]
 This would return "*hotelName like 'Le Meridian'" which is the format Appacitive understands
 */
- (APSimpleQuery *) isLike:(NSString*)Value;

/**
 Helper method to generate a query string for like condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 
 Example query would be +[APQuery queryForLikeCondition:@"hotelName" propertyValue:@"Le*"]
 This would return "*hotelName like 'Le*'" which is the format Appacitive understands
 */
- (APSimpleQuery *) startsWith:(NSString*)value;


/**
 Helper method to generate a query string for like condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 
 Example query would be +[APQuery queryForLikeCondition:@"hotelName" propertyValue:@"*Meridian"]
 This would return "*hotelName like '*Meridian'" which is the format Appacitive understands
 */
- (APSimpleQuery *) endsWith:(NSString*)value;

/**
 Helper method to generate a query string for match condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 
 Example query would be +[APQuery queryForLikeCondition:@"hotelName" propertyValue:@"Le Meridian"]
 This would return "*hotelName match 'Le Meridian'" which is the format Appacitive understands
 */
- (APSimpleQuery *) matches:(NSString*)value;

/**
 Helper method to generate a between query string.
 
 @param propertyName name of the property to search for
 @param propertyValue1 the lower end value of the property
 @param propertyValue2 the higher end value of the property
 
 Example query would be +[APQuery queryForBetweenCondition:@"cost" propertyValue1:[NSString stringWithFormat@"%d", 100] propertyValue2:[NSString stringWithFormat:@"%d",200]];
 This would return "*cost between ('100','200')" which is the format Appacitive understands
 */
- (APSimpleQuery *) isBetween:(NSString*)value1 and:(NSString*)value2;


- (instancetype) initWithProperty:(NSString*)name ofType:(NSString*)type;

@end

#pragma mark - Query

@interface APQuery : APSimpleQuery

+ (APQueryExpression*) queryExpressionWithProperty:(NSString*)property;

+ (APQueryExpression*) queryExpressionWithAttribute:(NSString*)attribute;

+ (APQueryExpression*) queryExpressionWithAggregate:(NSString*)aggregate;

+ (APCompoundQuery *) booleanAnd:(NSArray*)queries;

+ (APCompoundQuery *) booleanOr:(NSArray*)queries;

/**
 Helper method to generate a query string for page size.
 
 @param pageSize an integer value for the page size.
 
 Example query would be +[APQuery queryForPageSize:2]
 This would return "psize=(2)" which is the format Appacitive understands
 */
+ (NSString *) queryWithPageSize:(NSUInteger)pageSize;

/**
 Helper method to generate a query string for page number.
 
 @param pageNumber the page number to get
 
 Example query would be +[APQuery queryForPageNumber:123]
 This would return "pnum=(123)" which is the format Appacitive understands
 */
+ (NSString *) queryWithPageNumber:(NSUInteger)pageNumber;

/**
 Helper method to generate a query string for geocode search.
 
 @param propertyName name of the property to search for
 @param location the geocode to search for
 @param distanceMetric the distance either in km or miles
 @param radius the radios around the location to look for
 
 Example query would be +[APQuery queryForGeoCodeProperty:@"location" location:{123, 123} distance:kilometers raduis:12]
 This would return "*location within_circle 123,123,12" which is the format Appacitive understands.
 */
+ (NSString *) queryWithGeoCodeSearchForProperty:(NSString*)propertyName location:(CLLocation*)location distance:(DistanceMetric)distanceMetric raduis:(NSNumber*)radius;

/**
 Helper method to generate a query string for polygon search.
 
 @param propertyName name of the property to search for
 @param coordinates an array of CLLocation coordinates. The array needs to have a minimum of three coordinates.
 
 Example query would be +[APQuery queryForPolygonSearch:@"location" withPolygonCoordinates:coordinates]
 This would return "*location within_polygon {lat,long} | {lat,long} | {lat,long}" which is the format Appacitive understands.
 */
+ (NSString *) queryWithPolygonSearchForProperty:(NSString*)propertyName withPolygonCoordinates:(NSArray*)coordinates;

/**
 Helper method to generate a query string for search with tags.
 
 @param tags an array of tags to search for.
 
 Example query would be +[APQuery queryForSearchWithOneOrMoreTags:array]
 This would return "tagged_with_one_or_more ('tag1,tag2')" where tag1 and tag2 are in array, which is the format Appacitive understands
 */
+ (NSString *) queryWithSearchUsingOneOrMoreTags:(NSArray*)tags;

/**
 Helper method to generate a query string for search with tags.
 
 @param tags an array of tags to search for.
 
 Example query would be +[APQuery queryForSearchWithAllTags:array]
 This would return "tagged_with_all ('tag1,tag2')" where tag1 and tag2 are in array, which is the format Appacitive understands
 */
+ (NSString *) queryWithSearchUsingAllTags:(NSArray*)tags;

/**
 Helper method to generate a query string to search for free text.
 
 @param freeTextTokens
 */
+ (NSString *) queryWithSearchUsingFreeText:(NSArray*)freeTextTokens;

/**
 Helper method to generate a query string to fetch specific fields.
 
 @param Array of field name strings
 */
+ (NSString *) queryWithFields:(NSArray*)fields;

@end

