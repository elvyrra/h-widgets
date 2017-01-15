<?php
/**
 * WysiwygInput.php
 *
 * @author  Elvyrra SAS
 * @license http://rem.mit-license.org/ MIT
 */

namespace Hawk\Plugins\HWidgets;

/**
 * This class describes the wysiwyg fields in forms. Wysiwyg behavior is computed by CKEditor library
 * http://ckeditor.com/
 *
 * @package Form\Input
 */
class MarkdownInput extends TextareaInput{
    const TYPE = "markdown";

    /**
     * The rows number
     * @var integer
     */
    public $rows = 5;

    /**
     * Constructor
     *
     * @param array $param The input parameters. This arguments is an associative array where each key is the name of a property of this class
     */
    public function __construct($param){
        $this->placeholder = Lang::get('h-widgets.markdown-placeholder');

        parent::__construct($param);


        $plugin = Plugin::get('h-widgets');

        $this->tpl = $plugin->getView('markdown-input.tpl');

        Controller::current()->addCss($plugin->getCssUrl('markdown-input.less'));
    }
}
