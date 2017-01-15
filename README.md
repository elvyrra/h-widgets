# Hawk Widgets

This plugin provides a list of widgets that can be included in any plugin :

## CommentForm

This widget create a form to embed in your application plugins, to add a comment to the current page. Note that only
the displaying of the form is supported by this plugin, not the treatment, that is specific to each page where you embed this widget

### Demo :
{widget plugin="h-widgets" class="CommentForm" title="Leave a comment"}

### Integration
`{ widget plugin="h-widgets" class="CommentForm" [parameters] }`

The available parameters are :
* `id` : The form id. If not set, a unique id will be generated for the form
* `action` : The attribute action of the form
* `title` : The form title.
* `onsuccess` : The Javascript code to execute when the form is successfully submitted and treated.
    Note that you can use the variable `data` in the code you define to access the data returned by the server when sumitting the form

NOTE : The first space between '{' and 'widget' must not be set in your code, and is written in this page to not be parsed by Hawk view engine
<hr />

## MarkdownInput

This is not really a plugin, but a new type of input you can embed in your forms. To integrate it, instanciate it by coding :
```php
new \Hawk\Plugins\HWidgets\MarkdownInput(array(...))
```

<br />

## MetaData

This widget displays, for a given data, the avatar of the user that created this data, and the meta data you want.

### Demo :
{widget plugin="h-widgets" class="MetaData" meta="Guest 2 days ago" description="The message you leaves" userId="0"}


### Integration
`{ widget plugin="h-widgets" class="MetaData" [parameters] }`

The available parameters are :
* `userId` : The user to display the avatar's
* `avatar` : The URL of the avatar to display
* `name` : The name to get to display the initial (if avatar is not set)
* `meta` : The first line of data
* `description` : The content of the data to display
* `size` : The size of the avatar. It can take the value 'small', 'x-small', or not set to have the default size

NOTE : The first space between '{' and 'widget' must not be set in your code, and is written in this page to not be parsed by Hawk view engine
NOTE : At least one of the parameters `userId`, `avatar` or `name` must be set

# Changeset
## v1.2.2
* Manage the preview with jquery and not EMV, to be inserted in a form managed with EMV