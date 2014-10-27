<?php

class Journal2Page {

    private $layout_id = null;
    private $id = null;
    private $type = null;
    private $modules = array(
        'content_top'   => array(),
        'column_left'   => array(),
        'column_right'  => array(),
        'content_bottom'=> array(),
        'top'           => array(),
        'bottom'        => array()
    );

    public function __construct($registry, $html_classes) {
        $registry->get('load')->model('design/layout');
        $registry->get('load')->model('catalog/category');
        $registry->get('load')->model('catalog/product');
        $registry->get('load')->model('catalog/information');
        $registry->get('load')->model('setting/extension');
        $registry->get('load')->model('journal2/module');

        $get = $registry->get('request')->get;

        if (isset($get['route'])) {
            $route = (string)$get['route'];
        } else {
            $route = 'common/home';
        }

        if ($route == 'product/category' && isset($get['path'])) {
            $this->type = 'category';
            $this->id = $get['path'];
            $path = explode('_', (string)$get['path']);
            $this->layout_id = $registry->get('model_catalog_category')->getCategoryLayoutId(end($path));
        }

        if ($route == 'product/product' && isset($get['product_id'])) {
            $this->type = 'product';
            $this->id = $get['product_id'];
            $this->layout_id = $registry->get('model_catalog_product')->getProductLayoutId($this->id);
        }

        if ($route == 'information/information' && isset($get['information_id'])) {
            $this->type = 'information';
            $this->id = $get['information_id'];
            $this->layout_id = $registry->get('model_catalog_information')->getInformationLayoutId($this->id);
        }

        if ($route == 'journal2/quickview' && isset($get['product_id'])) {
            $this->type = 'quickview';
            $this->id = $get['product_id'];
        }

        if (strpos($route, 'affiliate') === 0) {
            $this->type = 'affiliate';
        }

        if (strpos($route, 'account') === 0) {
            $this->type = 'account';
        }

        if (strpos($route, 'checkout') === 0) {
            $this->type = 'checkout';
        }

        if ($this->type) {
            $html_classes->addClass($this->type . '-page');
            if ($this->id) {
                $html_classes->addClass($this->type . '-page-' . $this->id);
            }
        }

        if (!isset($get['route']) || $get['route'] === 'common/home') {
            $html_classes->addClass('home-page');
        }

        if (!$this->layout_id) {
            $this->layout_id = $registry->get('model_design_layout')->getLayout($route);
        }

        if (!$this->layout_id) {
            $this->layout_id = $registry->get('config')->get('config_layout_id');
        }

        $html_classes->addClass('layout-' . $this->layout_id);

        $extensions = $registry->get('model_setting_extension')->getExtensions('module');

        foreach ($extensions as $extension) {
            $modules = $registry->get('config')->get($extension['code'] . '_module');

            if ($modules) {
                foreach ($modules as $module) {
                    if ($module['layout_id'] == $this->layout_id && $module['status']) {
                        if (isset($module['module_id']) && strpos($extension['code'], 'journal2_') === 0 && !$registry->get('model_journal2_module')->getModule($module['module_id'])) {
                            continue;
                        }
                        $this->modules[$module['position']][] = array(
                            'code'       => $extension['code'],
                            'setting'    => $module,
                            'sort_order' => $module['sort_order']
                        );
                    }
                }
            }
        }
    }

    public function getType() {
        return $this->type;
    }

    public function getId() {
        return $this->id;
    }

    public function hasModules($position) {
        return count($this->modules[$position]) > 0;
    }

}