TreasureboxApp = angular.module("TreasureboxApp", [
  "TreasureboxRouter",
  "PostCtrls",
  "UserPostCtrls",
  "PostsService",
  "ui.bootstrap",
  "flow"
]).config(["flowFactoryProvider",
  (flowFactoryProvider) ->
    flowFactoryProvider.defaults = {
      target: "/posts",
      permanentErrors: [404, 500, 501]
    }
    flowFactoryProvider.on("catchAll", 
      (event) ->
        console.log("catchAll")
    )

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

TreasureboxRouter.config(["$routeProvider", "$locationProvider"
  ($routeProvider, $locationProvider) ->
    $routeProvider.when("/"
      templateUrl: "/posts"
      controller: "PostsCtrl"
    ).when("/users/show/:id"
      templateUrl: "/posts/show"
      controller: "UserPostsCtrl"
    ).when("/users/new",
      templateUrl: "/users/new_form"
    ).when("/users/sign_up"
      templateUrl: "/users/sign_up_form"
    )

    $locationProvider.html5Mode(true);

])

PostCtrls = angular.module("PostCtrls", [])

# TypeaheadCtrl = ($scope, $http, limitToFilter) ->
  
#   #http://www.geobytes.com/free-ajax-cities-jsonp-api.htm
#   $scope.cities = (cityName) ->
#     $http.jsonp("http://gd.geobytes.com/AutoCompleteCity?callback=JSON_CALLBACK &filter=US&q=" + cityName).then (response) ->
#       limitToFilter response.data, 15

# PostCtrls.controller 'TypeaheadCtrl', TypeaheadCtrl

PostCtrls.controller("PostsCtrl", ["$scope", "$http", "limitToFilter", "$routeParams"
  ($scope, $http, limitToFilter, $routeParams) ->
    $scope.params = $routeParams
    $http.get("/posts.json").
      success((data) ->
        console.log(data)
        $scope.posts = data
    )

    $scope.cities = (cityName) ->
      $http.jsonp("http://gd.geobytes.com/AutoCompleteCity?callback=JSON_CALLBACK &filter=US&q="+cityName).then (response) ->
          limitToFilter response.data, 15
    
    $scope.onCityClick = (city) ->
      # $scope.posts =  

])

######################################################################################################### 

UserPostCtrls = angular.module("UserPostCtrls", [])

UserPostCtrls.controller("UserPostsCtrl", ["$scope", "$routeParams", "$http", "Post", "limitToFilter"
  ($scope, $routeParams, $http, Post, limitToFilter) ->
    $scope.params = $routeParams
    console.log "Loaded UserPostCtrl"
    $scope.userId = $routeParams.id
    $http.get("/users/show/" + $scope.userId + ".json").
      success((data) ->
        $scope.user = data
        $scope.userPosts = data.posts
      )


    $scope.cities = (cityName) ->
      $http.jsonp("http://gd.geobytes.com/AutoCompleteCity?callback=JSON_CALLBACK &filter=US&q="+cityName).then (response) ->
          limitToFilter response.data, 15

    $scope.onCityClick = (city) ->
      $scope.selectedCity = city

    # Set the default value of selectedCategory
    $scope.selectedCategory = "Categories"
    # onCategoryClick function that takes in the arguement category
    # Set it to the value of the selectedCategory
    # And assign it to the newPost category attribute
    $scope.onCategoryClick = (category)->
      # console.log $routeParams
      $scope.selectedCategory = category
      $scope.newPost.category = $scope.selectedCategory

    $scope.addPost = (event) ->
      event.preventDefault();
      console.log($scope.newPost)

      imageName = $(event.target).find("[type=file]")[0].files[0].name
      url = $(event.target).find("[name=key]")[0].value
      imageUrl = url.replace("${filename}", imageName)
      $scope.newPost.image = "https://treasurebox-photos.s3.amazonaws.com/" + imageUrl
      console.log($scope.newPost.image)

      post = Post.save($scope.newPost, (data)->
        $("#photoForm")[0].submit();

      )
      $scope.userPosts.push(post)
      console.log(post)
      # $scope.posts.push($scope.newPost)
      $scope.newPost = {}
      $scope.selectedCategory = "Categories"

    $scope.editPost = () ->
      # console.log(@post, @$index)
      Post.update(@post)

    $scope.deletePost = () ->
      Post.delete(@post, ()->
        $scope.userPosts.splice(@index,1)
      )

])

