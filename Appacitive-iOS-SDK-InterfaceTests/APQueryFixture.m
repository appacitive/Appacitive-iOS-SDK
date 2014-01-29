////
////  APQueryTest.m
////  Appacitive-iOS-SDK
////
////  Created by Kauserali Hafizji on 06/09/12.
////  Copyright (c) 2012 Appacitive Software Pvt. Ltd. All rights reserved.
////
//
#import "APQueryFixture.h"
#import "APQuery.h"
#import <CoreLocation/CoreLocation.h>
//
///**
// Test methods to test the interface of the APQuery class
// */
@implementation APQueryFixture
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testEqualityHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isEqualTo:@"test"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testEqualityHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isEqualTo:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the equality helper method is generating the correct string.
// */
//- (void) testEqualityHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"name"] isEqualTo:@"Pratik"] stringForm];
//    STAssertEqualObjects(query, @"*name == 'Pratik'",@"Test case for equality helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testInEqualityHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isNotEqualTo:@"test"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testInEqualityHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isNotEqualTo:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the inequality helper method is generating the correct string.
// */
//- (void) testInEqualityHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"name"] isNotEqualTo:@"Pratik"] stringForm];
//    STAssertEqualObjects(query, @"*name <> 'Pratik'",@"Test case for equality helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testLikeHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isLike:@"something"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testLikeHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isLike:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the like helper method is generating the correct string.
// */
//- (void) testLikeHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"createdBy"] isLike:@"John"] stringForm];
//    STAssertEqualObjects(query, @"*createdBy like 'John'",@"Test case for like helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testStartsWithHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] startsWith:@"something"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testStartsWithHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] startsWith:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the startsWith helper method is generating the correct string.
// */
//- (void) testStartsWithHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"createdBy"] startsWith:@"John"] stringForm];
//    STAssertEqualObjects(query, @"*createdBy like 'John*'",@"Test case for like helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testEndsWithHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] endsWith:@"something"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testEndssWithHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] endsWith:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the endsWith helper method is generating the correct string.
// */
//- (void) testEndsWithHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"createdBy"] endsWith:@"John"] stringForm];
//    STAssertEqualObjects(query, @"*createdBy like '*John'",@"Test case for like helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testMatchHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] matches:@"something"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testMatchHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] matches:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the matches helper method is generating the correct string.
// */
//- (void) testMatchHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"createdBy"] matches:@"John"] stringForm];
//    STAssertEqualObjects(query, @"*createdBy match 'John'",@"Test case for like helper method failed");
//}
//
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testBetweenHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isBetween:@"something" and:@"something"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testBetweenHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isBetween:nil and:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the between helper method is generating the correct string.
// */
//- (void) testBetweenHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"percentage"] isBetween:@"10" and:@"20"] stringForm];
//    STAssertEqualObjects(query, @"*percentage between ('10','20')",@"Test case for like helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testGreaterThanHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isGreaterThan:@"test"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testGreaterThanHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isGreaterThan:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the greater than helper method is generating the correct string.
// */
//- (void) testGreaterThanHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"cost"] isGreaterThan:@"123"] stringForm];
//    STAssertEqualObjects(query, @"*cost > '123'",@"Test case for greater than helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testGreaterThanOrEqualToHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isGreaterThanOrEqualTo:@"test"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testGreaterThanOrEqualToHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isGreaterThanOrEqualTo:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the greater than helper method is generating the correct string.
// */
//- (void) testGreaterThanOrEqualToHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"cost"] isGreaterThanOrEqualTo:@"123"] stringForm];
//    STAssertEqualObjects(query, @"*cost >= '123'",@"Test case for greater than helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testLessThanHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isLessThan:@"test"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testLessThanHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isLessThan:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the less than helper method is generating the correct string.
// */
//- (void) testLessThanHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"cost"] isLessThan:@"123"] stringForm];
//    STAssertEqualObjects(query, @"*cost < '123'",@"Test case for like helper method failed");
//}
//
///**
// @purpose To test for nil propertyName
// @expected The generated query should be nil
// */
//- (void) testLessThanOrEqualToHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isLessThanOrEqualTo:@"test"] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed.");
//}
//
///**
// @purpose To test for nil propertyValue
// @expected The generated query should be nil
// */
//- (void) testLessThanOrEqualToHelperMethodForNilPropertyValue {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"location"] isLessThanOrEqualTo:nil] stringForm];
//    STAssertNil(query, @"Test case for nil property value failed.");
//}
//
///**
// @purpose Test if the less than helper method is generating the correct string.
// */
//- (void) testLessThanOrEqualToHelperMethod {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"cost"] isLessThanOrEqualTo:@"123"] stringForm];
//    STAssertEqualObjects(query, @"*cost <= '123'",@"Test case for like helper method failed");
//}
//
//
///**
// @purpose Test page size helper method
// */
//- (void) testPageSizeHelperMethod {
//    NSUInteger integer = 123;
//    NSString *query = [APQuery queryWithPageSize:integer];
//    STAssertEqualObjects(query, @"psize=123", @"Test case for page size helper method failed");
//}
//
///**
// @purpose Test page number helper method
// */
//- (void) testPageNumberHelperMethod {
//    NSUInteger integer = 123;
//    NSString *query = [APQuery queryWithPageNumber:integer];
//    STAssertEqualObjects(query, @"pnum=123", @"Test case for page number helper method failed");
//}
//
///**
// @purpose Test for nil property name.
// @expected Query string should be nil
// */
//- (void) testEqualityDateHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isEqualToDate:[NSDate date]] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed");
//}
//
///**
// @purpose Test for nil date.
// @expected Query string should be nil
// */
//- (void) testEqualityDateHelperMethodForNilDate {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"date"] isEqualToDate:nil] stringForm];
//    STAssertNil(query, @"Test case for nil date parameter failed");
//}
//
///**
// @purpose Test date equality helper method
// */
//- (void) testEqualityDateHelperMethod {
//    NSDate *date = [NSDate date];
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"date" ] isEqualToDate:date] stringForm];
//    
//    NSString *expectedQuery = [NSString stringWithFormat:@"*date == date('%@')", date.description];
//    STAssertEqualObjects(query, expectedQuery, 
//                         @"Test case for equality date helper method failed");
//}
//
///**
// @purpose Test for nil property name.
// @expected Query string should be nil
// */
//- (void) testInEqualityDateHelperMethodForNilPropertyName {
//    NSString *query = [[[APQuery queryExpressionWithProperty:nil] isEqualToDate:[NSDate date]] stringForm];
//    STAssertNil(query, @"Test case for nil property name failed");
//}
//
///**
// @purpose Test for nil date.
// @expected Query string should be nil
// */
//- (void) testInEqualityDateHelperMethodForNilDate {
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"date"] isEqualToDate:nil] stringForm];
//    STAssertNil(query, @"Test case for nil date parameter failed");
//}
//
///**
// @purpose Test date equality helper method
// */
//- (void) testInEqualityDateHelperMethod {
//    NSDate *date = [NSDate date];
//    NSString *query = [[[APQuery queryExpressionWithProperty:@"date" ] isNotEqualToDate:date] stringForm];
//    
//    NSString *expectedQuery = [NSString stringWithFormat:@"*date <> date('%@')", date.description];
//    STAssertEqualObjects(query, expectedQuery,
//                         @"Test case for equality date helper method failed");
//}
//
///**
// @purpose Test if the boolean-OR query helper method is generating the correct string.
// */
//- (void) testBooleanORQueryHelperMethod {
//    APCompoundQuery *query = [APQuery booleanOr:[NSArray arrayWithObjects:[[APQuery queryExpressionWithAttribute:@"username"] isEqualTo:@"ppatel"],[[APQuery queryExpressionWithProperty:@"firstname"] isEqualTo:@"Pratik"], nil]];
//    //    NSString *query = [APQuery queryWithEqualCondition:@"createdBy" propertyValue:@"John"];
//    STAssertEqualObjects([query stringForm], @"(@username == 'ppatel' OR *firstname == 'Pratik')",@"Test case for equality helper method failed");
//}
//
//
///**
// @purpose Test if the boolean-AND query helper method is generating the correct string.
// */
//- (void) testBooleanANDQueryHelperMethod {
//    APCompoundQuery *query = [APQuery booleanAnd:[NSArray arrayWithObjects:[[APQuery queryExpressionWithAttribute:@"username"] isEqualTo:@"ppatel"],[[APQuery queryExpressionWithProperty:@"firstname"] isEqualTo:@"Pratik"], nil]];
//    //    NSString *query = [APQuery queryWithEqualCondition:@"createdBy" propertyValue:@"John"];
//    STAssertEqualObjects([query stringForm], @"(@username == 'ppatel' AND *firstname == 'Pratik')",@"Test case for equality helper method failed");
//}
//
///**
// @purpose Test if the compound query helper method is generating the correct string.
// */
//- (void) testCompoundQueryHelperMethod {
//    APCompoundQuery *query = [APQuery booleanOr:[NSArray arrayWithObjects:[[APQuery queryExpressionWithAttribute:@"username"] isEqualTo:@"ppatel"],[APQuery booleanAnd:[NSArray arrayWithObjects:[[APQuery queryExpressionWithProperty:@"firstname"] isEqualTo:@"Pratik"], [[APQuery queryExpressionWithProperty:@"lastname"] isEqualTo:@"Patel"], nil]], nil]];
//    //    NSString *query = [APQuery queryWithEqualCondition:@"createdBy" propertyValue:@"John"];
//    STAssertEqualObjects([query stringForm], @"(@username == 'ppatel' OR (*firstname == 'Pratik' AND *lastname == 'Patel'))",@"Test case for equality helper method failed");
//}
//
///**
// @purpose Test polygon search helper method for nil property name
// @expected Nil query string
// */
//- (void) testPolygonsearchAllNilPropertyName {
//    NSString *query = [APQuery queryWithPolygonSearchForProperty:nil withPolygonCoordinates:[NSArray array]];
//    STAssertNil(query, @"Test for nil property name failed");
//}
//
///**
// @purpose Test polygon search helper method for nil coordinates
// @expected Nil query string
// */
//- (void) testPolygonsearchAllNilCoordinates {
//    NSString *query = [APQuery queryWithPolygonSearchForProperty:@"location" withPolygonCoordinates:nil];
//    STAssertNil(query, @"Test for nil coordinates failed");
//}
//
///**
// @purpose Test polygon search helper method with less than 3 coordinates
// @expected Nil query string
// */
//- (void) testPolygonsearchAllLessThan3Coordinates {
//    NSString *query = [APQuery queryWithPolygonSearchForProperty:@"location" withPolygonCoordinates:[NSArray array]];
//    STAssertNil(query, @"Test for less than 3 coordinates failed");
//}
//
///**
// @purpose Test polygon search helper method
// */
//- (void) testPolygonSearchHelperMethod {
//    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:123 longitude:444];
//    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:200 longitude:300];
//    CLLocation *location3 = [[CLLocation alloc] initWithLatitude:400 longitude:500];
//    NSArray *coordinates = [NSArray arrayWithObjects:location1, location2, location3, nil];
//    
//    NSString *expectedString = @"*location within_polygon 123.000000,444.000000|200.000000,300.000000|400.000000,500.000000";
//    NSString *query = [APQuery queryWithPolygonSearchForProperty:@"location" withPolygonCoordinates:coordinates];
//    
//    STAssertEqualObjects(query, expectedString, @"Test case for polygon search failed");
//}
//
///**
// @purpose Test free text helper method for nil tokens
// @expected Query string should be nil
// */
//- (void) testFreeTextHelperMethodForNilTokens {
//    NSString *queryString = [APQuery queryWithSearchUsingFreeText:nil];
//    STAssertNil(queryString, @"Test case for nil free text tokens failed");
//}
//
///**
// @purpose Test free text helper method
// */
//- (void) testFreeTextHelperMethod {
//    NSString *expectedString = @"freeText=a b c";
//    NSString *queryString = [APQuery queryWithSearchUsingFreeText:[NSArray arrayWithObjects:@"a", @"b", @"c", nil]];
//    STAssertEqualObjects(queryString, expectedString, @"Test case for free text failed");
//}
//
///**
// @purpose Test one or more tags helper method for nil tags
// @expected Nil query string
// */
//- (void) testOneOrMoreTagsHelperMethodForNilTags {
//    NSString *queryString = [APQuery queryWithSearchUsingOneOrMoreTags:nil];
//    STAssertNil(queryString, @"Test for nil tags failed");
//}
//
///**
// @purpose Test one or more tags helper method
// */
//- (void) testOneOrMoreTagsHelperMethod {
//    NSArray *tags = [NSArray arrayWithObjects:@"a", @"b", nil];
//    
//    NSString *expectedString = @"tagged_with_one_or_more ('a,b')";
//    NSString *queryString = [APQuery queryWithSearchUsingOneOrMoreTags:tags];
//    STAssertEqualObjects(queryString, expectedString, @"Test case for one or more tags helper method failed");
//}
//
///**
// @purpose Test for all tags search helper method
// */
//- (void) testTagsWithAllHelperMethod {
//    NSArray *tags = [NSArray arrayWithObjects:@"a", @"b", nil];
//    
//    NSString *expectedString = @"tagged_with_all ('a,b')";
//    NSString *queryString = [APQuery queryWithSearchUsingAllTags:tags];
//    STAssertEqualObjects(queryString, expectedString, @"Test case for all tags helper method failed");
//}
//
///**
// @purpose Test for geocode helper method
// */
//- (void) testGeoCodeHelperMethod {
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:123 longitude:200];
//    NSString *expectedString = @"*location within_circle 123.000000, 200.000000, 12.000000 km";
//    NSString *queryString = [APQuery queryWithRadialSearchForProperty:@"location" nearLocation:location withinRadius:[NSNumber numberWithInt:12] usingDistanceMetric:kKilometers];
//    
//    STAssertEqualObjects(queryString, expectedString, @"Test case for geo code helper method failed");
//}
//
///**
// @purpose Test for orderBy helper method
// */
//- (void) testAppendQueriesMethod {
//    NSString *expectedString = @"(@username == 'ppatel' OR *firstname == 'Pratik')&orderBy=name&isAsc=0";
//    APCompoundQuery *query1 = [APQuery booleanOr:[NSArray arrayWithObjects:[[APQuery queryExpressionWithAttribute:@"username"] isEqualTo:@"ppatel"],[[APQuery queryExpressionWithProperty:@"firstname"] isEqualTo:@"Pratik"], nil]];
//    NSString *query2 = [APQuery queryWithOrderBy:@"name" isAscending:NO];
//    NSString *queryString = [[query1 stringForm]stringByAppendingFormat:@"&%@", query2];
//    
//    STAssertEqualObjects(queryString, expectedString, @"Test case for geo code helper method failed");
//}

@end

