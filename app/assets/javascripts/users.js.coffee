TreasureboxApp = angular.module("TreasureboxApp", [
  "TreasureboxRouter",
  "PostCtrls",
  "UserPostCtrls",
  "PostsService"
])

TreasureboxApp.config(["$httpProvider",
  ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])


PostsService = angular.module("PostsService", ["ngResource"])

PostsService.factory("Post", ["$resource",
  ($resource) ->
    $resource("/posts/:id.json", {id: "@id"}, {update: {method: "PUT"}})
])

########################################################################################################

TreasureboxRouter = angular.module("TreasureboxRouter", ["ngRoute"])

TreasureboxRouter.config(["$routeProvider", "$locationProvider",
  ($routeProvider, $locationProvider) ->
    $routeProvider.when("/"
      templateUrl: "/posts"
      controller: "PostsCtrl"
    ).when("/users/show/:id"
      templateUrl: "/posts/show"
      controller: "UserPostsCtrl"
    )

    $locationProvider.html5Mode(true);

])

PostCtrls = angular.module("PostCtrls", ["ui.bootstrap"])

PostCtrls.controller("PostsCtrl", ["$scope", "$http", "limitToFilter",
  ($scope, $http, limitToFilter) ->
    $http.get("/posts.json").
      success((data) ->
        console.log(data)
        $scope.posts = data
      )
    $scope.cities = (cityName) ->
      return $http.jsonp("http://gd.geobytes.com/AutoCompleteCity?callback=JSON_CALLBACK &filter=US&q="+cityName).
        success((response) ->
          return limitToFilter(response.data, 15)
        )



])

######################################################################################################### 

UserPostCtrls = angular.module("UserPostCtrls", [])

UserPostCtrls.controller("UserPostsCtrl", ["$scope", "$routeParams", "$http", "Post",
  ($scope, $routeParams, $http, Post) ->
    $scope.userId = $routeParams.id
    $http.get("/users/show/" + $scope.userId + ".json").
      success((data) ->
        $scope.user = data
        $scope.userPosts = data.posts
      )

    $scope.onCityClick = (city) ->
      $scope.selectedCity = city

    # Set the default value of selectedCategory
    $scope.selectedCategory = "Categories"
    # onCategoryClick function that takes in the arguement category
    # Set it to the value of the selectedCategory
    # And assign it to the newPost category attribute
    $scope.onCategoryClick = (category)->
      console.log $routeParams
      $scope.selectedCategory = category
      $scope.newPost.category = $scope.selectedCategory

    # $scope.posts = [
    #   {name: "Samsung TV", category: "Electronics", description: "46inch", price: 115.00}
    #   {name: "Burton Snowboard", category: "Sporting Goods", description: "Women's size 147, rarely used", price: 96.00}
    # ]

    $scope.addPost = () ->
      post = Post.save($scope.newPost)
      $scope.userPosts.push(post)
      # $scope.posts.push($scope.newPost)
      $scope.newPost = {}
      $scope.selectedCategory = "Categories"

    $scope.editPost = () ->
      console.log(@post)
      Post.update(@post)

    $scope.deletePost = () ->
      Post.delete(@post)
])

