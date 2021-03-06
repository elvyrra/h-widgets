<?php

namespace Hawk\Plugins\HWidgets;

/**
 * This widget displays a form to add a comment, that supports makdown
 */
class CommentForm extends Widget {
    public $cancelButton;

    public function __construct($param = array()) {
        parent::__construct($param);

        $this->attributes = array();

        foreach($param as $key => $value)  {
            if(!in_array($key, array('id', 'action', 'onsuccess'))) {
                $this->attributes[$key] = $value;
            }
        }
    }

    public function display() {
        $param = array(
            'id' => empty($this->id) ? uniqid() : $this->id,
            'class' => 'h-widgets-comment-form',
            'action' => empty($this->action) ? '#' : $this->action,
            'attributes' => $this->attributes,
            'fieldsets' => array(
                'form' => array(
                    new MarkdownInput(array(
                        'name' => 'content',
                        'attributes' => array(
                            'e-markdown' => 'true'
                        ),
                        'rows' => 5,
                        'required' => true
                    )),
                    new HiddenInput(array(
                        'name' => 'userId',
                        'value' => App::session()->getUser()->id
                    )),

                    new HiddenInput(array(
                        'name' => 'ctime',
                        'value' => time()
                    ))
                ),

                'submits' => array(
                    new SubmitInput(array(
                        'name'  => 'comment',
                        'icon' => 'comment',
                        'value' => Lang::get($this->_plugin . '.valid-comment-btn'),
                        'nl' => true
                    )),

                    $this->cancelButton ? $this->cancelButton : null
                )
            ),
            'onsuccess' => empty($this->onsuccess) ? '' : $this->onsuccess
        );

        $form = new Form($param);

        $this->addCss($this->getPlugin()->getCssUrl('comment-form.less'));

        return View::make($this->getPlugin()->getView('comment-form.tpl'), array(
            'form' => $form,
            'title' => empty($this->title) ? '' : $this->title
        ));
    }
}