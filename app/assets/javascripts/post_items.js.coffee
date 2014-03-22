TreasureboxApp = angular.module("TreasureboxApp", [])

@PostItemCtrl = ($scope) ->
  # To select a category for a post item
  $scope.selectedCategory = "Categories"
  $scope.onCategoryClick = (event)->
    $scope.selectedCategory = event
    $scope.newPost.category = $scope.selectedCategory

  # Post = $resource("/post_items/:id", {id: "@id"}, {update: {method: "PUT"}})
  # $scope.posts = Post.query()

  $scope.posts = [
    {name: "Samsung TV", category: "Electronics", description: "46inch", price: 115.00}
    {name: "Burton Snowboard", category: "Sporting Goods", description: "Women's size 147, rarely used", price: 96.00}
  ]
  $scope.addPost = ->
    # post = Post.save($scope.newPost)
    $scope.posts.push($scope.newPost)
    $scope.newPost = {}