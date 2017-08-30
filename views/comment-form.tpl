{assign name="formContent"}
    {if($title)}
        <h3>{{ $title }}</h3>
    {/if}

    {{ $form->fieldsets['form'] }}
    {{ $form->fieldsets['submits'] }}

    <div class="clearfix"></div>
{/assign}

{form id="{$form->id}" content="{$formContent}"}
