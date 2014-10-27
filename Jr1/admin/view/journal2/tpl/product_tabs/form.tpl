<div class="sticky">
<div class="module-header">
    <div class='module-name'>Product Tabs <span>Edit Tab</span></div>
    <div class="module-buttons">
        <a href="<?php echo $base_href;?>#/module/{{module_type}}/all/{{module_id}}" data-ng-show="module_id != null" class="btn blue">All Tabs</a>
        <a data-ng-click="save($event)" class="btn green">Save</a>
        <a href="<?php echo $base_href;?>#/module/{{module_type}}/all" data-ng-show="module_id == null" class="btn red">Cancel</a>
        <a data-ng-click="delete($event)" data-ng-show="module_id != null" class="btn red">Delete</a>
    </div>
</div>
</div>
<div class="module-body module-form">
    <div class="accordion-bar bar-level-0 bar-expand" >
    </div>
    <accordion close-others="false">
        <accordion-group is-open="true">
            <accordion-heading>
                <div class="accordion-bar bar-level-0" data-ng-click="$event.stopPropagation()">General Options</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Module Name</span>
                    <span class="module-create-option">
                         <input type="text" class="journal-input" data-ng-model="module_data.module_name" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Tab Name</span>
                    <span class="module-create-option">
                        <j-opt-text-lang data-ng-model="module_data.name"></j-opt-text-lang>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Global Tab</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.global">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="module_data.global == 0">
                    <span class="module-create-title">Products</span>
                    <span class="module-create-option">
                        <ul class="simple-list">
                            <li data-ng-repeat="product in module_data.products">
                                <product-search model="product.data"></product-search>
                                <a href="javascript:;" data-ng-click="removeProduct($index)" class="btn red delete">X</a>
                            </li>
                        </ul>
                        <a href="javascript:;" data-ng-click="addProduct()" class="btn blue add-product">Add</a>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Position</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.position">
                            <switch-option key="tab">Tabs</switch-option>
                            <switch-option key="image">Image</switch-option>
                            <switch-option key="desc">Options</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="module_data.position === 'desc'">
                    <span class="module-create-title">Position</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.option_position">
                            <switch-option key="top">Top</switch-option>
                            <switch-option key="bottom">Bottom &nbsp;&nbsp;&nbsp;</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Status</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.status">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Sort Order</span>
                    <span class="module-create-option">
                         <input type="text" class="journal-input journal-sort" data-ng-model="module_data.sort_order" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Add Icon</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.icon_status">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="module_data.icon_status == 1">
                    <span class="module-create-title">Icon</span>
                    <span class="module-create-option">
                        <icon-select data-ng-model="module_data.icon"></icon-select>
                    </span>
                </li>

                <li data-ng-show="module_data.icon_status == 1">
                    <span class="module-create-title">Icon Container Background</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="module_data.icon_bg_color"></j-opt-color>
                    </span>
                </li>
                <li data-ng-show="module_data.icon_status == 1">
                    <span class="module-create-title">Icon Container Border</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="module_data.icon_border"></j-opt-border>
                    </span>
                </li>
                <li data-ng-show="module_data.icon_status == 1">
                    <span class="module-create-title">Icon Container Dimensions</span>
                    <span class="module-create-option">
                        <input type="text" class="journal-number-field" data-ng-model="module_data.icon_width" /> x <input type="text" class="journal-number-field" data-ng-model="module_data.icon_height" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Tab Content</span>
                    <span class="module-create-option">
                        <ck-editor data-ng-model="module_data.content"></ck-editor>
                    </span>
                </li>
            </ul>
        </accordion-group>
    </accordion>
</div>
