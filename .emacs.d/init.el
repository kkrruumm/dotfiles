;;; init.el --- -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; uncomment when adding packages or etc
;;(package-refresh-contents)

;; gitgutter
(unless (package-installed-p 'git-gutter)
  (package-install 'git-gutter))
(global-git-gutter-mode +1)

;; buffer-move
(unless (package-installed-p 'buffer-move)
  (package-install 'buffer-move))
(require 'buffer-move)

;; flycheck
(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; pretty bar
(unless (package-installed-p 'doom-modeline)
  (package-install 'doom-modeline))
(doom-modeline-mode 1)
(setq doom-modeline-total-line-number 1)

;; which-key
(unless (package-installed-p 'which-key)
  (package-install 'which-key))
(which-key-mode 1)

;; hl-todo
(unless (package-installed-p 'hl-todo)
  (package-install 'hl-todo))
(global-hl-todo-mode)

;; evil mode
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

;; general
(unless (package-installed-p 'general)
  (package-install 'general))
(general-evil-setup)

;; configure general
(general-create-definer spacebinds/leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

;; language support
(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))

(unless (package-installed-p 'lua-mode)
  (package-install 'lua-mode))

(unless (package-installed-p 'nix-mode)
  (package-install 'nix-mode))

;; configure spacebinds
(spacebinds/leader-keys
 ;; buffer binds
 "b" '(:ignore t :wk "buffer")
 "bb" '(switch-to-buffer :wk "Switch buffer")
 "bi" '(ibuffer :wk "Ibuffer")
 "bk" '(kill-current-buffer :wk "Kill this buffer")
 "bn" '(next-buffer :wk "Next buffer")
 "bp" '(previous-buffer :wk "Previous buffer")
 "br" '(revert-buffer :wk "Reload buffer")

 ;; window binds
 "w" '(:ignore t :wk "Windows")
 ;; Window splits
 "wc" '(evil-window-delete :wk "Close window")
 "wn" '(evil-window-new :wk "New window")
 "ws" '(evil-window-split :wk "Horizontal split window")
 "wv" '(evil-window-vsplit :wk "Vertical split window")
 ;; Window motions
 "w <left>" '(evil-window-left :wk "Window left")
 "w <down>" '(evil-window-down :wk "Window down")
 "w <up>" '(evil-window-up :wk "Window up")
 "w <right>" '(evil-window-right :wk "Window right")
 "ww" '(evil-window-next :wk "Goto next window")
 
 ;; Move Windows
 "wH" '(buf-move-left :wk "Buffer move left")
 "wJ" '(buf-move-down :wk "Buffer move down")
 "wK" '(buf-move-up :wk "Buffer move up")
 "wL" '(buf-move-right :wk "Buffer move right")
 
 ;; toggle binds
 "t" '(:ignore t :wk "Toggle")
 "tl" '(display-line-numbers-mode :wk "Toggle line numbers")
 "tt" '(visual-line-mode :wk "Toggle truncated lines")

 ;; dired
 "d" '(:ignore t :wk "Dired")
 "dd" '(dired :wk "Open dired")
 "dj" '(dired-jump :wk "Dired jump to current")

 ;; miscellaneous
 "." '(find-file :wk "Find file")
 "TAB TAB" '(comment-line :wl "Comment lines")
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(make-backup-files nil) ;; disables annoying `file~`
 '(auto-save-default nil) ;; disables annoying `#file#`
 `(delete-auto-save-files t)
 `(create-lockfiles nil)
 `(find-file-visit-truename t) ;; resolve symlinks
 `(large-file-warning-threshold nil) ;; don't warn on large files
 '(custom-safe-themes
   '("4b53f1da21cbd4e649ad3328f38798efb1473a21132e0fe6407b34751cf8c0b0"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:inherit nil)))))

(electric-pair-mode 1) ;; auto pairs
;;(electric-indent-mode -1) ;; disable indenting

;; visual tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-hl-line-mode 1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(set-face-attribute 'font-lock-comment-face nil
		    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
		    :slant 'italic)
(setq-default line-spacing 0.15)

;; actually scroll instead of changing pages
(setq scroll-conservatively 101)

;; fuck tab characters
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default standard-indent 4)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'bummer t)