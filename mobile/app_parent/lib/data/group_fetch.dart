class GroupFetch {
  static String getListGroup = """
    query MyQuery(\$page:Int, \$limit: Int) {
      group(limit: \$limit, page: \$page) {
        group {
          createdAt
          id
          name
          createdBy
          code
          users {
            displayName
            email
            id
            joinAt
            photoURL
            phoneNumber
            role
          }
        }
      }
    }
  """;

  static String getDetailGroup = """
    query{
      groupByPK(id: "idRoom") {
        code
        createdAt
        createdBy
        id
        name
        users {
          displayName
          email
          id
          joinAt
          phoneNumber
          photoURL
          role
        }
      }
    }
  """;
}
