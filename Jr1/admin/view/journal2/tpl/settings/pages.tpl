<div class="sticky">
    <div class="module-header">
        <div class='module-name'>Settings<span>Pages</span></div>

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

<div class="module-body">
    <div class="accordion-bar bar-level-0 bar-expand" >
        <a data-ng-click="toggleAccordion(true)" class="hint--top" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(false)" class="hint--top" data-hint="Collapse All"><i class="collapse-icon"></i></a>
        <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="accordion.close_others" /></label>
    </div>
    <accordion id="main-accordion" close-others="accordion.close_others">
        <accordion-group is-open="accordion.accordions[0]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Tables</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Font Color</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.shopping_table_color"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Background Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_table_bg_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Links Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_table_link_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Links Hover Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_table_link_hover_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Content Border Settings</span>
                                        <span class="module-create-option">
                                            <j-opt-border data-ng-model="settings.shopping_table_border"></j-opt-border>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Heading Font Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_table_header_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Heading Background</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_table_header_bg"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Image Border Settings <small>Shopping Cart, Wishlist, Compare</small></span>
                                        <span class="module-create-option">
                                            <j-opt-border data-ng-model="settings.shopping_image_border"></j-opt-border>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Divider Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_divider"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Divider Style</span>
                                        <span class="module-create-option">
                                            <switch data-ng-model="settings.shopping_divider_style">
                                                <switch-option key="solid">Solid</switch-option>
                                                <switch-option key="dashed">Dashed</switch-option>
                                                <switch-option key="dotted">Dotted</switch-option>
                                            </switch>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

            </ul>
        </accordion-group>
        <accordion-group is-open="accordion.accordions[1]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Account Page</div>
            </accordion-heading>
            <ul class="module-create-options">

                <li>
                    <span class="module-create-title">Login Background</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.login_screen_bg"></j-opt-color>
                                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Login Text Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.login_screen_text_font_color"></j-opt-font>
                                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Login Border Settings</span>
                                    <span class="module-create-option">
                                        <j-opt-border data-ng-model="settings.login_screen_border"></j-opt-border>
                                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Login Buttons Divider</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.login_screen_divider"></j-opt-color>
                                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Container Padding</span>
                                    <span class="module-create-option">
                                        <j-opt-text data-ng-model="settings.login_screen_padding" class="journal-number-field"></j-opt-text>
                                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>


            </ul>
        </accordion-group>
        <!--Shopping Cart Page-->
        <accordion-group is-open="accordion.accordions[2]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Shopping Cart Page</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Heading Font</span>
                                        <span class="module-create-option">
                                            <j-opt-font data-ng-model="settings.shopping_action_header"></j-opt-font>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Heading Background</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_action_header_bg"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Action Area Font Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_action_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Action Area Background Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_action_bg"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Action Area Border</span>
                                        <span class="module-create-option">
                                            <j-opt-border data-ng-model="settings.shopping_action_border"></j-opt-border>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Action Area Spacing <small>Margin Top</small></span>
                                        <span class="module-create-option">
                                            <j-opt-text data-ng-model="settings.shopping_action_margin" class="journal-number-field"></j-opt-text>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>


                <li>
                    <span class="module-create-title">Option Font</span>
                                        <span class="module-create-option">
                                            <j-opt-font data-ng-model="settings.shopping_option_font"></j-opt-font>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Option Font Hover Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_option_hover_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Option Background Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_option_bg"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Option Background Hover</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_option_bg_hover"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Option Divider Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.shopping_option_divider"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

            </ul>
        </accordion-group>
        <!--Checkout Page-->
        <accordion-group is-open="accordion.accordions[3]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Checkout Page</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Background Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.checkout_bg"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Container Padding</span>
                                        <span class="module-create-option">
                                            <j-opt-text data-ng-model="settings.checkout_padding" class="journal-number-field"></j-opt-text>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Heading Font</span>
                                        <span class="module-create-option">
                                            <j-opt-font data-ng-model="settings.checkout_heading_font"></j-opt-font>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Heading Background Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.checkout_heading_bg_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Heading Divider Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.checkout_heading_divider_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Heading Divider Type</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.checkout_heading_divider_type">
                            <switch-option key="solid">Solid</switch-option>
                            <switch-option key="dashed">Dashed</switch-option>
                            <switch-option key="dotted">Dotted</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Checkout Border Settings</span>
                                        <span class="module-create-option">
                                            <j-opt-border data-ng-model="settings.checkout_border"></j-opt-border>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Confirm Order Font Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.checkout_confirm_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Confirm Order Background Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.checkout_confirm_bg_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Confirm Order Divider Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.checkout_confirm_divider_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Colorbox Text Color <small>Popups for Terms and Conditions, etc.</small></span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.colorbox_text_color"></j-opt-color>
                                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
            </ul>
        </accordion-group>
        <!--Action Buttons-->
        <accordion-group is-open="accordion.accordions[4]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Action Buttons</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Action Buttons Background</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.actions_bg_color"></j-opt-color>
                                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Action Buttons Border</span>
                            <span class="module-create-option">
                                <j-opt-border data-ng-model="settings.actions_border"></j-opt-border>
                            </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Action Buttons Padding <small>Top-Bottom / Left-Right</small></span>
                            <span class="module-create-option">
                                <j-opt-text data-ng-model="settings.actions_padding_tb" class="journal-number-field"></j-opt-text> x
                                <j-opt-text data-ng-model="settings.actions_padding_lr" class="journal-number-field"></j-opt-text>
                            </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
            </ul>
        </accordion-group>

        <!--Site Map-->
        <accordion-group is-open="accordion.accordions[4]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Site Map</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Top Category Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.site_map_top"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Sub Category Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.site_map_sub"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Background Color</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.site_map_bg"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Background Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.site_map_border"></j-opt-border>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Background Padding</span>
                        <span class="module-create-option">
                            <j-opt-text data-ng-model="settings.site_map_padding" class="journal-number-field"></j-opt-text>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

            </ul>
        </accordion-group>
            <!--BLOG MANAGER-->
        <accordion-group is-open="accordion.accordions[5]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Blog Manager Extension</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Blog Post Title Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.blog_manager_post_title"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
            </ul>
        </accordion-group>
</accordion>
</div>
