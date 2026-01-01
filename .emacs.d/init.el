;;; init.el --- -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:
(require 'package)
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/")
    '("elpa" . "https://elpa.gnu.org/packages/"))
(package-initialize)

;; uncomment when adding packages or if this is a new emacs installation
;; (package-refresh-contents)

;; wacky performance!!
;; increase GC threshold for startup
(setq gc-cons-threshold 100000000)
(setq read-process-output-max 1048576)

;; disable resize frames since we're TUI only
(setq frame-inhibit-implied-resize t)

;; let there be highlight (this is only really here for lua)
(unless (package-installed-p 'treesit-auto)
  (package-install 'treesit-auto))

;; disabling treesit-auto so it doesn't try to pull in anything else post-lua
(add-to-list 'major-mode-remap-alist '(lua-mode . lua-ts-mode)) ;; this explicitly enables treesitter for lua, without treesitter lua is not well highlighted

;; this should be temporarily reenabled if this is a new emacs installation
;;(use-package treesit-auto
;;  :custom
;;  (treesit-auto-install 'prompt)
;;  :config
;;  (treesit-auto-add-to-auto-mode-alist 'all)
;;  (global-treesit-auto-mode))

;; less conservative highlighting level
(setq treesit-font-lock-level 4)

;; scope lines
(unless (package-installed-p 'indent-bars)
  (package-install 'indent-bars))
(use-package indent-bars
  :hook ((python-mode yaml-mode go-mode lua-mode nix-mode bash-mode sh-mode lua-ts-mode) . indent-bars-mode))

;; rainbow gamer vomit ultra nacho supreme
(unless (package-installed-p 'rainbow-mode)
  (package-install 'rainbow-mode))
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1)

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
(setq doom-modeline-major-mode-color-icon nil)

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
(evil-set-undo-system 'undo-redo)
(evil-mode 1)
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

(add-hook 'evil-visual-state-entry-hook ;; this disables global-hl-line-mode when entering visual mode to improve the clarity of selection
          (lambda () (global-hl-line-mode -1)))

(add-hook 'evil-visual-state-exit-hook ;; same as above but reenable upon leaving visual mode
          (lambda () (global-hl-line-mode 1)))

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

;; dired recent files
(recentf-mode 1)
(setq recentf-max-saved-items 50)

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
 ;; window splits
 "wc" '(evil-window-delete :wk "Close window")
 "wn" '(evil-window-new :wk "New window")
 "ws" '(evil-window-split :wk "Horizontal split window")
 "wv" '(evil-window-vsplit :wk "Vertical split window")

 ;; window motions
 "w <left>" '(evil-window-left :wk "Window left")
 "w <down>" '(evil-window-down :wk "Window down")
 "w <up>" '(evil-window-up :wk "Window up")
 "w <right>" '(evil-window-right :wk "Window right")
 "ww" '(evil-window-next :wk "Goto next window")

 ;; more window motions but for hjkl
 "wh" '(evil-window-left :wk "Window left")
 "wj" '(evil-window-down :wk "Window down")
 "wk" '(evil-window-up :wk "Window up")
 "wl" '(evil-window-right :wk "Window right")

 ;; move windows
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
 "dj" '(dired-jump :wk "Dired jump to current")
 "dr" `(recentf-open-files :wk "Dired recently opened files")
 "dn" `(dired-create-empty-file :wk "Dired create empty file")
 "df" `(dired-create-directory :wk "Dired create directory")
 "dd" `(dired-do-delete :wk "Dired delete selection")
 "do" `(dired :wk "Open dired")
 
 ;; miscellaneous
 "." '(find-file :wk "Find file")
 "TAB TAB" '(comment-line :wl "Comment lines")
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(create-lockfiles nil)
 '(custom-safe-themes
   '("4b53f1da21cbd4e649ad3328f38798efb1473a21132e0fe6407b34751cf8c0b0"
     default))
 '(delete-auto-save-files t)
 '(find-file-visit-truename t)
 '(large-file-warning-threshold nil)
 '(make-backup-files nil)
 '(package-selected-packages nil))

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

(provide `init)
;;; init.el ends here

