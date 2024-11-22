import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:synchronized/synchronized.dart';

class WebCacheStore extends CacheStore {
  final Map<CachePriority, Map<String, CacheResponse>> _storage = {};
  final Map<String, Lock> _locks = {};

  WebCacheStore() {
    clean(staleOnly: true);
  }

  @override
  Future<void> clean({
    CachePriority priorityOrBelow = CachePriority.high,
    bool staleOnly = false,
  }) async {
    for (var priority in CachePriority.values) {
      if (priority.index > priorityOrBelow.index) continue;

      final priorityStorage = _storage[priority] ?? {};
      final keys = List<String>.from(priorityStorage.keys);

      for (final key in keys) {
        await _synchronized(key, () async {
          final response = priorityStorage[key];
          if (response != null && staleOnly && !response.isStaled()) return;
          priorityStorage.remove(key);
        });
      }
    }
  }

  @override
  Future<void> delete(String key, {bool staleOnly = false}) async {
    await _synchronized(key, () async {
      for (final priority in CachePriority.values) {
        final priorityStorage = _storage[priority];
        if (priorityStorage == null) continue;

        final response = priorityStorage[key];
        if (response != null && staleOnly && !response.isStaled()) return;

        priorityStorage.remove(key);
        break;
      }
    });
  }

  @override
  Future<void> deleteFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    final responses = await getFromPath(pathPattern, queryParams: queryParams);
    for (final response in responses) {
      await delete(response.key);
    }
  }

  @override
  Future<bool> exists(String key) async {
    return _synchronized(key, () async {
      for (final priorityStorage in _storage.values) {
        if (priorityStorage.containsKey(key)) return true;
      }
      return false;
    });
  }

  @override
  Future<CacheResponse?> get(String key) async {
    return _synchronized(key, () async {
      for (final priorityStorage in _storage.values) {
        if (priorityStorage.containsKey(key)) {
          return priorityStorage[key];
        }
      }
      return null;
    });
  }

  @override
  Future<List<CacheResponse>> getFromPath(
    RegExp pathPattern, {
    Map<String, String?>? queryParams,
  }) async {
    final results = <CacheResponse>[];

    for (final priorityStorage in _storage.values) {
      for (final response in priorityStorage.values) {
        if (pathExists(response.url, pathPattern, queryParams: queryParams)) {
          results.add(response);
        }
      }
    }

    return results;
  }

  @override
  Future<void> set(CacheResponse response) async {
    return _synchronized(response.key, () async {
      final priorityStorage = _storage.putIfAbsent(
        response.priority,
        () => {},
      );

      // Overwrite any existing entry for the key
      priorityStorage[response.key] = response;
    });
  }

  @override
  Future<void> close() {
    // No cleanup needed for in-memory storage
    return Future.value();
  }

  Future<T> _synchronized<T>(
    String key,
    FutureOr<T> Function() computation,
  ) async {
    final lock = _locks.putIfAbsent(key, () => Lock());
    return await lock.synchronized(computation);
  }
}
