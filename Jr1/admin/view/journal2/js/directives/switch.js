define(['./module'], function(module){

    module.directive('switch', function() {
        return {
            require: '?ngModel',
            restrict: 'E',
            replace: true,
            transclude: true,
            templateUrl: 'view/journal2/tpl/directives/switch.html?ver=' + Journal2Config.version,
            link: function(scope, element, attrs, ctrl) {
                var $element = $(element);
                var $input = $element.find('input');
                var name = _.uniqueId('switch-group-');

                $input.attr('name', name);
                $element.addClass('switch-' + $input.length);

                ctrl.$render = function() {
                    if (ctrl.$viewValue === undefined) {
                        ctrl.$setViewValue($element.find('input').first().attr('data-key'));
                    }
                    $element.attr('value', ctrl.$viewValue);
                    $element.find('input[data-key="' + ctrl.$viewValue + '"]').attr('checked', 'checked');
                };

                scope.$on('change', function(e, value) {
                    ctrl.$setViewValue($element.attr('value'));
                });
            }
        };
    })
        .directive('switchOption', function($compile) {
            return {
                restrict: 'E',
                link: function (scope, element) {
                    var $element = $(element);
                    var $parent = $element.parent();
                    var key = $element.attr('key');
                    var value = $element.html();
                    var id = _.uniqueId('switch-option-');

                    var $newElement = $compile('<input id="' + id + '" type="radio" data-key="' + key + '" /><label for="' + id + '" data-ng-click="setValue(\'' + key + '\')" onclick="">' + value + '</label>')(scope);

                    $element.remove();

                    $parent.append($newElement);

                    $parent.find('a').remove();
                    $parent.append($('<a/>'));

                    scope.setValue = function(value) {
                        $parent.attr('value', value);
                        scope.$parent.$broadcast('change', value);
                        $parent.addClass('t-candy');
                    };
                }
            };
        });

});