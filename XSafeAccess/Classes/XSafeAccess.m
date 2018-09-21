//
//  XSafeAccessArray.m
//  Pods
//
//  Created by 金小白 on 16/8/16.
//
//  Copyright © 2016年 Xiaolei.Jin. All rights reserved.

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define XSafeAssert(condition, desc) NSAssert(condition, desc)

@implementation NSObject (XSafeAccessSwizzle)

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel originClass:(Class)originCls with:(SEL)newSel newClass:(Class)newCls {
    Method originalMethod = class_getInstanceMethod(originCls, originalSel);
    Method newMethod = class_getInstanceMethod(newCls, newSel);
    
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(originCls,originalSel,class_getMethodImplementation(originCls, originalSel),method_getTypeEncoding(originalMethod));
    class_addMethod(newCls,newSel,class_getMethodImplementation(newCls, newSel),method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(originCls, originalSel),
                                   class_getInstanceMethod(newCls, newSel));
    return YES;
}

@end

@implementation NSArray (XSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(subarrayWithRange:) originClass:NSClassFromString(@"NSArray") with:@selector(safeSubarrayWithRange:) newClass:self];
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArrayI") with:@selector(safeObjectAtIndexI:) newClass:self];
        [self swizzleInstanceMethod:@selector(objectAtIndexedSubscript:) originClass:NSClassFromString(@"__NSArrayI") with:@selector(safeObjectAtIndexedSubscript:) newClass:self];
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArray0") with:@selector(safeObjectAtIndex0:) newClass:self];
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSSingleObjectArrayI") with:@selector(safeSingleObjectAtIndexI:) newClass:self];
    });
}

- (id)safeObjectAtIndexI:(NSUInteger)index {
    if (index < self.count) {
        return [self safeObjectAtIndexI:index];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

- (id)safeObjectAtIndex0:(NSUInteger)index {
    if (index < self.count) {
        return [self safeObjectAtIndex0:index];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

- (id)safeSingleObjectAtIndexI:(NSUInteger)index {
    if (index < self.count) {
        return [self safeSingleObjectAtIndexI:index];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
        return [self safeObjectAtIndexedSubscript:idx];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range {
    if (range.location + range.length <= self.count) {
        return [self safeSubarrayWithRange:range];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

@end

@implementation NSMutableArray (XSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(objectAtIndex:) originClass:NSClassFromString(@"__NSArrayM") with:@selector(safeObjectAtIndexM:) newClass:self];
        [self swizzleInstanceMethod:@selector(insertObject:atIndex:) originClass:NSClassFromString(@"__NSArrayM") with:@selector(safeInsertObjectM:atIndex:) newClass:self];
        [self swizzleInstanceMethod:@selector(removeObjectAtIndex:) originClass:NSClassFromString(@"__NSArrayM") with:@selector(safeRemoveObjectAtIndexM:) newClass:self];
        [self swizzleInstanceMethod:@selector(replaceObjectAtIndex:withObject:) originClass:NSClassFromString(@"__NSArrayM") with:@selector(safeReplaceObjectAtIndexM:withObject:) newClass:self];
    });
}

- (id)safeObjectAtIndexM:(NSUInteger)index {
    if (index < self.count) {
        return [self safeObjectAtIndexM:index];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds!!! 数组越界！！！");
        return nil;
    }
}

- (void)safeInsertObjectM:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self safeInsertObjectM:anObject atIndex:index];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds or object is nil!!! 可变数组插入保护！！！");
    }
}

- (void)safeRemoveObjectAtIndexM:(NSUInteger)index {
    if (index < self.count) {
        [self safeRemoveObjectAtIndexM:index];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds or object is nil!!! 可变数组移除保护！！！");
    }
}

- (void)safeReplaceObjectAtIndexM:(NSUInteger)index withObject:(id)anObject {
    if (anObject && index < self.count) {
        [self safeReplaceObjectAtIndexM:index withObject:anObject];
    }else {
        XSafeAssert(NO, @"Index is beyond bounds or object is nil!!! 可变数组替换保护！！！");
    }
}

@end


@implementation NSDictionary (XSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(objectForKey:) originClass:NSClassFromString(@"__NSSingleEntryDictionaryI") with:@selector(safeObjectForKey:) newClass:self];
        [self swizzleInstanceMethod:@selector(setValue:forKey:) originClass:NSClassFromString(@"__NSSingleEntryDictionaryI") with:@selector(safeSingleEntryDictionaryISetValue:forKey:) newClass:self];
        [self swizzleInstanceMethod:@selector(setValue:forKey:) originClass:NSClassFromString(@"__NSDictionary0") with:@selector(safeDictionary0SetValue:forKey:) newClass:self];
    });
}

- (id)safeObjectForKey:(id)aKey {
    if (aKey) {
        return [self safeObjectForKey:aKey];
    }else {
        XSafeAssert(NO, @"Dictionary key is nil!!! 字典空 key 保护！！！");
        return nil;
    }
}

- (void)safeSingleEntryDictionaryISetValue:(id)value forKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        if (value) {
            [self safeSingleEntryDictionaryISetValue:value forKey:key];
        }else {
            XSafeAssert(NO, @"Dictionary value is nil!!! 字典空 value 保护！！！");
        }
    }else {
        XSafeAssert(NO, @"Dictionary key is undefine !!! 字典 key 未定义保护！！！");
    }
}

- (void)safeDictionary0SetValue:(id)value forKey:(NSString *)key {
    if ([self.allKeys containsObject:key]) {
        if (value) {
            [self safeDictionary0SetValue:value forKey:key];
        }else {
            XSafeAssert(NO, @"Dictionary value is nil!!! 字典空 value 保护！！！");
        }
    }else {
        XSafeAssert(NO, @"Dictionary key is undefine !!! 字典 key 未定义保护！！！");
    }
}

@end


@implementation NSMutableDictionary (XSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(setObject:forKey:) originClass:NSClassFromString(@"__NSDictionaryM") with:@selector(safeSetObject:forKey:) newClass:self];
    });
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self safeSetObject:anObject forKey:aKey];
    }else {
        XSafeAssert(NO, @"Dictionary key/value is nil !!! 字典空 key/value 保护！！！");
    }
}

@end
