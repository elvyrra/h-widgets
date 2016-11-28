<?php

namespace Hawk\Plugins\HWidgets;

class MetaData extends Widget {
    public function display() {
        $bgColor = '';

        if(!empty($this->avatar)) {
            $avatar = $this->avatar;
        }
        elseif(isset($this->name)) {
            $avatar = '';
            $initial = strtoupper(substr($this->name, 0, 1));
            $bgColor = Utils::strToColor($this->name);
        }
        else {
            $user = User::getById($this->userId);
            $avatar = $user->getProfileData('avatar');
            $initial = strtoupper(substr($user->username, 0, 1));

            $bgColor = Utils::strToColor($user->username);
        }

        $size = !empty($this->size) ? $this->size : '';
        $meta = !empty($this->meta) ? $this->meta : '';
        $description = !empty($this->description) ? $this->description : '';

        $r = hexdec(substr($bgColor, 0, 2));
        $g = hexdec(substr($bgColor, 2, 2));
        $b = hexdec(substr($bgColor, 4, 2));

        $bgColor = "rgba($r, $g, $b, 0.8)";

        $textR = 255 - $r;
        $textG = 255 - $g;
        $textB = 255 - $b;

        $color = "rgba($textR, $textG, $textB, 0.8)";

        return View::make($this->getPlugin()->getView('meta-data.tpl'), array(
            'avatar' => $avatar,
            'size' => $size,
            'bgColor' => $bgColor,
            'color' => $color,
            'meta' => $meta,
            'description' => $description,
            'initial' => $initial
        ));
    }
}