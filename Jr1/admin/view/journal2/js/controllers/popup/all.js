define(['./../module', 'underscore'], function (module, _) {

    module.controller('PopupAllController', function ($scope, $timeout, $location, $routeParams, Rest, Spinner, localStorageService) {

        $scope.paginationTotalItems = 0;
        $scope.paginationCurrentPage = 1;

        $scope.filterModules = function (modules, page) {
            return modules.slice((page - 1) * 10, page * 10);
        };

        /* opened modules */
        $scope.module_id = $routeParams.module_id || null;
        $scope.opened_modules = {};
        $timeout(function () {
            $scope.close_others = localStorageService.get($scope.module_type + '_close_others') === 'true';
        }, 1);

        /* scope vars */
        $scope.module_type = 'popup';
        $scope.modules = [];
        $scope.layouts = _.clone(Journal2Config.layouts);
        $scope.layouts.unshift({
            layout_id: -1,
            name: 'All Pages'
        });

        /* get data */
        Rest.all({
            modules         : Rest.getModules($scope.module_type),
            activeModules   : Rest.getModulePlacement($scope.module_type)
        }, function (response) {
            $scope.paginationTotalItems = response.modules.length;
            var activeModules = [];
            _.each(response.activeModules, function (module) {
                activeModules[module.module_id] = activeModules[module.module_id] || [];
                activeModules[module.module_id].push(module);
            });
            /* modules */
            $scope.modules = _.map(response.modules, function (module) {
                module.module_placements = activeModules[module.module_id] || [];
                if ($scope.module_id === module.module_id && module.module_placements.length === 0) {
                    $scope.addModule(module);
                }
                return module;
            });
            $scope.opened_modules = localStorageService.get($scope.module_type + '_opened_modules') || {};
            if ($scope.module_id) {
                $scope.opened_modules[$scope.module_id] = true;
            }
            Spinner.hide();
        }, function (error) {
            alert(error);
            Spinner.hide();
        });

        /* add module */
        $scope.addModule = function (module, $event) {
            module.module_placements.push({
                module_id: module.module_id,
                layout_id: '',
                position: 'header',
                status: 1,
                sort_order: ''
            });
            $scope.opened_modules[module.module_id] = true;
        };

        /* remove module */
        $scope.removeModule = function ($index, module) {
            module.module_placements.splice($index, 1);
        };

        /* save */
        $scope.saveModules = function ($event) {
            var $src = $($event.srcElement);
            if ($('form').hasClass('ng-invalid')) {
                alert('Please choose a layout and/or position');
                return;
            }
            Spinner.show($src);
            var activeModules = [];
            _.each($scope.modules, function (module) {
                activeModules = _.union(activeModules, module.module_placements);
            });
            Rest.saveModulePlacement($scope.module_type, activeModules).then(function (response) {
                localStorageService.set($scope.module_type + '_opened_modules', $scope.opened_modules);
                localStorageService.set($scope.module_type + '_close_others', $scope.close_others);
                Spinner.hide($src);
            }, function (error) {
                Spinner.hide($src);
                alert(error);
            });
        };

        /* toggle accordion */
        $scope.toggleAccordion = function (value) {
            _.each($scope.modules, function (module) {
                $scope.opened_modules[module.module_id] = value;
            });
            if (value) {
                $scope.close_others = false;
            }
        };

    });

});