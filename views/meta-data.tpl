<div class="media meta-data-widget">
    <div class="media-left">
        {if($avatar)}
            <img src="{{ $avatar}}" class="user-avatar {{ $size }}" />
        {else}
            <span class="user-avatar {{ $size }}" style="background-color : #{{ $bgColor }}; color : #{{ $color }}">{{ $initial }}</i>
        {/if}
    </div>
    <div class="media-body">
        <p class="meta-data">{{ $meta }}</p>
        {if($description)}
            <p class="content">{{ $description }}</p>
        {/if}
    </div>
</div>