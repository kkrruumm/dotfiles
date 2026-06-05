;;; keybind-settings.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(unless (package-installed-p 'general)
  (package-install 'general))
(general-evil-setup)
(general-override-mode 1)

(general-create-definer spacebinds/leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

(spacebinds/leader-keys
 "b"  '(:ignore t :wk "buffer")
 "bb" '(switch-to-buffer :wk "Switch buffer")
 "bd" '(dashboard-open :wk "Open dashboard")
 "bi" '(ibuffer :wk "Ibuffer")
 "bk" '(kill-current-buffer :wk "Kill this buffer")
 "bn" '(next-buffer :wk "Next buffer")
 "bp" '(previous-buffer :wk "Previous buffer")
 "br" '(revert-buffer :wk "Reload buffer")
 "bx" '((lambda () (interactive) (kill-current-buffer) (evil-window-delete)) :wk "Buffer nuke")

 "w"  '(:ignore t :wk "window")
 "wc" '(evil-window-delete :wk "Close window")
 "wn" '(evil-window-new :wk "New window")
 "ws" '(evil-window-split :wk "Horizontal split")
 "wv" '(evil-window-vsplit :wk "Vertical split")

 "wh" '(evil-window-left  :wk "Window left")
 "wj" '(evil-window-down  :wk "Window down")
 "wk" '(evil-window-up    :wk "Window up")
 "wl" '(evil-window-right :wk "Window right")
 "ww" '(evil-window-next  :wk "Goto next window")

 ;; window motions
 "w <left>" '(evil-window-left :wk "Window left")
 "w <down>" '(evil-window-down :wk "Window down")
 "w <up>" '(evil-window-up :wk "Window up")
 "w <right>" '(evil-window-right :wk "Window right")
 "ww" '(evil-window-next :wk "Goto next window")

 "wH" '(buf-move-left  :wk "Buffer move left")
 "wJ" '(buf-move-down  :wk "Buffer move down")
 "wK" '(buf-move-up    :wk "Buffer move up")
 "wL" '(buf-move-right :wk "Buffer move right")

 "t"  '(:ignore t :wk "toggle")
 "tl" '(display-line-numbers-mode :wk "Toggle line numbers")
 "to" '(open-vterm-split :wk "Open terminal")
 "tt" '(visual-line-mode :wk "Toggle truncated lines")

 "d"  '(:ignore t :wk "dired")
 "dd" '(dired-do-delete :wk "Dired delete selection")
 "df" '(dired-create-directory :wk "Dired create directory")
 "dj" '(dired-jump :wk "Dired jump to current")
 "dn" '(dired-create-empty-file :wk "Dired create empty file")
 "do" '(dired :wk "Open dired")
 "dp" '((lambda () (interactive) (dired "~/Documents/projects")) :wk "Dired jump to projects")
 "dr" '(recentf-open-files :wk "Dired recently opened files")

 "g"  '(:ignore t :wk "magit")
 "gg" '(magit-status :wk "Magit status")

 "m"  '(:ignore t :wk "bookmarks")
 "mj" '(bookmark-jump :wk "Jump to bookmark")
 "ml" '(bookmark-bmenu-list :wk "List bookmarks")
 "mm" '(bookmark-set :wk "Set bookmark")

 "o"  '(:ignore t :wk "org")
 "oe" '(org-export-dispatch :wk "Org export")
 "of" '(org-shifttab :wk "Global fold/unfold")
 "ol" '(org-insert-link :wk "Org insert link")
 "oL" '(org-toggle-link-display :wk "Toggle raw links")
 "ot" '(org-toggle-checkbox :wk "Toggle checkboxes")

 "h" '(:ignore t :wk "fold")
 "hb" '(hs-hide-block :wk "Hide block")
 "hs" '(hs-show-block :wk "Unhide block")
 "hA" '(hs-hide-all :wk "Hide all blocks")
 "has" '(hs-show-all :wk "Unhide all blocks")

 "."       '(find-file :wk "Find file")
 "TAB TAB" '(comment-line :wk "Comment lines"))

;; double-escape exits the minibuffer (like C-g)
(global-set-key (kbd "ESC <escape>") (kbd "C-g"))

(provide 'keybind-settings)
;;; keybind-settings.el ends here
