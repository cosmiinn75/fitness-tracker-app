    class PagedResponse<T> {
      List<T> content;
      int page;
      int size;
      int totalElements;
      int totalPages;
      bool first;
      bool last;

      PagedResponse(
          {required this.content, required this.page, required this.size, required this.first, required this.last, required this.totalElements, required this.totalPages});


      factory PagedResponse.fromJson(Map<String, dynamic> json , T Function(Map<String,dynamic>) fromJsonT){
        return PagedResponse(
            content: (json["content"] as List).map((json) => fromJsonT(json as Map<String,dynamic>)).toList(),
            page: json['page'],
            size: json['size'],
            first: json['first'],
            last: json['last'],
            totalElements: json['totalElements'],
            totalPages: json["totalPages"]
        );
      }
    }