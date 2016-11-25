<?php

namespace Hawk\Plugins\HWidgets;

/**
 * This widget displays a form to add a comment, that supports makdown
 */
class CommentForm extends Widget {
    public function display() {
        $param = array(
            'id' => empty($this->id) ? uniqid() : $this->id,
            'class' => 'h-widgets-comment-form',
            'action' => empty($this->action) ? '#' : $this->action,
            'fieldsets' => array(
                'form' => array(
                    new MarkdownInput(array(
                        'name' => 'content',
                        'attributes' => array(
                            'e-markdown' => 'true'
                        ),
                        'rows' => 5
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
                    ))
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