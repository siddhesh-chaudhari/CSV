<div class="sticky">
<div class="module-header">
    <div class='module-name'>Settings<span>Category Page</span></div>

    <skin-manager data-url="settings/general"></skin-manager>

    <div class="module-buttons">
        <?php if (defined('J2ENV')): ?>
        <a class="btn blue" data-ng-show="skin_id < 100" data-ng-click="saveDefault($event)">Export</a>
        <?php endif; ?>
        <!--<a class="btn blue" data-ng-click="multiStore($event)">MultiStore</a>-->
        <a class="btn blue" data-ng-click="saveAs($event)">Save As</a>
        <a class="btn green" data-ng-click="save($event)">Save</a>
        <a class="btn red" data-ng-show="skin_id < 100" data-ng-click="reset($event)">Reset</a>
        <a class="btn red" data-ng-show="skin_id >= 100" data-ng-click="delete($event)">Delete</a>
    </div>
</div>
</div>
<div class="module-body category">
    <div class="accordion-bar bar-level-0 bar-expand" >
        <a data-ng-click="toggleAccordion(true)" class="hint--top" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(false)" class="hint--top" data-hint="Collapse All"><i class="collapse-icon"></i></a>
        <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="accordion.close_others" /></label>
    </div>
    <accordion id="main-accordion" close-others="accordion.close_others">
        <accordion-group is-open="accordion.accordions[0]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">General</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Default View</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.product_view">
                            <switch-option key="grid">Grid</switch-option>
                            <switch-option key="list">List</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Show Category Image</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.hide_category_image">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-show="settings.hide_category_image == '1'">
                    <span class="module-create-title">Image Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.main_category_image_border"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Description Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.category_description_font"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Description Line Height</span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.category_description_line_height" class="journal-number-field"></j-opt-text>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Products per Row</span>
                    <span class="module-create-option">
                        <j-opt-items-per-row data-range="1,10" data-step="1" data-ng-model="settings.category_page_products_per_row"></j-opt-items-per-row>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

            </ul>
        </accordion-group>
        <accordion-group is-open="accordion.accordions[1]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Subcategories</div>
            </accordion-heading>
            <ul class="module-create-options">

                <li>
                    <span class="module-create-title">Display</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.refine_category">
                            <switch-option key="text">Text</switch-option>
                            <switch-option key="grid">Grid</switch-option>
                            <switch-option key="carousel">Carousel</switch-option>
                            <switch-option key="none">None</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-hide="settings.refine_category == 'none'">
                    <span class="module-create-title">Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.refine_image_font"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-hide="settings.refine_category == 'none'">
                    <span class="module-create-title">Font Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.refine_image_font_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.refine_category == 'text'">
                    <span class="module-create-title">Link Divider</span>
                        <span class="module-create-option">
                            <j-opt-text data-ng-model="settings.refine_link_divider" class="journal-number-field"></j-opt-text>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.refine_category == 'text'">
                    <span class="module-create-title">Link Divider Color</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.refine_link_divider_color"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.refine_category == 'text'">
                    <span class="module-create-title">Background Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.refine_bar_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.refine_category == 'text'">
                    <span class="module-create-title">Border Radius</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.refine_bar_radius" data-editor="hide-style"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.refine_category == 'grid' || settings.refine_category == 'carousel'">
                    <span class="module-create-title">Item Background Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.refine_image_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.refine_category == 'grid' || settings.refine_category == 'carousel'">
                    <span class="module-create-title">Background Color Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.refine_image_bg_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.refine_category == 'grid' || settings.refine_category == 'carousel'">
                    <span class="module-create-title">Item Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.refine_image_border_radius"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>


                <li data-ng-show="settings.refine_category == 'grid' || settings.refine_category == 'carousel'">
                    <span class="module-create-title">Image Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.refine_image_border"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>


                <li data-ng-show="settings.refine_category == 'grid' || settings.refine_category == 'carousel'">
                    <span class="module-create-title">Item Padding</span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.refine_image_padding" class="journal-number-field"></j-opt-text>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>


                <li data-ng-show="settings.refine_category == 'grid' || settings.refine_category == 'carousel'">
                    <span class="module-create-title">Items per Row</span>
                    <span class="module-create-option">
                        <j-opt-items-per-row data-range="1,10" data-step="1" data-ng-model="settings.refine_category_images_per_row"></j-opt-items-per-row>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
            </ul>
        </accordion-group>
        <accordion-group is-open="accordion.accordions[2]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Grid / List Bar</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Grid Icon</span>
                    <span class="module-create-option">
                        <j-opt-icon data-ng-model="settings.category_grid_view_icon"></j-opt-icon>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">List Icon</span>
                    <span class="module-create-option">
                        <j-opt-icon data-ng-model="settings.category_list_view_icon"></j-opt-icon>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Icon Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.category_view_icon_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Background Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.product_filter_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Bar Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.product_filter_radius"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.product_filter_font"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Product Compare Link</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.product_compare_link_status">
                            <switch-option key="on">ON</switch-option>
                            <switch-option key="off">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Compare Link Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.product_compare_hover_color"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
            </ul>
        </accordion-group>
        <!--Pagination-->
        <accordion-group is-open="accordion.accordions[3]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Pagination</div>
            </accordion-heading>
            <ul class="module-create-options">

                <li>
                    <span class="module-create-title">Link Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.pagination_link_font_new"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Link Background</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.pagination_link_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Hover / Active Font Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.pagination_link_hover_color"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Hover / Active Background</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.pagination_link_hover_bg_color"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Link Radius</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.pagination_radius" editor="hide-style"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Results Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.pagination_text_font"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Bar Background</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.pagination_bar_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Bar Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.pagination_bar_border"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Soft Shadow</span>
                        <span class="module-create-option">
                            <switch data-ng-model="settings.pagination_soft_shadow">
                                <switch-option key="1px 1px 0px rgba(0,0,0,.04)">ON</switch-option>
                                <switch-option key="none">OFF</switch-option>
                            </switch>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
            </ul>
        </accordion-group>
        <!--&lt;!&ndash;Infinite Scroll&ndash;&gt;-->
        <!--<accordion-group is-open="false">-->
            <!--<accordion-heading>-->
                <!--<div class="accordion-bar bar-level-0">Infinite Scroll</div>-->
            <!--</accordion-heading>-->
                <!--<ul class="module-create-options">-->

                    <!--<li>-->
                    <!--<span class="module-create-title">Status</span>-->
                    <!--<span class="module-create-option">-->
                        <!--<switch data-ng-model="settings.product_infinite_scroll">-->
                            <!--<switch-option key="1">ON</switch-option>-->
                            <!--<switch-option key="0">OFF</switch-option>-->
                        <!--</switch>-->
                    <!--</span>-->
                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                <!--</li>-->
                <!--<li data-ng-show="settings.product_infinite_scroll == '1'">-->
                    <!--<span class="module-create-title">Auto Scroll</span>-->
                    <!--<span class="module-create-option">-->
                        <!--<switch data-ng-model="settings.product_infinite_scroll_auto_trigger">-->
                            <!--<switch-option key="1">ON</switch-option>-->
                            <!--<switch-option key="0">OFF</switch-option>-->
                        <!--</switch>-->
                    <!--</span>-->
                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                <!--</li>-->



                <!--<li data-ng-show="settings.product_infinite_scroll == '1'">-->
                    <!--<span class="module-create-title">Loading Image</span>-->
                    <!--<span class="module-create-option">-->
                        <!--<j-opt-image data-ng-model="settings.infinite_scroll_loader"></j-opt-image>-->
                    <!--</span>-->
                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                <!--</li>-->

                <!--<li data-ng-show="settings.product_infinite_scroll == '1'">-->
                    <!--<span class="module-create-title">Loading Image Radius</span>-->
                    <!--<span class="module-create-option">-->
                        <!--<j-opt-border data-ng-model="settings.infinite_scroll_loader_radius" data-editor="hide-style"></j-opt-border>-->
                    <!--</span>-->
                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                <!--</li>-->

                <!--<li data-ng-show="settings.product_infinite_scroll == '1'">-->
                    <!--<span class="module-create-title">Scroll End Text</span>-->
                        <!--<span class="module-create-option">-->
                            <!--<j-opt-text-lang data-ng-model="settings.product_infinite_scroll_finished_text"></j-opt-text-lang>-->
                        <!--</span>-->
                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                <!--</li>-->

                <!--<li data-ng-show="settings.product_infinite_scroll == '1'">-->
                    <!--<span class="module-create-title">Scroll End Font</span>-->
                    <!--<span class="module-create-option">-->
                        <!--<j-opt-font data-ng-model="settings.product_infinite_scroll_finished_text_font"></j-opt-font>-->
                    <!--</span>-->
                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                <!--</li>-->

                    <!--<accordion data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                        <!--<accordion-group is-open="false">-->
                            <!--<accordion-heading>-->
                                <!--<div class="accordion-bar bar-level-1">Button Settings</div>-->
                            <!--</accordion-heading>-->
                            <!--<ul class="module-create-options">-->

                                <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                    <!--<span class="module-create-title">Button Text</span>-->
                                        <!--<span class="module-create-option">-->
                                            <!--<j-opt-text-lang data-ng-model="settings.product_infinite_scroll_button_text"></j-opt-text-lang>-->
                                        <!--</span>-->
                                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                <!--</li>-->

                                <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                    <!--<span class="module-create-title">Button Font</span>-->
                                        <!--<span class="module-create-option">-->
                                            <!--<j-opt-font data-ng-model="settings.product_infinite_scroll_button_font"></j-opt-font>-->
                                        <!--</span>-->
                                            <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                        <!--</li>-->

                                        <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                                    <!--<span class="module-create-title">Button Background Color</span>-->
                                        <!--<span class="module-create-option">-->
                                            <!--<j-opt-color data-ng-model="settings.product_infinite_scroll_button_bg"></j-opt-color>-->
                                        <!--</span>-->
                                                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                                <!--</li>-->

                                                <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                                    <!--<span class="module-create-title">Button Border Settings</span>-->
                                        <!--<span class="module-create-option">-->
                                            <!--<j-opt-border data-ng-model="settings.product_infinite_scroll_button_border"></j-opt-border>-->
                                        <!--</span>-->
                                                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                                <!--</li>-->

                                                <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                                    <!--<span class="module-create-title">Font Hover Color</span>-->
                                        <!--<span class="module-create-option">-->
                                            <!--<j-opt-color data-ng-model="settings.product_infinite_scroll_button_hover"></j-opt-color>-->
                                        <!--</span>-->
                                                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                                <!--</li>-->

                                                <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                                    <!--<span class="module-create-title">Background Hover Color</span>-->
                                        <!--<span class="module-create-option">-->
                                            <!--<j-opt-color data-ng-model="settings.product_infinite_scroll_button_bg_hover"></j-opt-color>-->
                                        <!--</span>-->
                                                    <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                                <!--</li>-->

                                        <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                                    <!--<span class="module-create-title">Border Hover Color</span>-->
                                        <!--<span class="module-create-option">-->
                                            <!--<j-opt-color data-ng-model="settings.product_infinite_scroll_button_border_hover"></j-opt-color>-->
                                        <!--</span>-->
                                            <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                        <!--</li>-->

                                        <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                            <!--<span class="module-create-title">Button Width <small>Padding Left/Right</small></span>-->
                                                <!--<span class="module-create-option">-->
                                                    <!--<j-opt-text data-ng-model="settings.product_infinite_scroll_button_width" class="journal-number-field"></j-opt-text>-->
                                                <!--</span>-->
                                            <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                        <!--</li>-->

                                        <!--<li data-ng-show="settings.product_infinite_scroll == '1' && settings.product_infinite_scroll_auto_trigger == '0'">-->
                                            <!--<span class="module-create-title">Button Height</span>-->
                                                <!--<span class="module-create-option">-->
                                                    <!--<j-opt-text data-ng-model="settings.product_infinite_scroll_button_height" class="journal-number-field"></j-opt-text>-->
                                                <!--</span>-->
                                            <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                                        <!--</li>-->
                                        <!--<li>-->
                                            <!--<span class="module-create-title">Active State Effect <small>Inner Shadow</small></span>-->
                                            <!--<span class="module-create-option">-->
                                                <!--<switch data-ng-model="settings.product_infinite_scroll_button_active_shadow">-->
                                                    <!--<switch-option key="inset 0 1px 10px rgba(0, 0, 0, 0.8)">ON</switch-option>-->
                                                    <!--<switch-option key="none">OFF</switch-option>-->
                                                <!--</switch>-->
                                            <!--</span>-->
                                            <!--<a href="#" target="_blank" class="journal-tip"> </a>-->
                                        <!--</li>-->

                            <!--</ul>-->
                        <!--</accordion-group>-->
                    <!--</accordion>-->

                <!--</ul>-->
        <!--</accordion-group>-->
    </accordion>
</div>
