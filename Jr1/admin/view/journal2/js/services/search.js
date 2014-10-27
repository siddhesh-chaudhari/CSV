define(['./module'], function (module) {

    module
        .factory('Search', [function () {
            return {
                generateOptions: function (url, id, placeholder) {
                    return {
                        initSelection: function (element) { },
                        minimumInputLength: 1,
                        ajax: {
                            cache: true,
                            url: url,
                            dataType: 'json',
                            data: function (term, page) {
                                return {
                                    token: Journal2Config.token,
                                    filter_name: term
                                };
                            },
                            results: function (data, page) {
                                return {
                                    results: _.map(data.response, function (item) {
                                        return {
                                            id: item[id],
                                            name: item.name
                                        };
                                    })
                                };
                            }
                        },
                        formatResult: function (item) {
                            return item.name;
                        },
                        formatSelection: function (item) {
                            return item.name;
                        },
                        placeholder: placeholder
                    };
                }
            };
        }]);

});


