class LazyLoadingFilter {
  int? page;
  int? limit;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LazyLoadingFilter &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode => page.hashCode ^ limit.hashCode;
  @override
  String toString() {
    return 'LazyLoadingFilter(page: $page, limit: $limit)';
  }
}
