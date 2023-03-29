class RoomFetch {
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
        pagination {
          currentPage
          total
          totalPages
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

  static String fetchCompleted = """
        query getCompletedTodos{
          todos(
            where: {is_public: {_eq: true}, is_completed: {_eq: true}},
            order_by: {created_at: desc}
          ) {
            __typename
            is_completed
            id
            title
          }
        }
      """;

  static String addTodo = """
        mutation addTodo(\$title: String!, \$isPublic: Boolean!){
          action: insert_todos(objects: {title: \$title, is_public: \$isPublic}){
            returning {
              id
              title
              is_completed
            }
          }
        }
      """;

  static String toggleTodo = """
      mutation toggleTodo(\$id: Int!, \$isCompleted: Boolean!){
        action: update_todos(where: {id: {_eq: \$id}}, _set: {is_completed: \$isCompleted}){
          returning{
            is_completed
          }
        }
      }
    """;

  static String deleteTodo = """
     mutation delete(\$id:Int!) {
       action: delete_todos(where: {id: {_eq: \$id}}) {
         returning {
           id
         }
       }
     }
   """;
}
