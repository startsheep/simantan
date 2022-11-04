// make data posts
List<Map<String, dynamic>> posts = [
  // get image from picsum.com
  //make sample data like this
  {
    'id': 1,
    // 'title':'Post 1',
    'body': 'This is post 1',
    'posts_content': [
      'https://placeimages.com/640/480/tech',
    ],
    'user': {
      'id': 1,
      'name': 'User 1',
      'avatar': 'https://placeimages.com/640/480/people',
    },
    'comments': [
      {
        'id': 1,
        'user': {
          'id': 1,
          'name': 'User 1',
          'avatar': 'https://placeimages.com/640/480/people',
        },
        'body': 'This is comment 1',
      },
      {
        'id': 2,
        'user': {
          'id': 2,
          'name': 'User 2',
          'avatar': 'https://placeimages.com/640/480/people',
        },
        'body': 'This is comment 2',
      },
    ],
    'likes': [
      {
        'id': 1,
        'user': {
          'id': 1,
          'name': 'User 1',
          'avatar': 'https://placeimages.com/640/480/people',
        },
      },
      {
        'id': 2,
        'user': {
          'id': 2,
          'name': 'User 2',
          'avatar': 'https://placeimages.com/640/480/people',
        },
      },
    ],
    'created_at': '2020-01-01 00:00:00',
    'updated_at': '2020-01-01 00:00:00',
  },
  {
    'id': 2,
    // 'title':'Post 2',
    'body': 'This is post 2',
    'posts_content': [
      'https://placeimages.com/640/480/tech',
    ],
    'user': {
      'id': 2,
      'name': 'User 2',
      'avatar': 'https://placeimages.com/640/480/people',
    },
    'comments': [
      {
        'id': 1,
        'user': {
          'id': 1,
          'name': 'User 1',
          'avatar': 'https://placeimages.com/640/480/people',
        },
        'body': 'This is comment 1',
      },
      {
        'id': 2,
        'user': {
          'id': 2,
          'name': 'User 2',
          'avatar': 'https://placeimages.com/640/480/people',
        },
        'body': 'This is comment 2',
      },
    ],
    'likes': [
      {
        'id': 1,
        'user': {
          'id': 1,
          'name': 'User 1',
          'avatar': 'https://placeimages.com/640/480/people',
        },
      },
      {
        'id': 2,
        'user': {
          'id': 2,
          'name': 'User 2',
          'avatar': 'https://placeimages.com/640/480/people',
        },
      },
    ],
    'created_at': '2020-01-01 00:00:00',
    'updated_at': '2020-01-01 00:00:00',
  },
];
List<Map<String, dynamic>> comments = [
  {
    'id': 1,
    'post_id': 1,
    'user': {
      'id': 1,
      'name': 'User 1',
      'avatar': 'https://placeimages.com/640/480/people',
    },
    'body': 'This is comment 1',
  },
  {
    'id': 2,
    'post_id': 1,
    'user': {
      'id': 2,
      'name': 'User 2',
      'avatar': 'https://placeimages.com/640/480/people',
    },
    'body': 'This is comment 2',
  },
];

List<Map<String, dynamic>> users = [
  {
    'id': 1,
    'name': 'User 1',
    'avatar': 'https://placeimages.com/640/480/people',
  },
  {
    'id': 2,
    'name': 'User 2',
    'avatar': 'https://placeimages.com/640/480/people',
  },
];

List<Map<String, dynamic>> likes = [
  {
    'id': 1,
    'post_id': 1,
    'user': {
      'id': 1,
      'name': 'User 1',
      'avatar': 'https://placeimages.com/640/480/people',
    },
  },
  {
    'id': 2,
    'post_id': 1,
    'user': {
      'id': 2,
      'name': 'User 2',
      'avatar': 'https://placeimages.com/640/480/people',
    },
  },
];

// flow likes
// 1. user 1 like post 1

// 2. user 2 like post 1
// 3. user 1 unlike post 1
// 4. user 2 unlike post 1

//crete method dateFromNow
String dateFromNow(String date) {
  DateTime now = DateTime.now();
  DateTime postDate = DateTime.parse(date);
  Duration diff = now.difference(postDate);
  if (diff.inDays > 0) {
    return '${diff.inDays} hari yang lalu';
  } else if (diff.inHours > 0) {
    return '${diff.inHours} jam yang lalu';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes} menit yang lalu';
  } else {
    return 'Sekarang';
  }
}
