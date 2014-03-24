TreasureboxApp = angular.module("TreasureboxApp", [
  "TreasureboxRouter"
  "PostCtrls"
])

TreasureboxApp.config(["$httpProvider",
  ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

########################################################################################################

TreasureboxRouter = angular.module("TreasureboxRouter", ["ngRoute"])

TreasureboxRouter.config(["$routeProvider",
  ($routeProvider) ->
    $routeProvider.when("/"
      templateUrl: "/posts"
      controller: "PostsCtrl"
    )
])

PostCtrls = angular.module("PostCtrls", [])

PostCtrls.controller("PostsCtrl", ["$scope", "$http",
  ($scope, $http) ->
    $http.get("/posts.json").
      success((data) ->
        console.log(data)
        $scope.posts = data
      )
    
])

######################################################################################################### 

UserPostCtrls = angular.module("UserPostCtrls", [])

UserPostCtrls.controller("UserPostsCtrl", ["$scope", "$resource",
  ($scope, $resource) ->
    $scope.onCityClick = (city) ->
      $scope.selectedCity = city

    # Set the default value of selectedCategory
    $scope.selectedCategory = "Categories"
    # onCategoryClick function that takes in the arguement category
    # Set it to the value of the selectedCategory
    # And assign it to the newPost category attribute
    $scope.onCategoryClick = (category)->
      $scope.selectedCategory = category
      $scope.newPost.category = $scope.selectedCategory

    $scope.posts = [
      {name: "Samsung TV", category: "Electronics", description: "46inch", price: 115.00}
      {name: "Burton Snowboard", category: "Sporting Goods", description: "Women's size 147, rarely used", price: 96.00}
    ]

    $scope.addPost = ->
      # post = Post.save($scope.newPost)
      # $scope.posts.push(post)
      $scope.posts.push($scope.newPost)
      $scope.newPost = {}
      $scope.selectedCategory = "Categories"
])

