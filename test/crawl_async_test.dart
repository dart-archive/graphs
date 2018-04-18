// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:graphs/graphs.dart';

import 'utils/graph.dart';

void main() {
  group('asyncCrawl', () {
    Future<List<String>> crawl(
        Map<String, List<String>> g, Iterable<String> roots) {
      var graph = new AsyncGraph(g);
      return crawlAsync(roots, graph.readNode, graph.children).toList();
    }

    test('empty result for empty graph', () async {
      var result = await crawl({}, []);
      expect(result, isEmpty);
    });

    test('single item for a single node', () async {
      var result = await crawl({'a': []}, ['a']);
      expect(result, ['a']);
    });

    test('hits every node in a graph', () async {
      var result = await crawl({
        'a': ['b', 'c'],
        'b': ['c'],
        'c': ['d'],
        'd': [],
      }, [
        'a'
      ]);
      expect(result, hasLength(4));
      expect(result,
          allOf(contains('a'), contains('b'), contains('c'), contains('d')));
    });

    test('handles cycles', () async {
      var result = await crawl({
        'a': ['b'],
        'b': ['c'],
        'c': ['b'],
      }, [
        'a'
      ]);
      expect(result, hasLength(3));
      expect(result, allOf(contains('a'), contains('b'), contains('c')));
    });

    test('handles self cycles', () async {
      var result = await crawl({
        'a': ['b'],
        'b': ['b'],
      }, [
        'a'
      ]);
      expect(result, hasLength(2));
      expect(result, allOf(contains('a'), contains('b')));
    });

    test('allows null children', () async {
      var result = await crawl({
        'a': ['b'],
        'b': null,
      }, [
        'a'
      ]);
      expect(result, hasLength(2));
      expect(result, allOf(contains('a'), contains('b')));
    });

    test('ignores null nodes', () async {
      var result = await crawl({
        'a': ['b'],
      }, [
        'a'
      ]);
      expect(result, ['a']);
    });
  });
}
