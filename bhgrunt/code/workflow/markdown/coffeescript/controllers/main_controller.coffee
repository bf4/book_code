# The controller
@MarkdownEditor.controller "MainCtrl", ['$scope','$sce', 'MarkdownConverter',
($scope, $sce, MarkdownConverter) ->
  $scope.updatePreview = ->
    converted = MarkdownConverter.convert($scope.input)
    $scope.output = $sce.trustAsHtml(converted)
]
