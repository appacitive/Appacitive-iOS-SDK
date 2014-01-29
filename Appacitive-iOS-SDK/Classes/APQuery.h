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

/**
 Method to generate a formatted string from the query object.
 */
- (NSString*) stringForm;

@end

#pragma mark - CompoundQuery

@interface APCompoundQuery : APSimpleQuery

@property (nonatomic) BooleanOperator boolOperator;
@property (nonatomic, strong, readonly) NSMutableArray *innerQueries;

/**
 Method to initialize an APCompoundQuery object.
 */
- (instancetype) init;

/**
 Method to generate a formatted string from the query object.
 */
- (NSString*) stringForm;

@end

#pragma mark - QueryExpression

@interface APQueryExpression : APSimpleQuery {
    NSString *_name;
    NSString *_type;
}

/**
 Helper method to generate an equal to query string.
 
 @param propertyName Name of the property to search for.
 @param propertyValue The value of the property to equate to.
*/
- (APSimpleQuery *) isEqualTo:(NSString*)value;

/**
 Helper method to generate an equal to query string for Date type.
 
 @param propertyName Name of the property to search for
 @param date The date to equate to.
 */
- (APSimpleQuery *) isEqualToDate:(NSDate*)date;

/**
 Helper method to generate a not equal to query string.
 
 @param propertyName name of the property to search for.
 @param propertyValue the value of the property to equate to.
  */
- (APSimpleQuery *) isNotEqualTo:(NSString*)value;

/**
 Helper method to generate a not equal to query string.
 
 @param propertyName name of the property to search for
 @param date the date to equate to.
 */
- (APSimpleQuery *) isNotEqualToDate:(NSDate*)date;

/**
 Helper method to generate a greater than query string.
 
 @param propertyName name of the property to search for
 @param propertyValue value that the property should be greater than.
 */
- (APSimpleQuery *) isGreaterThan:(NSString*)value;

/**
 Helper method to generate a less than query string.
 
 @param propertyName name of the property to search for
 @param propertyValue the value the property should be less than.
 */
- (APSimpleQuery *) isLessThan:(NSString*)value;

/**
 Helper method to generate a greater than or eqal to query string.
 
 @param propertyName name of the property to search for
 @param propertyValue value that the property should be greater than or equal to.
 */
- (APSimpleQuery *) isGreaterThanOrEqualTo:(NSString*)value;

/**
 Helper method to generate a less than or equal to query string.
 
 @param propertyName name of the property to search for
 @param propertyValue the value the property should be less than or equal to.
 */
- (APSimpleQuery *) isLessThanOrEqualTo:(NSString*)value;

/**
 Helper method to generate a greater than query string.
 
 @param propertyName name of the property to search for
 @param propertyValue value that the property should be greater than.
 */
- (APSimpleQuery *) isGreaterThanDate:(NSDate*)date;

/**
 Helper method to generate a less than query string.
 
 @param propertyName name of the property to search for
 @param propertyValue the value the property should be less than.
 */
- (APSimpleQuery *) isLessThanDate:(NSDate*)date;

/**
 Helper method to generate a greater than or eqal to query string.
 
 @param propertyName name of the property to search for
 @param propertyValue value that the property should be greater than or equal to.
 */
- (APSimpleQuery *) isGreaterThanOrEqualToDate:(NSDate*)date;

/**
 Helper method to generate a less than or equal to query string.
 
 @param propertyName name of the property to search for
 @param propertyValue the value the property should be less than or equal to.
 */
- (APSimpleQuery *) isLessThanOrEqualToDate:(NSDate*)date;

/**
 Helper method to generate a query string for like condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 */
- (APSimpleQuery *) isLike:(NSString*)Value;

/**
 Helper method to generate a query string for like condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 */
- (APSimpleQuery *) startsWith:(NSString*)value;


/**
 Helper method to generate a query string for like condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 */
- (APSimpleQuery *) endsWith:(NSString*)value;

/**
 Helper method to generate a query string for match condition.
 
 @param propertyName name of the property to search for
 @param propertyValue the value of the property.
 */
- (APSimpleQuery *) matches:(NSString*)value;

/**
 Helper method to generate a between query string.
 
 @param propertyName name of the property to search for
 @param propertyValue1 the lower end value of the property
 @param propertyValue2 the higher end value of the property
 */
- (APSimpleQuery *) isBetween:(NSString*)value1 and:(NSString*)value2;

/**
 Helper method to generate a between query string.
 
 @param propertyName name of the property to search for
 @param propertyValue1 the lower end value of the property
 @param propertyValue2 the higher end value of the property
 */
- (APSimpleQuery *) isBetweenDates:(NSDate*)date1 and:(NSDate*)date2;

- (instancetype) initWithProperty:(NSString*)name ofType:(NSString*)type;

@end

#pragma mark - Query

@interface APQuery : APSimpleQuery

/**
 Method to crete a query expression with query operand as a property of an APObject.
 
 @param property Name of the property that you wish to use as an operand of the query.
 */
+ (APQueryExpression*) queryExpressionWithProperty:(NSString*)property;

/**
 Method to crete a query expression with query operand as an attribute of an APObject.
 
 @param property Name of the attribute that you wish to use as an operand of the query.
 */
+ (APQueryExpression*) queryExpressionWithAttribute:(NSString*)attribute;

/**
 Method to crete a query expression with query operand as an aggregate of an APObject.
 
 @param property Name of the aggregate that you wish to use as an operand of the query.
 */
+ (APQueryExpression*) queryExpressionWithAggregate:(NSString*)aggregate;

/**
 Method to crete a compound query by boolean ANDing all the operands in the queries array.
 
 @param queries Array of operands for the boolean AND operation.
 */
+ (APCompoundQuery *) booleanAnd:(NSArray*)queries;

/**
 Method to crete a compound query by boolean ORing all the operands in the queries array.
 
 @param queries Array of operands for the boolean OR operation.
 */
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
 Helper method to generate a query string for page size and page number.
 
 @param property the property to be used for sorting
 @param isAscending ascending or descending order for sorting
 
 Example query would be +[APQuery queryWithOrderBy:@"name" isAscending:NO]
 This would return "orderBy='name'&isAsc=false" which is the format Appacitive understands
 */
+ (NSString *) queryWithOrderBy:(NSString*)property isAscending:(BOOL)isAscending;

/**
 Helper method to generate a query string for geocode search.
 
 @param propertyName name of the property to search for
 @param nearLocation the geocode to search for
 @param usingDistanceMetric the distance either in km or miles
 @param withinRadius the radios around the location to look for
 
 Example query would be +[APQuery queryForGeoCodeProperty:@"location" nearLocation:{123, 123} distanceMetric:kilometers radius:12]
 This would return "*location within_circle 123,123,12" which is the format Appacitive understands.
 */
+ (NSString *) queryWithRadialSearchForProperty:(NSString*)propertyName nearLocation:(CLLocation*)location withinRadius:(NSNumber*)radius usingDistanceMetric:(DistanceMetric)distanceMetric;

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

