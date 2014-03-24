# TreasureboxApp = angular.module("TreasureboxApp", ["ngResource"])

# TreasureboxApp.factory "Post", ["$resource", ($resource) ->
#   $resource("/posts/:id", {id: "@id"}, {update: {method: "PUT"}})
# ]

# @PostItemCtrl = ["$scope", "Post", ($scope, Post) ->
#   # Set the default value of selectedCategory
#   $scope.selectedCategory = "Categories"
#   # onCategoryClick function that takes in the arguement category
#   # Set it to the value of the selectedCategory
#   # And assign it to the newPost category attribute
#   $scope.onCategoryClick = (category)->
#     $scope.selectedCategory = category
#     $scope.newPost.category = $scope.selectedCategory

#   # Post = $resource("/post_items/:id", {id: "@id"}, {update: {method: "PUT"}})
#   $scope.posts = Post.query()

#   # $scope.posts = [
#   #   {name: "Samsung TV", category: "Electronics", description: "46inch", price: 115.00}
#   #   {name: "Burton Snowboard", category: "Sporting Goods", description: "Women's size 147, rarely used", price: 96.00}
#   # ]
#   $scope.addPost = ->
#     # post = Post.save($scope.newPost)
#     # $scope.posts.push(post)
#     $scope.posts.push($scope.newPost)
#     $scope.newPost = {}
#     $scope.selectedCategory = "Categories"
# ]