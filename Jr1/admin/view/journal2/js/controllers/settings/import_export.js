define(['./../module', 'underscore'], function (module, _) {

    module.controller('ImportExportSettingsController', function ($scope, $routeParams, $location, $timeout, localStorageService, Rest, Spinner) {

        $scope.settings = {
            include_store_data: 0,
            add_dummy_images: 0,
            purchased_code: localStorageService.get('j2_purchased_code'),
            tf_user: localStorageService.get('j2_tf_user')
        };

        $scope.saveCookie = function (key) {
            localStorageService.set('j2_' + key, $scope.settings[key]);
        };

        Spinner.hide();

        $scope.confirmation = function ($event) {
            if ($scope.settings.include_store_data && !confirm('WARNING! This will include store data from this installation. Importing this file into your store will reset your data to the one in this file. ')) {
                $event.preventDefault();
                return false;
            }
        };

        $scope.confirmation2 = function ($event) {
            var $src = $($event.srcElement);
            Spinner.show($src);
            if ($scope.settings.include_store_data && !confirm('WARNING! This will include store data from this installation. Importing this file into your store will reset your data to the one in this file. ')) {
                $event.preventDefault();
                return false;
            }

            var data = {
                purchased_code: $scope.settings.purchased_code,
                tf_user: $scope.settings.tf_user
            };

            Rest.verifyCode(data).then(function (response) {
                window.location = $('#export-btn').attr('href');
                Spinner.hide($src);
            }, function (error) {
                alert(error);
                Spinner.hide($src);
            });

            $event.preventDefault();
            return false;
        };

    });

});
