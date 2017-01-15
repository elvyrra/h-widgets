<div id="{{ $input->id }}-wrapper">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
            <a href="#{{ $input->id }}-write" role="tab" data-toggle="tab">{text key="h-widgets.markdown-tab-content"}</a>
        </li>
        <li role="presentation">
            <a href="#{{ $input->id }}-preview" role="tab" data-toggle="tab">{text key="h-widgets.markdown-tab-preview"}</a>
        </li>

        <li class="pull-right markdown-shortcuts">
            {icon icon="bold" size="lg" class="icon-fw" onclick="this.$model.bold()"}
            {icon icon="italic" size="lg" class="icon-fw" onclick="this.$model.italic()"}
            {icon icon="list-ul" size="lg" class="icon-fw" onclick="this.$model.listUl()"}
            {icon icon="list-ol" size="lg" class="icon-fw" onclick="this.$model.listOl()"}
            {icon icon="code" size="lg" class="icon-fw" onclick="this.$model.code()"}
        </li>
    </ul>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active tab-pane-write" id="{{ $input->id }}-write">
            <textarea   {foreach($input::$attr as $attr => $type)}
                            {if($attr != 'value' && !empty($input->$attr))}
                                {if($type == "bool")}
                                    {{ $attr }}
                                {elseif($type == "html")}
                                    {{ $attr }}="{{{ $input->$attr }}}"
                                {else}
                                    {{ $attr }}="{{ $input->$attr }}"
                                {/if}
                            {/if}
                        {/foreach}

                        {foreach($input->attributes as $key => $value)}
                            {if($value !== null)} {{ $key }}="{{{ $value }}}" {/if}
                        {/foreach}
                        >{{$input->value}}</textarea>
        </div>
        <div role="tabpanel" class="tab-pane tab-pane-preview" id="{{ $input->id }}-preview">
        </div>
    </div>
</div>

<script type="text/javascript">
    'use strict';
    require.config({
        paths : {
            md : '{{ Plugin::get("h-widgets")->getJsUrl("showdown.min.js") }}'
        },
        shim : {
            md : {
                exports : ['showdown']
            }
        }
    });

    require(['app', 'jquery', 'md'], function(app, $, md) {
        const converter = new md.Converter();
        const textarea = document.getElementById('{{ $input->id }}');
        const preview = document.getElementById('{{ $input->id }}-preview');
        const wrapper = document.getElementById('{{ $input->id }}-wrapper');

        /**
         * This class manages the dynamic aspect of the markdown input
         */
        class Markdown {
            /**
             * Constructor
             */
            init() {
                $(wrapper).find('*').each((index, item) => {
                    item.$model = this;
                });

                $(textarea).on('change', function() {
                    const content = $(this).val();
                    const parsed = content ? converter.makeHtml(content) : '<i>Nothing to preview</i>';

                    $(preview).html(parsed);
                });

                $(textarea).trigger('change');
            }

            /**
             * Add string at a specific position
             * @param {int} position The position where to insert the string
             * @param {string} str      The string to inser
             * @param {bool} before   Set true to insert the string before the position, false to insert it after
             */
            addStrTo(position, str) {
                let content = $(textarea).val();

                content = content.slice(0, position) + str + content.slice(position);

                $(textarea).val(content).trigger('change');
            }

            /**
             * Get the current selection
             * @returns {Object} The current selection
             */
            getSelection() {
                return {
                    start : textarea.selectionStart,
                    end : textarea.selectionEnd
                };
            }

            /**
             * Wrap the selection with characters
             * @param  {string} before THe string to insert before the selection
             * @param  {string} after  The string to insert after the selection
             */
            wrapSelection(before, after) {
                const selection = this.getSelection();

                this.addStrTo(selection.end, before);
                this.addStrTo(selection.start, after);
            }


            /**
             * Add a string at the start of the current selected line
             * @param {string} str The string to insert at the start of the line
             */
            addAtLineStart(str) {
                const selection = this.getSelection;
                let start = $(textarea).val().lastIndexOf('\n', selection.start) + 1;

                this.addStrTo(start, str);
            }


            /**
             * Set the selection bold
             */
            bold() {
                this.wrapSelection('**', '**');
            }

            /**
             * Set the selection italic
             */
            italic() {
                this.wrapSelection('*', '*');
            }


            /**
             * Set a list
             */
            listUl() {
                this.addAtLineStart('* ');
            }

            /**
             * Set an ordered list
             */
            listOl() {
                this.addAtLineStart('1. ');
            }

            /**
             * Set the selection as code
             */
            code() {
                this.wrapSelection('`', '`');
            }
        }

        const model = new Markdown();

        model.init();
    });
</script>