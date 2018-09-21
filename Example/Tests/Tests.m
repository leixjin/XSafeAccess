//
//  XSafeAccessTests.m
//  XSafeAccessTests
//
//  Created by xiaolei.jin on 08/16/2016.
//  Copyright (c) 2016 xiaolei.jin. All rights reserved.
//

@import XCTest;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    [self arrayTest];
    [self array2Test];
    [self array3Test];
    
    [self mArrayTest];
    [self mArrayTest2];
    [self mArrayTest3];
    
    [self emptyArrayTest];
    [self emptyMArrayTest];
    
    [self dictionaryTest];
    [self dictionaryTest2];
    
    [self mDictionaryTest];
    [self mDictionaryTest2];
    
    [self emptyDictionaryTest];
    [self emptyMDictionaryTest];
}

#pragma mark - Array

- (void)arrayTest {
    NSArray *array = @[@1];
    
    [array objectAtIndex:1];
    __unused id xx = array[1];
    
    NSArray *resultArray = [array subarrayWithRange:NSMakeRange(0, 1)];
    XCTAssert([resultArray isEqualToArray:array], @"subarray 实现错误");
    
    NSArray *emptyArray0 = [array subarrayWithRange:NSMakeRange(1, 1)];
    XCTAssert(emptyArray0 == nil, @"subarray 实现错误");
    
    NSArray *emptyArray1 = [array subarrayWithRange:NSMakeRange(1, 0)];
    XCTAssert([emptyArray1 isEqualToArray:@[]], @"subarray 实现错误");
}

- (void)array2Test {
    NSArray *array = @[@1, @2];
    
    [array objectAtIndex:1];
    __unused id xx = array[2];
    
    NSArray *resultArray = [array subarrayWithRange:NSMakeRange(0, 2)];
    XCTAssert([resultArray isEqualToArray:array], @"subarray 实现错误");
    
    NSArray *emptyArray0 = [array subarrayWithRange:NSMakeRange(1, 2)];
    XCTAssert(emptyArray0 == nil, @"subarray 实现错误");
    
    NSArray *emptyArray1 = [array subarrayWithRange:NSMakeRange(1, 0)];
    XCTAssert([emptyArray1 isEqualToArray:@[]], @"subarray 实现错误");
}

- (void)array3Test {
    UIView *view = [UIView new];
    NSArray *array = @[@1, view];
    
    [array objectAtIndex:1];
    __unused id xx = array[2];
    
    NSArray *resultArray = [array subarrayWithRange:NSMakeRange(0, 2)];
    XCTAssert([resultArray isEqualToArray:array], @"subarray 实现错误");
    
    NSArray *emptyArray0 = [array subarrayWithRange:NSMakeRange(1, 2)];
    XCTAssert(emptyArray0 == nil, @"subarray 实现错误");
    
    NSArray *emptyArray1 = [array subarrayWithRange:NSMakeRange(1, 0)];
    XCTAssert([emptyArray1 isEqualToArray:@[]], @"subarray 实现错误");
}

- (void)emptyArrayTest {
    NSArray *emptyArray = @[];
    
    [emptyArray objectAtIndex:1];
    __unused id xx = emptyArray[1];
    
    NSArray *resultArray = [emptyArray subarrayWithRange:NSMakeRange(0, 1)];
    XCTAssert(resultArray == nil, @"subarray 实现错误");
    
    NSArray *emptyArray0 = [emptyArray subarrayWithRange:NSMakeRange(1, 1)];
    XCTAssert(emptyArray0 == nil, @"subarray 实现错误");
    
    NSArray *emptyArray1 = [emptyArray subarrayWithRange:NSMakeRange(1, 0)];
    XCTAssert(emptyArray1 == nil, @"subarray 实现错误");
}

#pragma mark - MutableArray

- (void)mArrayTest {
    NSMutableArray *mArray = @[@1].mutableCopy;
    
    [mArray objectAtIndex:1];
    [mArray addObject:nil];
    [mArray addObject:NULL];
    [mArray addObject:[NSNull new]];
    
    [mArray removeObject:nil];
    [mArray removeObject:[NSObject new]];
    
    [mArray replaceObjectAtIndex:1 withObject:nil];
    [mArray replaceObjectAtIndex:100 withObject:[NSObject new]];
}

- (void)mArrayTest2 {
    NSMutableArray *mArray = @[@1, @2].mutableCopy;
    
    [mArray objectAtIndex:1];
    [mArray addObject:nil];
    [mArray addObject:NULL];
    [mArray addObject:[NSNull new]];
    
    [mArray removeObject:nil];
    [mArray removeObject:[NSObject new]];
    
    [mArray replaceObjectAtIndex:1 withObject:nil];
    [mArray replaceObjectAtIndex:100 withObject:[NSObject new]];
}

- (void)mArrayTest3 {
    UIView *view = [UIView new];
    NSMutableArray *mArray = @[@1, view].mutableCopy;
    
    [mArray objectAtIndex:1];
    [mArray addObject:nil];
    [mArray addObject:NULL];
    [mArray addObject:[NSNull new]];
    
    [mArray removeObject:nil];
    [mArray removeObject:[NSObject new]];
    
    [mArray replaceObjectAtIndex:1 withObject:nil];
    [mArray replaceObjectAtIndex:100 withObject:[NSObject new]];
}

- (void)emptyMArrayTest {
    NSMutableArray *emptyMArray = @[].mutableCopy;
    
    [emptyMArray objectAtIndex:1];
    [emptyMArray addObject:nil];
    [emptyMArray addObject:NULL];
    [emptyMArray addObject:[NSNull new]];
    
    [emptyMArray removeObject:nil];
    [emptyMArray removeObject:[NSObject new]];
    
    [emptyMArray replaceObjectAtIndex:1 withObject:nil];
    [emptyMArray replaceObjectAtIndex:100 withObject:[NSObject new]];
}

#pragma mark - Dictionary

- (void)dictionaryTest {
    NSDictionary *dic = @{@"key":@"value"};
    [dic setValue:@"xx" forKey:@"key"];//设置key
    XCTAssert([dic isEqualToDictionary:@{@"xx":@"value"}], @"dic 实现错误");
    
    [dic setValue:@"xx" forKey:@"newkey"];
    XCTAssert([dic isEqualToDictionary:@{@"xx":@"value"}], @"dic 实现错误");

    [dic setValue:nil forKey:@"key"];
    XCTAssert([dic isEqualToDictionary:@{@"xx":@"value"}], @"dic 实现错误");
    
    id v = [dic valueForKey:nil];
    XCTAssert(v == nil, @"dic 实现错误");
    
    id vv = [dic objectForKey:@"xx"];
    XCTAssert([vv isEqualToString:@"value"], @"dic 实现错误");
    
    id vvv = [dic objectForKey:nil];
    XCTAssert(vvv == nil, @"dic 实现错误");
}

- (void)dictionaryTest2 {
    NSDictionary *dic = @{@"key":@"value", @"key2":@"value2"};

    id v = [dic valueForKey:nil];
    XCTAssert(v == nil, @"dic 实现错误");

    id vv = [dic objectForKey:@"xx"];
    XCTAssert(vv == nil, @"dic 实现错误");

    id vvv = [dic objectForKey:nil];
    XCTAssert(vvv == nil, @"dic 实现错误");
}

- (void)emptyDictionaryTest {
    NSDictionary *dic = @{};
    [dic setValue:@"xx" forKey:@"key"];//设置key
    XCTAssert([dic isEqualToDictionary:@{}], @"dic 实现错误");
    
    [dic setValue:@"xx" forKey:@"newkey"];
    XCTAssert([dic isEqualToDictionary:@{}], @"dic 实现错误");
    
    [dic setValue:nil forKey:@"key"];
    XCTAssert([dic isEqualToDictionary:@{}], @"dic 实现错误");
    
    id v = [dic valueForKey:nil];
    XCTAssert(v == nil, @"dic 实现错误");
    
    id vv = [dic objectForKey:@"xx"];
    XCTAssert(vv == nil, @"dic 实现错误");
    
    id vvv = [dic objectForKey:nil];
    XCTAssert(vvv == nil, @"dic 实现错误");
}

#pragma mark - Mutable Dictionary

- (void)mDictionaryTest {
    NSMutableDictionary *mDic = @{@"key":@"value"}.mutableCopy;

    [mDic setObject:nil forKey:@"key"];
    XCTAssert([mDic isEqualToDictionary:@{@"key":@"value"}], @"mDic 实现错误");
    
    [mDic setObject:@"value" forKey:nil];
    XCTAssert([mDic isEqualToDictionary:@{@"key":@"value"}], @"mDic 实现错误");
    
    [mDic setObject:nil forKey:nil];
    XCTAssert([mDic isEqualToDictionary:@{@"key":@"value"}], @"mDic 实现错误");

    [mDic setObject:nil forKey:@"newKey"];
    XCTAssert([mDic isEqualToDictionary:@{@"key":@"value"}], @"mDic 实现错误");
    
    [mDic setObject:@"newValue" forKey:@"newKey"];
    NSDictionary *d = @{@"key":@"value", @"newKey":@"newValue"};
    XCTAssert([mDic isEqualToDictionary:d], @"mDic 实现错误");

    [mDic setObject:[NSNull new] forKey:@"newKey"];
    NSDictionary *dd = @{@"key":@"value", @"newKey":[NSNull new]};
    XCTAssert([mDic isEqualToDictionary:dd], @"mDic 实现错误");
    
    id v = [mDic objectForKey:@"undefine"];
    XCTAssert(v == nil, @"mDic 实现错误");
    
    id vv = [mDic objectForKey:@"key"];
    XCTAssert([vv isEqualToString:@"value"], @"mDic 实现错误");
    
    [mDic removeObjectForKey:@"undefine"];
    [mDic valueForKey:@"undefine"];
}

- (void)mDictionaryTest2 {
    NSMutableDictionary *mDic = @{@"key":@"value", @"key2":@"value2"}.mutableCopy;
    NSDictionary *originD = @{@"key":@"value", @"key2":@"value2"};
    
    [mDic setObject:nil forKey:@"key"];
    XCTAssert([mDic isEqualToDictionary:originD], @"mDic 实现错误");
    
    [mDic setObject:@"value" forKey:nil];
    XCTAssert([mDic isEqualToDictionary:originD], @"mDic 实现错误");
    
    [mDic setObject:nil forKey:nil];
    XCTAssert([mDic isEqualToDictionary:originD], @"mDic 实现错误");
    
    [mDic setObject:nil forKey:@"newKey"];
    XCTAssert([mDic isEqualToDictionary:originD], @"mDic 实现错误");
    
    [mDic setObject:@"newValue" forKey:@"newKey"];
    NSDictionary *d = @{@"key":@"value", @"newKey":@"newValue", @"key2":@"value2"};
    XCTAssert([mDic isEqualToDictionary:d], @"mDic 实现错误");
    
    [mDic setObject:[NSNull new] forKey:@"newKey"];
    NSDictionary *dd = @{@"key":@"value", @"newKey":[NSNull new], @"key2":@"value2"};
    XCTAssert([mDic isEqualToDictionary:dd], @"mDic 实现错误");
    
    id v = [mDic objectForKey:@"undefine"];
    XCTAssert(v == nil, @"mDic 实现错误");
    
    id vv = [mDic objectForKey:@"key"];
    XCTAssert([vv isEqualToString:@"value"], @"mDic 实现错误");
    
    [mDic removeObjectForKey:@"undefine"];
    [mDic valueForKey:@"undefine"];
}

- (void)emptyMDictionaryTest {
    NSMutableDictionary *mDic = @{}.mutableCopy;
    
    [mDic setObject:nil forKey:@"key"];
    XCTAssert([mDic isEqualToDictionary:@{}], @"mDic 实现错误");
    
    [mDic setObject:@"value" forKey:nil];
    XCTAssert([mDic isEqualToDictionary:@{}], @"mDic 实现错误");
    
    [mDic setObject:nil forKey:nil];
    XCTAssert([mDic isEqualToDictionary:@{}], @"mDic 实现错误");
    
    [mDic setObject:nil forKey:@"newKey"];
    XCTAssert([mDic isEqualToDictionary:@{}], @"mDic 实现错误");
    
    [mDic setObject:@"newValue" forKey:@"newKey"];
    NSDictionary *d = @{@"newKey":@"newValue"};
    XCTAssert([mDic isEqualToDictionary:d], @"mDic 实现错误");
    
    [mDic setObject:[NSNull new] forKey:@"newKey"];
    NSDictionary *dd = @{@"newKey":[NSNull new]};
    XCTAssert([mDic isEqualToDictionary:dd], @"mDic 实现错误");
    
    id v = [mDic objectForKey:@"undefine"];
    XCTAssert(v == nil, @"mDic 实现错误");
    
    id vv = [mDic objectForKey:@"key"];
    XCTAssert(vv == nil, @"mDic 实现错误");
    
    [mDic removeObjectForKey:@"undefine"];
    [mDic valueForKey:@"undefine"];
}

@end
