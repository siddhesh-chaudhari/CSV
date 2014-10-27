define(['./module'], function(module){

    module.directive('imageSelect', function(){
        return {
            replace: true,
            restrict: 'E',
            scope: {
                image: '=image'
            },
            templateUrl: 'view/journal2/tpl/directives/image-select.html?ver=' + Journal2Config.version,
            controller: function($scope) {
                $scope.selectImage = function() {
                    $('#dialog').remove();

                    $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=' + Journal2Config.token + '&field=' + $scope.fieldId + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

                    $('#dialog').dialog({
                        title: 'image manager',
                        bgiframe: false,
                        width: 700,
                        height: 400,
                        resizable: false,
                        modal: false,
                        close: function() {
                            var val = $('#' + $scope.fieldId).val();
                            if(val) {
                                $scope.image = val;
                                $scope.$apply();
                            }
                        }
                    });
                };

                $scope.getImgUrl = function() {
                    return Journal2Config.img_folder + ($scope.image ? $scope.image : 'data/journal2/no_image.jpg');
                };

                $scope.clearImage = function() {
                    $scope.image = '';
                };
            },
            link: function(scope, elem) {
                scope.fieldId = _.uniqueId('img-upload-');
                elem.find('input[type="hidden"]').attr('id', scope.fieldId);
            }
        };
    });

});

