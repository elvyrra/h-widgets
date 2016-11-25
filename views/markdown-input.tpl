<div id="{{ $input->id }}-wrapper">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
            <a href="#{{ $input->id }}-write" role="tab" data-toggle="tab">{text key="h-widgets.markdown-tab-content"}</a>
        </li>
        <li role="presentation">
            <a href="#{{ $input->id }}-preview" role="tab" data-toggle="tab">{text key="h-widgets.markdown-tab-preview"}</a>
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
                        e-value="content">{{$input->value}}</textarea>
        </div>
        <div role="tabpanel" class="tab-pane tab-pane-preview" id="{{ $input->id }}-preview" e-html="parsed">
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

    require(['app', 'emv', 'md'], function(app, EMV, md) {
        const converter = new md.Converter();

        const model = new EMV({
            data : {
                content : document.getElementById('{{ $input->id }}').value
            },
            computed : {
                parsed : function() {
                    return this.content ? converter.makeHtml(this.content) : '<i>Nothing to preview</i>';
                }
            }
        });

        model.$apply(document.getElementById('{{ $input->id }}-wrapper'));
    });
</script>