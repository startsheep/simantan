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
